require 'webrick'
server = WEBrick::HTTPServer.new(:Port => 3000)

server.mount_proc('/') do |req, res|
	res.content_type = 'text/txt'
	res.body = req.path
	p res
	trap('INT'){ sever.shutdown }
end




server.start







