require 'webrick'
module WEBrick
	  module HTTPServlet
	    FileHandler.add_handler('rb', CGIHandler)
	  end
	end
server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
	  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
	  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
	  Signal.trap(signal){ server.shutdown }
	}
server.mount('/test', WEBrick::HTTPServlet::FileHandler, 'test.html')
# Add this line
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')
server.start
