# frozen_string_literal: true

# chat.rb — detect platform, bring up the LLM container, start a chat session
#
# Usage: ruby bin/chat.rb

require "net/http"
require "json"
require_relative "detect"

REPO_ROOT   = File.expand_path("..", __dir__)  # lib/ -> repo root
API_BASE    = "http://localhost:8080/v1"
COMPLETIONS = "#{API_BASE}/chat/completions"
MODEL       = "llama"

def bring_up(platform, manage_script)
  unless File.exist?(manage_script)
    abort "No manage script for platform :#{platform} — expected #{manage_script}"
  end
  puts "Platform: #{platform}"
  puts "Starting container via #{manage_script} --ok ..."
  puts
  result = system("ruby", manage_script, "--ok")
  result && $?.exitstatus == 0
end

def chat_completion(history)
  uri  = URI(COMPLETIONS)
  http = Net::HTTP.new(uri.host, uri.port)
  http.read_timeout = 120

  req = Net::HTTP::Post.new(uri, "Content-Type" => "application/json")
  req.body = JSON.generate(model: MODEL, messages: history)

  res = http.request(req)
  body = JSON.parse(res.body)
  body.dig("choices", 0, "message", "content")
rescue Errno::ECONNREFUSED
  nil
end

def run_chat
  platform      = Detect.platform
  manage_script = Detect.manage_script(REPO_ROOT)

  unless bring_up(platform, manage_script)
    puts "false"
    abort "Container failed to start."
  end

  puts "true"
  puts
  puts "Llama-3.2-1B-Instruct is ready. Type 'exit' or Ctrl-D to quit."
  puts

  history = []

  loop do
    print "chat> "
    input = $stdin.gets
    break if input.nil?

    input = input.chomp
    next if input.empty?
    break if input == "exit"

    history << { role: "user", content: input }

    response = chat_completion(history)

    if response.nil?
      puts "(error: no response from server)"
      history.pop
      next
    end

    history << { role: "assistant", content: response }
    puts
    puts response
    puts
  end

  puts "Goodbye."
end

run_chat
