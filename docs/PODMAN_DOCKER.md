ericlaquer@Erics-MacBook-Air llama-1b-container % podman machine stop; podman machine start
Machine "podman-machine-default" stopped successfully
Starting machine "podman-machine-default"

This machine is currently configured in rootless mode. If your containers
require root permissions (e.g. ports < 1024), or if you run into compatibility
issues with non-podman clients, you can switch using the following command:

        podman machine set --rootful

API forwarding listening on: /var/folders/yk/0l4pzkk14jn9kpnlgvm86w240000gn/T/podman/podman-machine-default-api.sock

Another process was listening on the default Docker API socket address.
You can still connect Docker API clients by setting DOCKER_HOST using the
following command in your terminal session:

        export DOCKER_HOST='unix:///var/folders/yk/0l4pzkk14jn9kpnlgvm86w240000gn/T/podman/podman-machine-default-api.sock'

Machine "podman-machine-default" started successfully
ericlaquer@Erics-MacBook-Air llama-1b-container %