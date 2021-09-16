# 1.Purpose

The aim of this exercise is to connect the skills you have learned so far to Ruby.

## 2.Goal
Learn how to manipulate DB from Ruby by combining Ruby and SQL

## 3.Last review

Then, let’s create a web application following the previous one.

In the previous curriculum,


1. Start up web server and set it so that it can return a response when a request for a specific URL is sent
1. Create a page to get information entered in HTML, CSS, JavaScript
1. The Web server receives the input information sent from that page
1. Server side programming language such as Ruby processes the information
1. If necessary, store the information in DB or extract information from DB (mainly using SQL language)

You were able to create a Web application with the functions of ‘the the top four’ of the Web application framework.
Specifically, you were able to implement the following processing.


1. Response to return HTML of test page can be set by URL of http://localhost:3000/test.
2. to create and display a test page that the user can enter

Let’s implement the last part if you can check up to here!
　
In this case, using goyaDB used in the previous curriculum, you will create a web application which, If the user clicks any button, the information of a specific goya in the DB can be viewed. .
Let’s create a function that allows you to view the size of the bitter gourd in the DB and the information of the buyer.

## 4.Manipulate DB from Ruby program

Now, how to manipulate DB from Ruby programs will be explained through the creation of sample files.
You will use goyaDB from here. Depending on the situation of the work space, the setting may not work properly and an error may occur. Please consult with a mentor as soon as possible in such a situation.

- At the terminal

```
gem install pg
```

This pg is a gem that allows you to manipulate psql with ruby.

Once you have the gem installed, create a file called sample_pg.rb and write the following:

sample_pg.rb

```
# Use pg library
require 'pg'
# Connect to goyaDB from ruby by PG :: connect (dbname: "goya")
# Store connection information in a variable named connection
connection = PG::connect(dbname: "goya")
connection.internal_encoding = "UTF-8"
begin
  # Manipulate PostgreSQL using the connection variable
  # "select date, weight, give_for from crops;"
  # Directly execute SQL statement and store the result in result variable
  result = connection.exec("select date, weight, give_for from crops;")
  # Process each line taken out
  result.each do |record|
      # Take each line and put it on the terminal
      puts "Size of bitter gourd: # {record ["weight"]} Sold to: # {record ["give_for"]}"
  end
ensure
  # If you encounter some errors,
  # Stop the connection to the database with .finish
  connection.finish
end
```

With the above description, you can take out the information of goyaDB created in the previous SQL curriculum from ruby! (If you can not remember the SQL statement, please proceed while reading the SQL curriculum)
　


Let’s execute ruby sample_pg.rb!

![Image from Gyazo](https://t.gyazo.com/teams/diveintocode/6a75ab0edfe1d2852e702b3419042e61.png)

As mentioned above, let’s move on when you can get the information of goyaDB.
If this causes an error, rewrite PG :: connect (dbname:" goya ") to PG :: connect (dbname:" ubuntu ") and try again. If that doesn’t work, then ask to a mentor.

## 5.Add pg connection process to the file created so far

Now, let’s add the DB processing function to the file created last time.
　
<mark>We assume you have already imported the goya csv into your database.</mark>

First, rename the previously created test.html file to test.html.erb.
erb stands for Embedded Ruby and <mark>*.html.erb*</mark>means html file with embedded Ruby code. (Strictly speaking, although it may be slightly different, there is no problem with this general understanding.)


In other words, changing the name of the *test.html* file to <mark>*test.html.erb*<mark> means that you can write ruby code in the test.html file.
Remember that it is also used by Rails.
　


Let’s rewrite <mark>test.html.erb</mark> as follows.
  
  <mark>test.html.erb</mark> 
	
```
  <html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  </head>
  <body>
    <h1>Test！！！！！！！！！！！！！</h1>
    <% require 'pg' %>
    <% connection = PG::connect(dbname: "goya") %>
    <% connection.internal_encoding = "UTF-8" %>
    <form action="indicate.cgi" method="POST">
       Please enter the letters below<br><br>
      <input type="text"  name="input" ><br>
      <input type="submit" name="submit" >
    </form>
    <% result = connection.exec("select date, weight, give_for from crops;") %>
    <% date = [] %>
    <% result.each do |record| %>
      <%  date << "Size of bitter gourd: # {record ["weight"]} Sold to: # {record ["give_for"]}" %>
    <% end %>
    <form action="goya.cgi" method="POST">
       Press the button below to jump to the size of the bitter gourd and the information page of the buyer<br><br>
       <!-- Substitute the data you want to send for value -->
       <!-- Make name = "goya" a mark of information -->
      <input type="text" name="goya" value="<%= date.join(' ') %>">
      <input type="submit" name="submit" >
    </form>
  </body>
</html>
	    
```
      
Add some changes to test.rb and prepare a page to output goyaDB information.
<mark>test.rb</mark>
    
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
# Change WEBrick :: HTTPServlet :: FileHandler to WEBrick :: HTTPServlet :: ERBHandler
# Change 'test.html' to 'test.html.erb'
server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')
# Add this line
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')
server.start
	    
```
      
Then create a <mark>goya.rb</mark> file to output the goyaDB information.
      
<mark>goya.rb</mark>
	    
```
      # Launch CGI program to receive and return data
require 'cgi'
cgi = CGI.new
# After receiving data, return a response in HTML format
cgi.out("type" => "text/html", "charset" => "UTF-8") {
  # Retrieve the data of "goya" which is the mark of information by the description cgi ['goya'] and assign it to a local variable
  get = cgi['goya']
  # Return the response in HTML
  "<html>
    <body>
      <p>The size of the bitter gourd and the information of the buyer are as follows</p>
      String：#{get}
    </body>
  </html>"
}
    
```
	    
What is being done here is almost the same as what is described in the previous curriculum, so detailed explanations will be omitted.


When everything is complete, it will look like this! (Here, the purpose is to know the basic mechanism of the web application, so the HTML design is not considered)

      
      
![Image from Gyazo](https://t.gyazo.com/teams/diveintocode/ce806352b80f4d0ff0ef6e8975fc75b7.png)
      
      
Now you have created a web application that says, " If the user clicks on any button, you can view the information of a specific goya in the DB "!
　


In this way, “the output information changes depending on the user action” is the form of a basic Web application.


1. Start up web server and set it so that it can return a response when a request for a specific URL is sent
2. Create a page to get information entered in HTML, CSS, JavaScript
3. The Web server receives the input information sent from that page
4. Server side programming language such as Ruby processes the information
5. If necessary, store the information in DB or extract information from DB (mainly using SQL language)

Let’s keep this in mind and move on to study Ruby on Rails!
      

      
      

     
　
