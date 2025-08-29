#!/usr/bin/env ruby
require 'socket'
require 'json'

class SimpleTodoServer
  def initialize(port = 3000)
    @port = port
    @server = TCPServer.new(port)
    puts "🚀 Simple Todo Server starting on http://localhost:#{port}"
    puts "📝 Todo app available at: http://localhost:#{port}"
    puts "Press Ctrl+C to stop the server"
  end

  def start
    loop do
      client = @server.accept
      request = client.readpartial(2048)
      
      method, path, version = request.lines.first.split
      headers = {}
      request.lines[1..-1].each do |line|
        break if line.strip.empty?
        key, value = line.split(': ', 2)
        headers[key] = value.strip if key && value
      end

      response = handle_request(method, path, headers)
      client.puts response
      client.close
    end
  rescue Interrupt
    puts "\n👋 Server shutting down..."
    @server.close
  end

  private

  def handle_request(method, path, headers)
    case path
    when '/', '/index.html'
      serve_file('public/index.html', 'text/html')
    when /\.(css|js|png|jpg|jpeg|gif|ico)$/
      serve_static_file(path)
    else
      serve_404
    end
  end

  def serve_file(filepath, content_type)
    if File.exist?(filepath)
      content = File.read(filepath)
      "HTTP/1.1 200 OK\r\n" +
      "Content-Type: #{content_type}; charset=utf-8\r\n" +
      "Content-Length: #{content.bytesize}\r\n" +
      "Connection: close\r\n\r\n" +
      content
    else
      serve_404
    end
  end

  def serve_static_file(path)
    filepath = "public#{path}"
    content_type = case File.extname(path)
                   when '.css' then 'text/css'
                   when '.js' then 'application/javascript'
                   when '.png' then 'image/png'
                   when '.jpg', '.jpeg' then 'image/jpeg'
                   when '.gif' then 'image/gif'
                   when '.ico' then 'image/x-icon'
                   else 'text/plain'
                   end
    
    serve_file(filepath, content_type)
  end

  def serve_404
    content = "<html><body><h1>404 - Not Found</h1></body></html>"
    "HTTP/1.1 404 Not Found\r\n" +
    "Content-Type: text/html; charset=utf-8\r\n" +
    "Content-Length: #{content.bytesize}\r\n" +
    "Connection: close\r\n\r\n" +
    content
  end
end

if __FILE__ == $0
  server = SimpleTodoServer.new
  server.start
end