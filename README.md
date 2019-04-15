How to offer your existing Web Site as an I2P eepSite
=====================================================

A somewhat meta-tutorial and guided tour of mirroring a clear-web site to i2p.
Unfortunately, it's probably impossible to *completely* cover all possible cases
of making an existing web site available as an eepSite, there's simply too
diverse an array of server-side software, not to mention the in-practice
peculiarities of any particular deployment of software. Instead, I'm going to
try and convey, as specifically as possible, the general process preparing a
service for deployment to the eepWeb or other hidden services.

Much of this guide will be treating the reader as a conversational participant,
in particular If I really mean it I will address the reader directly(i.e. using
"you" instead of "one") and I'll frequently head sections with questions I think
the reader might be asking, then answer them. Like now, for instance ;)

Important Questions from Systems Administrators
-----------------------------------------------

### Why would I want to mirror my Clear-Web site on I2P?

I still get this question alot, and it kind of surprises me at this point. After
all, many major clear-web services already have the very similar Tor Hidden
Services, and Tor even added a feature called "Single-hop Onions" to help
non-anonymous services be more effiecient and accessible to anonymous clients
on their overlay network. This is so that you can add value to your service by
allowing clients to access it anonymously. Besides that, there are also several
services on I2P which are accessible from clear-web counterparts, services such
as Jabber, e-mail, and activitypub-based social-networking.

So the point of the DuckDuckGo hidden service, for example, isn't to anonmymize
DuckDuckGo, that's obviously not possible. It is to provice anonymous, blocking
resistant access to *visitors* who do not wish to reveal their possible coarse
physical location in the form of their IP address. Moreover, it is actually very
easy to allow this kind of access to your existing web service.

### Why wouldn't I just let I2P Users rely on their OutProxy?

Just in case you didn't know, I2P has fairly few outproxies, all run by
volunteers. We really appreciate the work of our outproxy operators, and they
have a job that can get pretty complicated providing generic access to the
clearweb for anonymous clients. As a web site operator, you are in a genuinely
unique position to make this job easier. Only *you* can safely provide an
eepSite for your existing clear-web service to accept anonymous users and only
*you* can reduce the burden on the outproxy operators.

### How can I ensure that my users are seeing the real eepSite for my Service?

This is the reason *your* participation in the I2P network is so essential to
providing anonymous access to your eepSite. After all, anyone can set up a
fake gateway to say, reddit.com:80(Because somehow Reddit still lets you
use a plain  HTTP connection in 2019, fortunately, most browsers at this point
won't let you use it in practice), as a Tor hidden service or I2P eepSite and
unless your users take the time to verify the .onion or .b32.i2p address
manually, they seriously risk typing their password into a malicious site.

The difference *you* and **only you** can make is to use your TLS certificate
to ensure that the hidden service that the user connects to is the same site,
run by the same people, as the clear-web service, the behavior that the user
not only expects but *absolutely counts on.*

### Do I really want to allow anonymous users first-class access to my site?

Honestly you don't have a choice between allowing, or not allowing, anonymous
access to your site. If you block outproxies, I2P users will simply use Tor.
If you block Tor exits, Tor users will chain open HTTP Proxies. If all the open
HTTP proxies disappeared overnight(they won't) then VPN's would still be a
thing. And, to belabor a point already made by Tor, *botnet-based anonymizers*
*used to conceal criminal activity* already exist in the wild and are more
likely to be used maliciously than Tor, because that's what they're for! So the
real choice is

 1. Offer first-class access to anonymous users via a hidden service under your
 own control,
 2. Encourage anonymous users to hide from you in escalatingly more anti-social
 ways.

And in light of that, I think the choice is pretty clear. If you want your
anonymous users to be like your regular users, you should treat your anonymous
users like regular users, after all, that's what they are. :)

DISCLAIMERS:
------------

While it would be wonderful, it's probably impossible for me to put specific
instructions for every single kind of software that one might use to host web
sites. As such, this tutorial requires some assumptions on the part of the
writer and some critical thinking and common sense on the part of the reader.
To be clear, **I have assumed that the person following this tutorial is**
**already operating a clear-web service linkable to a real identity or**
**organization** and thus is simply offering anonymous access and not
anonymizing themselves. Thus, **it makes no attempt whatsoever to anonymize**
a connection from one server to another. If you want to run a new, un-linkable
hidden service that makes server-to-server connections, additional steps will
be required and will be covered in another tutorial.

That said: If you can be sure that a *brand new service* which is *not*
*available to the clear-web* will never make a server-to-server connection and
will not leak server metadata in responses to clients, then services configured
in this way will be anonymous.

Process One: Prepare your Server
--------------------------------



### Step one: Determine what software you are running

In practice, your web service probably uses a number of things to enhance it's
reliability and security. These things could be proxies, reverse proxies,
tunnels, Intrusion Detection Systems, load balancers, among many other things.
When you get started, you should go through your deployment and determine which
software you are using, and what you are using it for.

### Step two: Determine which of those applications exposes your application to the clear-web

In order to ensure that your eepSite deployment gets the same benefits as your
clear-web site as possible, it's usually a good idea to connect your service to
I2P at the same point that you connect to the clear web, with some exceptions.
Fail2Ban, for instance, may cause issues if you rate-limit by IP address, as I2P
clients will always appear to be the localhost.

Process Two: Forward your service to an eepSite
------------

### Step three:

### Step four:
