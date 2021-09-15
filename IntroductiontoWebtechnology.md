# Introduction to Web technology

## The Goal

- **It’s purpose is To gain essential pre-requisites knowledge to become an engineer**.

## Overview

Let's learn how the website is displayed.

## Where is the substance of the web site?

- **You usually watch various websites by using the internet.**
- **Where are these web sites actually located?**
- **Since the web site is displayed on my PC, is it inside my PC?**
- **Or is it in a completely different place? You probably never thought about it.**

## Where is the information?

- The information on the web site is not in our own computer. Information is stored on an external computer. That computer is basically the same as the computer you have,but it has a big characteristic that “people in the whole world can see the contents of the computer”. Such a computer is called a “web server”.

## Entity of web server

### So where is the web server?

- It is in Japan, in Europe, in America, in Africa, in Russia and so on. In other words, web servers exist all over the world.  By the way, there is a “server room” that manages large-scale servers, and there are many servers managed there.

## How to reach the targeted web server?

- There is only **one server** out of lots of servers which has information of the targeted website.
- **How can we reach “the web server that has the information of the targeted website” out of tons of websites?**

# IP ADDRESS

### The important thing here is the IP address.
- The IP address is like the “address” in the Internet world,  Once the IP address is determined, the server is decided. As a matter of fact, try accessing from the browser you normally use by using the IP address.  Try putting the following IP address in the address bar of the server you normally use.
- Then, the google search window was displayed.
**216.58.197.142**
You can see that **216.58.197.142** is the address of the web server that has the google's TOP page information

## Domain which is another name for IP address

- This **IP address** is easy to understand for **computers**,  but it is not easy for **human** to understand.  So now is the time that “domain” is used.
216.58.197.142 = **google.com**

- **Google.com** on the right is the domain. As described above, allocate domain to **IP** **address** so that we can reach the target server even if we access it by **google.com**.

## What is URL?

- So what is the **URL** that you often hear?
- Let's compare it with the domain.

**Let's compare it with the domain**

![Image from Gyazo](https://t.gyazo.com/teams/diveintocode/276f4e5f9f0df1f86c271dfad5d9f7d6.png)

## DOMAIN

**A domain** is the part of the above figure.
The domain determines the address of the server,
The URL determines which file within the server to bring.
Please remember that there is such difference.
With these mechanisms, you can "get to" "the intended information of the target web server.

## [About request and response]

So far you learned information such as the web site is held by “web server”,and in order to access the web server, the following technologies are used.
```
- IP address
- Domain
- URL
```
This time, let's take a closer look at how to get information from the web server.

**Below, you will check three things.**

- Communication destination and communication source
- Communication method
- Request and response

### Communication destination and communication source

What do you use when you surf on the web?
It is **a browser**. There are various kinds of browsers,

- 「Google Chrome」
- 「Safari」
- 「Opera」
- 「Internet Explorer」
- 「Edge」
-  etc ,,,

By interacting with these “browsers” and “servers”, you can see and use the web sites.
### Communication method
When the browser and the server exchange data on the website,
There is a certain “rule (**communication method**)”.
This is called “http (**Hypertext Transfer Protocol**)”.

## Why there is such a rule?
Last time we mentioned that the server is in all over the world.
If the communication method of these servers is different for each server,
It will be difficult to communicate.
So, **it was necessary to determine the rule of http as the worldwide standard**.

## Request and response

Let's check important words here.
These are request and response.
From the browser you are using,
“**Request**” describing “**what servers are required for what**” is sent.

When the **request** arrives at the server, a “**response**” is returned from the server to the browser.

Please remember this relationship.

> Browser: Browser Request: Request Response: Response Server: Server
When the browser receives the response, the web site you normally see is displayed.
Process until the web site is displayed,

![Image from Gyazo](https://t.gyazo.com/teams/diveintocode/0f98ce9cfcc41fc6dffac7c41171e098.png)


 










