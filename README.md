How to offer your existing Web Site as an I2P eepSite
=====================================================

A somewhat meta-tutorial and guided tour of mirroring a clear-web site to I2P.
Unfortunately, it's probably impossible to *completely* cover all possible cases
of making an existing web site available as an eepSite, there's simply too
diverse an array of server-side software, not to mention the in-practice
peculiarities of any particular deployment of software. Instead, I'm going to
try and convey, as specifically as possible, the general process preparing a
service for deployment to the eepWeb or other hidden services.

Much of this guide will be treating the reader as a conversational participant,
in particular If I really mean it I will address the reader directly(i.e. using
"you" instead of "one") and I'll frequently head sections with questions I think
the reader might be asking. This is, after all, a "process" that an
administrator must consider themselves "involved" in just like hosting any other
service.

DISCLAIMERS:
------------

While it would be wonderful, it's probably impossible for me to put specific
instructions for every single kind of software that one might use to host web
sites. As such, this tutorial requires some assumptions on the part of the
writer and some critical thinking and common sense on the part of the reader.
To be clear, **I have assumed that the person following this tutorial is**
**already operating a clear-web service linkable to a real identity or**
**organization** and thus is simply offering anonymous access and not
anonymizing themselves.

Thus, **it makes no attempt whatsoever to anonymize** a connection from one
server to another. If you want to run a new, un-linkable hidden service that
makes server-to-server connections, additional steps will be required and will
be covered in another tutorial.

That said: If you can be sure that a *brand new service* which is *not*
*available to the clear-web* will never make a server-to-server connection and
will not leak server metadata in responses to clients, then services configured
in this way will be anonymous.

Process One: Prepare your Server
--------------------------------

### Step one: Determine what software you are running

In practice, your web service probably uses a number of things to enhance it's
reliability and security. These things could be proxies, reverse proxies,
containers, tunnels, Intrusion Detection Systems, rate-limiters, load balancers,
among many other things. When you get started, you should go through your
deployment and determine which software you are using, and what you are using it
for.

#### As you examine your software, ask yourself these questions

These questions should help you evaluate what parts of your software stack are
relevant to your I2P eepSite.

##### Does this software work based on IP addresses?

If you are using software which alters the behavior of traffic based on the IP
address of the sender, these things will probably not work with I2P, or may work
in complicated or unexpected ways. This is because the address will usually be
the localhost, or at least the host where your I2P router is running. Software
which sometimes does things based on IP addresses could be Fail2Ban, iptables,
and similar applications.

##### Does this software work by "Tagging" traffic with additional metadata?

Some software may be configured to add information to the traffic it handles.
Obviously, if this information is identifying it should not be part of the chain
of services that is exposed to the I2P network.

##### Does this software work by communicating with a remote resource? What triggers this behavior?

Some software may also draw from remote resources, to find up-to-date rules and
block lists which can be used to prevent attacks. Some of these might be useful
as part of the service that is exposed to I2P, but you should make sure that the
rules are applicable and that a rules update cannot be triggered as a result of
a normal client request. This would create a server-to-server communication
which could reveal the timing of an I2P communication to a third party.

### Step two: Determine which port to Forward to I2P and Optionally locate your TLS certificate

Now you've gathered all the information that you will require to forward your
service to I2P. Once you've selected the point at which you would like to make
your site available to I2P, you will need to note the port you wish to foward.
In simple scenarios, this will probably just be port 80 or port 8080. In more
sophisticated scenarios, this might be a reverse proxy or something like that.
Make a note of the port.

#### Establishing a Common Identity for both the Clearnet and your eepSite

Should you be a non-anonymous organization that wishes to provide enhanced
privacy to your users by providing a hidden service, you may wish to establish
a common identity between versions of your site. However, since we can't add
[.i2p domains to clearnet TLS certificates](/IDENTITY/tls.html), we have to do
this in another way. To do this, **even if you are forwarding the HTTP port**
**and not HTTPS**, make a note of the location of your TLS certificate for use
in the final step.

Process Two: Forward your service to an eepSite
-----------------------------------------------

Congratulations! You've completed the most difficult part. From here on, the
decisions you must make, and the consequences that they will have, are much
more straightforward and easy to enumerate. Such is the beauty of a
cryptographically secure network layer like I2P!

### Step three: Generate your .i2p Tunnels and Addresses

