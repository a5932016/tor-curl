# Tor-Curl

A Docker-based tool for making HTTP requests through the Tor network with multi-threading support. This tool allows you to send requests through Tor's anonymous network, making it useful for testing, web scraping, or accessing websites through different exit nodes.

## Features

- 🔒 **Tor Network Integration**: All requests are routed through the Tor network for anonymity
- 🚀 **Multi-threading Support**: Run multiple concurrent requests across different threads
- 🐳 **Docker-based**: Easy deployment and isolation using Docker containers
- 🔄 **Automatic Tor Restart**: Each request uses a fresh Tor circuit for different exit nodes
- 🌐 **Realistic Headers**: Uses realistic browser headers to avoid detection

## Prerequisites

- Docker installed on your system
- Bash shell (for running the scripts)

## Installation

1. Clone this repository:
```bash
git clone https://github.com/a5932016/tor-curl.git
cd tor-curl
```

2. Build the Docker image:
```bash
./install.sh
```

Or manually:
```bash
docker build -t tor-curl .
```

## Usage

### Basic Usage

Run a single request through Tor:
```bash
./run.sh "https://example.com" 1 1
```

### Multi-threaded Usage

Run multiple concurrent requests:
```bash
./run.sh "https://example.com" 10 5
```

### Parameters

The `run.sh` script takes three parameters:

1. **URL** (required): The target URL to request
2. **COUNT** (optional, default: 1): Number of requests per thread
3. **THREAD** (optional, default: 1): Number of concurrent threads

### Examples

```bash
# Single request
./run.sh "https://httpbin.org/ip" 1 1

# 5 requests through 3 threads (15 total requests)
./run.sh "https://httpbin.org/ip" 5 3

# 10 requests through 1 thread
./run.sh "https://example.com" 10 1
```

## How It Works

1. **Tor Initialization**: Each request starts a fresh Tor daemon
2. **Circuit Building**: Waits for Tor to establish a connection through the network
3. **HTTP Request**: Makes the HTTP request through the Tor SOCKS5 proxy
4. **Circuit Rotation**: Kills the Tor process to force a new circuit for the next request
5. **Multi-threading**: Multiple Docker containers run concurrently for parallel requests

## Technical Details

- **Base Image**: Alpine Linux (lightweight)
- **Tor Version**: Latest from Alpine repositories
- **Proxy**: SOCKS5 on localhost:9050
- **User Agent**: Chrome on macOS (configurable in entrypoint.sh)
- **Headers**: Standard browser headers for realistic requests

## Security Considerations

⚠️ **Important**: This tool is designed for legitimate testing and research purposes only. Please ensure you:

- Comply with the target website's terms of service
- Respect rate limits and robots.txt
- Use responsibly and ethically
- Don't use for malicious purposes

## Troubleshooting

### Tor Connection Issues
If Tor fails to connect, the script will wait and retry. This is normal behavior as Tor circuits can take time to establish.

### Docker Permission Issues
Make sure your user has permission to run Docker commands:
```bash
sudo usermod -aG docker $USER
```

### Port Conflicts
The tool uses port 9050 for Tor SOCKS proxy. Ensure this port is available.

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

### Apache License 2.0 Summary

The Apache License 2.0 is a permissive license that allows you to:

- Use the software for any purpose
- Modify the software
- Distribute the software
- Distribute modified versions
- Use it commercially

The main requirements are:
- Include a copy of the license when redistributing
- State significant changes made to the software
- Include any existing copyright notices

For the full license text, see [LICENSE](LICENSE) file.

## Disclaimer

This tool is provided for educational and testing purposes only. Users are responsible for ensuring their use complies with applicable laws and website terms of service.
