# frozen_string_literal: true

#!/usr/bin/env ruby

# manage.rb — single entry point for all mac llama-cpp-vulkan operations
#
# Usage: ruby mac/bin/manage.rb <command>
#        ruby mac/bin/manage.rb --ok   # bring up prebuilt image, print true/false

require "net/http"
require "json"

BIN_DIR  = File.expand_path(__dir__)
MAC_DIR  = File.expand_path("../..", __dir__)

MODEL_FILE = "Llama-3.2-1B-Instruct-Q4_K_M.gguf"
MODEL_PATH = File.join(Dir.home, "models", MODEL_FILE)
API_URL    = "http://localhost:8080/health"
CONTAINER  = "llama-cpp-vulkan"
PORT       = 8080

COMMANDS = {
  "install"  => { script: "install.sh",       desc: "Install podman + krunkit via Homebrew" },
  "start"    => { script: "start.sh",          desc: "Init and start the libkrun podman machine" },
  "verify"   => { script: "verify.sh",         desc: "Verify GPU (/dev/dri) is accessible in the VM" },
  "pull"     => { script: "pull.sh",           desc: "Pull pre-built image from ghcr.io" },
  "build"    => { script: "build.sh",          desc: "Build the container image from source" },
  "download" => { script: "download_model.sh", desc: "Download #{MODEL_FILE}" },
  "run"      => { script: "run.sh",            desc: "Run the llama-server container on port #{PORT} (foreground)" },
  "setup"    => { script: nil,                 desc: "Full setup: install → start → verify → pull → download → run" }
}.freeze

def run_script(name)
  path = File.join(BIN_DIR, name)
  abort "  ERROR: script not found: #{path}" unless File.exist?(path)
  puts "\n==> #{name}"
  system("bash", path) || abort("  FAILED: #{name} exited with error")
end

def api_ok?
  uri = URI(API_URL)
  res = Net::HTTP.get_response(uri)
  res.is_a?(Net::HTTPSuccess)
rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT, SocketError
  false
end

def wait_for_api(timeout: 120, interval: 3)
  deadline = Time.now + timeout
  until Time.now > deadline
    return true if api_ok?
    sleep interval
  end
  false
end

def container_running?
  `podman ps --filter name=llama-server --format '{{.Names}}'`.strip == "llama-server"
end

def stop_existing_container
  if container_running?
    puts "==> stopping existing llama-server container"
    system("podman", "stop", "llama-server")
  end
end

def restart_machine
  puts "==> restarting podman machine to clear stale proxy"
  system("podman machine stop")
  system("podman machine start")
end

def start_container
  system(
    "podman", "run", "--rm", "-d",
    "--device", "/dev/dri",
    "-v", "#{Dir.home}/models:/models",
    "-p", "#{PORT}:#{PORT}",
    "--name", "llama-server",
    CONTAINER,
    "-m", "/models/#{MODEL_FILE}",
    "--host", "0.0.0.0",
    "--port", PORT.to_s,
    "--n-gpu-layers", "99"
  )
end

def run_ok
  Dir.chdir(MAC_DIR)

  %w[install start pull download].each { |step| run_script(COMMANDS[step][:script]) }

  stop_existing_container

  puts "\n==> starting container (detached)"
  unless start_container
    puts "==> container start failed — restarting machine and retrying"
    restart_machine
    start_container || abort("  FAILED: could not start container after machine restart")
  end

  puts "==> waiting for API at #{API_URL}"
  result = wait_for_api
  puts result ? "true" : "false"
  exit(result ? 0 : 1)
end

def print_help
  puts "Usage: ruby mac/bin/manage.rb <command>"
  puts "       ruby mac/bin/manage.rb --ok"
  puts
  puts "Commands:"
  COMMANDS.each { |cmd, meta| puts "  #{cmd.ljust(10)}  #{meta[:desc]}" }
  puts "  #{"--ok".ljust(10)}  Bring up prebuilt image end-to-end; print true/false"
  puts
  puts "Examples:"
  puts "  ruby mac/bin/manage.rb --ok       # automated bring-up + health check"
  puts "  ruby mac/bin/manage.rb setup      # full interactive setup"
  puts "  ruby mac/bin/manage.rb run        # start the server (foreground)"
  puts "  ruby mac/bin/manage.rb verify     # check GPU access"
end

command = ARGV[0]

case command
when nil, "help", "--help"
  print_help
  exit 0
when "--ok"
  run_ok
else
  unless COMMANDS.key?(command)
    warn "Unknown command: #{command}"
    warn
    print_help
    exit 1
  end

  Dir.chdir(MAC_DIR)

  if command == "setup"
    %w[install start verify pull download run].each { |step| run_script(COMMANDS[step][:script]) }
  else
    run_script(COMMANDS[command][:script])
  end
end