For eepSites, you will need to create an HTTP Server Tunnel. This is
an I2P destination with a few special features for hosting HTTP services to
enable things like rate-limiting, filtering, and the inclusion of headers to
identify the destination of the client to the server. These enable flexibility
in how you handle connections in terms of load-balancing and rate-limiting on
a case-by-case basis, among other things. Explore these options and how they
relate to the applications which you considered in step one, even though a very
simple setup is easy, larger sites may benefit from taking advantage of these
features.

#### Create an HTTP Tunnel for your application

If you've configured a reverse proxy or an SSH tunnel before, then the general
idea here should be very familiar to you. I2PTunnel, in essence, is just
forwarding ports from the host to the I2P Network. To set this up using the web
interface, go to the I2PTunnel configuration page.

At the bottom of the "I2P Hidden Services" section of the page, select an HTTP
Service from the drop-down and click "Create."

![config stuff](/_static/images/http-1.png)

It will immediately drop you into the granular tunnel configuration page, which
we're about to explore from top-to-bottom. The first, most essential settings
are the tunnel name and the target host:port. **The target host:port is**
**the place where you input the address of the service you are forwarding to**
**I2P**. Once you've configured that, your web site will become available over
i2p. However, there are probably a few things that we can improve.

![host stuff](/_static/images/http-2.png)

Next, you may want to pick a hostname to use for your eepSite. This hostname
doesn't need to be universally unique, for now, it will only be used locally.
We'll publish it to an address helper later. **If** the *Local Destination*
field isn't populated with your Base64 Destination yet, you should scroll down
to the bottom, save the tunnel configuration, and return to the tunnel
configuration.

![key stuff](/_static/images/http-3.png)

A little further down the configuration page, the tunnel options are available.
Since you've got a site which is not intended to be anonymous, but rather to
provide anonymous access to others by an alternate gateway, it may be good to
reduce the number of hops the tunnel takes on the I2P network.

![tunnel stuff](/_static/images/http-4.png)

Next are the encrypted leaseset options. You can probably leave these as the
defaults, since your site isn't anonymous it probably doesn't need features like
blinding or encrypted leasesets. If you were to choose encrypted leasesets, you
would not be accessible to anyone unless you shared a key with them in advance.

![leaseset stuff](/_static/images/http-5.png)

The next few parts may be especially useful to you if you run a high-traffic
site or find yourself subject to DDOS attacks. Here you can configure various
kinds of connection limits.

![rate limiting stuff](/_static/images/http-6.png)

After that, there are a few other ways of filtering connections by client
characteristics. First, you can block access via inproxies like I2P.to and
similar. Since you have a clearnet presence already, changing this may be better
if you want to encourage I2P users to only use your eepSite. You can also block
accesses via specific user-agents, for instance blocking wget may be helpful if
you want to prevent spidering. Finally, and of particular interest to Fail2Ban
users, the "Unique local address per client" will give each client it's own
local IP address instead of them all appearing to the server to be from
127.0.0.1.

![coarse blocking stuff](/_static/images/http-7.png)

You can probably leave these next few options to the defaults.

![Reduced tunnel stuff](/_static/images/http-8.png)

Lastly, you can set up an advanced filter definition. Writing filters is beyond
what I'm prepared to do in this document, for more information see the format
specification for now.

![granular blocking stuff](/_static/images/http-9.png)

#### Multi-Home an Application

One interesting thing that I2P can do is host the same site on multiple servers
at the same time transparently, which is referred to as "Multihoming." In order
to multihome your application, you will need to return to the tunnel menu and
change the location of your private key file to it's own, non-shared location.

![multihoming key stuff](/_static/images/http-3-b.png)

When you're done, copy the new key file for your new multihomed service to a
storage device. Now, you can re-produce your service/tunnel configuration with
those same keys on any I2P router and increase your service's redundancy.

### Step four: Publicize and Authenticate your eepSite

Since you're running an anonymously accessible instance of an existing clear-net
service, you'll probably want to leverage some existing form of trust to
distribute your eepSite URL, like a TLS Certificate signed by a recognized and
reputable authority. What can I say we live in an imperfect world.

#### Place your .b32.i2p link on your clearnet page

The simplest way to provide a link to your eepSite using an existing site to
distribute the link is to distribute a so-called "Base32" address. The Base32
address is the hash of the public key of your I2P destination, so it cannot be
forged if it is provided by a reliable source. In the case of a clear-net site
with a hidden service presence, one of those places is likely to be that
clear-net site.

Your base32 address is visible on the main i2ptunnel configuration page and it
looks like this:

![base32 stuff](/_static/images/http-1-b.png)

