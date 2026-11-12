# Local preview only: lets the in-page editor read and save Markdown sources.
# Started by serve.sh on 127.0.0.1:4001. Never deployed (folders starting with _ aren't published).
require "webrick"
require "json"

ROOT = File.expand_path("..", __dir__)
PORT = (ENV["EDIT_PORT"] || 4001).to_i
ALLOWED_EXT = %w[.md .markdown].freeze
BLOCKED_DIRS = %w[_site vendor node_modules .git .jekyll-cache].freeze

# Resolve a repo-relative path and refuse anything outside the repo or not Markdown.
def resolve(rel)
  return nil if rel.nil? || rel.empty?
  full = File.expand_path(rel, ROOT)
  return nil unless full.start_with?(ROOT + File::SEPARATOR)
  return nil unless ALLOWED_EXT.include?(File.extname(full).downcase)
  return nil if BLOCKED_DIRS.include?(full.delete_prefix(ROOT + File::SEPARATOR).split(File::SEPARATOR).first)
  return nil unless File.file?(full)
  File.realpath(full).start_with?(ROOT + File::SEPARATOR) ? full : nil
end

server = WEBrick::HTTPServer.new(
  BindAddress: "127.0.0.1", Port: PORT,
  Logger: WEBrick::Log.new($stderr, WEBrick::Log::WARN), AccessLog: []
)

server.mount_proc "/file" do |req, res|
  origin = req["Origin"].to_s
  if origin.match?(%r{\Ahttp://(127\.0\.0\.1|localhost):\d+\z})
    res["Access-Control-Allow-Origin"] = origin
    res["Access-Control-Allow-Methods"] = "GET, POST"
    res["Access-Control-Allow-Headers"] = "Content-Type"
  elsif !origin.empty?
    res.status = 403
    next
  end
  res["Content-Type"] = "application/json"

  case req.request_method
  when "OPTIONS"
    res.status = 204
  when "GET"
    path = resolve(req.query["path"])
    if path
      res.body = JSON.generate(content: File.read(path, encoding: "UTF-8"))
    else
      res.status = 404
      res.body = JSON.generate(error: "Not an editable file")
    end
  when "POST"
    data = JSON.parse(req.body.to_s) rescue {}
    path = resolve(data["path"])
    if path && data["content"].is_a?(String)
      File.write(path, data["content"].gsub("\r\n", "\n"), encoding: "UTF-8")
      res.body = JSON.generate(ok: true)
    else
      res.status = 400
      res.body = JSON.generate(error: "Bad path or content")
    end
  else
    res.status = 405
  end
end

trap("INT") { server.shutdown }
trap("TERM") { server.shutdown }
server.start
