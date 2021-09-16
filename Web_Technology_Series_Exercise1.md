# 1.Purpose

**Connect the technology you have learned so far with Ruby**

## 2.Overview

To learn how to get requests and responses using Ruby's Webrick
In this series of exercises, you will combine the knowledge you have learned so far with Ruby to create a simple web application.
By combining HTML, CSS, Ruby, and SQL, you can have an image of what it means to create a Web application through this exercise.

**In order to use goyaDB created in the previous curriculum, this curriculum is almost same as the directory used in the introduction to RDBMS and SQL.**

## 3.What is a Web Application?

First of all, let’s check on what is a “Web application”.
A web application is an application that runs on a web server (a server that is used to provide information and functions to a user’s computer over a network on a web system) and that is used with a web browser.
For example, in a page with only HTML, CSS, and JavaScript, you can only access the determined URL and display the determined page.
However, you can add movement by placing a program written in a language such as Ruby on the back of the page and by activating it.

## 4.What is a web server?

A web server is a server that is used to provide information and functions to a user’s computer through a network on a web system.

The Web server generates a communication when a request for a URL (Request) 
is sent from the browser when the part described by "a href="..." " is clicked,
acquires and displays information of HTML existing in the web server.
Displaying HTML is called returning a response.
  
Here, Dynamic processing is realized by incorporating processing such as Ruby in HTML.
　


**In the next exercise, you will build a web server and a web application.**
  
 ## 5.Why do you need DB?
  
So far, it seems that you don’t need the DB (database) you learned in the previous series.
However, DB has an important task which Ruby can not do save and permanently store data sent from users.
As mentioned so far, Ruby has a function to accept information through a web server and process it.
However, Ruby does not have a feature to permanently save information from the user. Even though it can be temporarily stored in variables, its value will disappear when the processing is completed.
For example, a site like Amazon needs to keep the order information and the purchase history from the user which is not easy.

So, in such a case, it is necessary to work with DB.
  
 
**If you access the URL written in the HTML page, you will be able to get the specified HTML page through the web server**

Let’s create a simple web application while keeping in mind the above flow.
　
First of all, how to create a web server?
This time, you will build a web server using gem Webrick.


Webrick is a gem that makes it easy to build and start a web server from within a Ruby file.
( official reference https://docs.ruby-lang.org/ja/latest/library/webrick.html )
  
**WEBrick** is an HTTP server toolkit that can be configured as an HTTPS server, a proxy server, and a virtual-host server. WEBrick features complete logging of both server operations and HTTP access. 
  　


So let’s create a ruby file named test.rb and an HTML file named test.html, and write as follows.
  
  test.rb
```
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
```
test.html
  
  ```
  <html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  </head>
  <body>
    <h1>Test！！！！！！！！！！！！！</h1>
    <!-- Description that content enclosed in form is sent to indicate.rb (cgi) -->
    <form action='indicate.cgi' method='POST'>
      Please enter the letters below<br><br>
      <!-- Input information is sent as data by submit button -->
      <!-- name = 'input' is the information to be sent to-->
      <!-- type = "text" is to create a form that can be input -->
      <input type="text"  name='input' ><br>
      <input type="submit" name="submit" >
    </form>
  </body>
</html>
  ```
  Next, create a file called indicate.rb in the directory that contains this html file, and write the following.
  indicate.rb 
  ```
  # Launch CGI program to receive and return data
require 'cgi'
cgi = CGI.new
# After receiving data, return a response in HTML format
cgi.out("type" => "text/html", "charset" => "UTF-8") {
  # Fetch received data cgi ['input'] and assign to local variable
  # Retrieve information from the marker 'input'
  get = cgi['input']
  # Return the response in HTML
  "<html>
    <body>
      <p>The received string is as follows</p>
      <p>String：#{get}</p>
    </body>
  </html>"
}
  
  ```
Let’s start the server on Webrick.
Make sure you have both test.rb and test.html files.
- Let’s run this at the terminal.
```
ruby test.rb
  ```
  **To summarize the flow so far,**
 ```
 By executing the test.rb file, Webrick is read and the Web server is started
↓
In this state, if you click the ~ /test URL, you will be able to retrieve and display the test.html page from the web server
↓
When the submit button described in test.html is pressed, the process jumps to form action = 'indicate.cgi'
↓
Then, server.mount ('/indicate.cgi', (~omitted~), 'indicate.rb') receives processing
↓
The process of "indicate.rb" is executed, the html reflecting the value is returned and displayed in the browser
  
  ```

Processing will run in this order.


Now, it will open the “Test !!!!!!!!!!!!!” page in the same way as before, enter the appropriate characters in the input field below it, and click the submit button.
  
  ![Image from Gyazo](https://t.gyazo.com/teams/diveintocode/c759a921d6332c12bb06305bc88c26bc.png)
  ![Image from Gyazo](https://t.gyazo.com/teams/diveintocode/33cc8bb49a24d4023b2b21cb6dd6abb4.png)
  
  
  