Your users can copy-and-paste this link directly into their I2P browsers and
it will just work, no additional configuration required.

#### Distributing an "Addresshelper" link from your clearnet page

You can also distribute a human-readable link to suggest to your potential users
by taking advantage of I2P's "Address Book" feature, which allows the users to
decide to assign a human-readable domain name to your cryptographically
assured identity. You can do this by distributing a specially crafted link
containing the domain name that you want to suggest, followed by a slash,
followed by ?i2paddresshelper=, followed by the Local Destination of the tunnel
you just created, which you can see here:

![local destination stuff](_static/images/http-3.png)

So, for the example site, such a link would point to this address

        http://mirror.i2p/?i2paddresshelper=HGPghWp0cEIjgjzqKQg~brL0TXkvV6IqyyEvQxOmVIecPIY~qFD0xYCwLFxTv2Hmi781ngqGo5OImRSeI-4cy167Pb1d0sTArtm6csq~HL8nj~UDP28q1DZFgR4mXX6VJMp7XJR~Mvjfzj0x7-JVaoMhrOKDE0P~tplH5Uik3xbS1rq3VF5vILx9lvkmSyZnu4bD7jk-h-na49gpk1Yx4znP0V3Mi9C6AAEzB4GexiSBxbFJyXFlO3byi-ca-jHqiMqtVE183TbXQNGPBI6FO-iBwYcFtIkWC0cBMneqj~kl3nXEn8RrO-yd-060oueyaza8NyN4FfSTHS5F1r9rru0ntX7GLg1k3QO7fTVhly0q2B0gZqnaHP808aTGD7OFuX69wT40uF3UWPmhsSE-M9AUYbYR64OFmk0jS70qnIApzWrjoye7K3KSaJuyVUQ1sD94aqRUKRKM2QCill6f8XmIyaCv02GkzEJxngBx009OwaDIvmEdOGpLJJLXw7QQBQAEAAcAAA==

I keep saying suggest because when the such a link is visited, I2P asks for the
user's consent to add this human-readable name to the user's local address book.
That means there is no expectation that this domain be universally agreed upon
by all visitors on the I2P network, whereas in the case of base32 addresses,
the opposite is true.

#### Registering with an Addresshelper service

Nonetheless, there do exist publicly available address subscription feeds, and
special services for discovering new human-readable addresses, such as no.i2p,
inr.i2p, and stats.i2p. These are sometimes known as Address helpers or Jump
Services, and can also be subscribed to automatically. This may be espescially
helpful to users of your service who wish to acquire the address without leaving
i2p or visiting your clearnet service.

 * [Register a name with stats.i2p](http://stats.i2p/i2p/addkey.html)
 * [Register a new name with inr.i2p](http://inr.i2p/postkey/)

#### Create a subscribable address feed

[I2P Subscription Feed Commands](https://geti2p.net/spec/proposals/112-addressbook-subscription-feed-commands)
See Also:
---------

Most of the security issues of hosting Tor hidden services also apply to I2P. It
would be advisable to take advantage of their resources as well as this one:

### Misc Links

 * [Official Guide](https://2019.www.torproject.org/docs/tor-onion-service.html.en)
 * [Riseup best Practices](https://riseup.net/en/security/network-security/tor/onionservices-best-practices)
 * [Blog about config fails](https://blog.0day.rocks/securing-a-web-hidden-service-89d935ba1c1d)
 * [Whonix Docs Onion Service](https://www.whonix.org/wiki/Onion_Services)
 * [Reddit thread](https://old.reddit.com/r/TOR/comments/bd5aqc/can_my_server_trade_off_privacy_for_speed_and/)

### Stack Exchange

 * [Hosting clearnet site as onion service](https://tor.stackexchange.com/questions/16680/hosting-site-as-hidden-service)
 * [Securing a Tor Hidden Service](https://tor.stackexchange.com/questions/58/securely-hosting-a-tor-hidden-service-site)
 * [Effects of hosting hidden and non-hidden services](https://tor.stackexchange.com/questions/6014/does-hosting-a-tor-hidden-service-also-on-clearnet-dns-reduce-privacy-security-f)

### Clearnet Web Sites announcing Public Services:

 * [Propublica](https://www.propublica.org/nerds/a-more-secure-and-anonymous-propublica-using-tor-hidden-services)
 * [Wikipedia Proposal](https://meta.wikimedia.org/wiki/Grants_talk:IdeaLab/A_Tor_Onion_Service_for_Wikipedia)
