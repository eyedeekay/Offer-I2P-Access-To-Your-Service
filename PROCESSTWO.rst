
Process Two: Forward your service to an eepSite
-----------------------------------------------

Congratulations! You've completed the most difficult part. From here on, the
decisions you must make, and the consequences that they will have, are much
more straightforward and easy to enumerate. Such is the beauty of a
cryptographically secure network layer like I2P!

.. _step-three-generate-your-i2p-tunnels-and-addresses:

Step three: Generate your .i2p Tunnels and Addresses
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For eepSites, you will need to create an HTTP Server Tunnel. This is
an I2P destination with a few special features for hosting HTTP services to
enable things like rate-limiting, filtering, and the inclusion of headers to
identify the destination of the client to the server. These enable flexibility
in how you handle connections in terms of load-balancing and rate-limiting on
a case-by-case basis, among other things. Explore these options and how they
relate to the applications which you considered in step one, even though a very
simple setup is easy, larger sites may benefit from taking advantage of these
features.

Create an HTTP Tunnel for your application
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you've configured a reverse proxy or an SSH tunnel before, then the general
idea here should be very familiar to you. I2PTunnel, in essence, is just
forwarding ports from the host to the I2P Network. To set this up using the web
interface, go to the I2PTunnel configuration page.

At the bottom of the "I2P Hidden Services" section of the page, select an HTTP
Service from the drop-down and click "Create."

|config stuff|

It will immediately drop you into the granular tunnel configuration page, which
we're about to explore from top-to-bottom. The first, most essential settings
are the tunnel name and the target host:port. **The target host:port is**
**the place where you input the address of the service you are forwarding to**
**I2P**. Once you've configured that, your web site will become available over
i2p. However, there are probably a few things that we can improve.

|host stuff|

Next, you may want to pick a hostname to use for your eepSite. This hostname
doesn't need to be universally unique, for now, it will only be used locally.
We'll publish it to an address helper later. **If** the *Local Destination*
field isn't populated with your Base64 Destination yet, you should scroll down
to the bottom, save the tunnel configuration, and return to the tunnel
configuration.

|key stuff|

A little further down the configuration page, the tunnel options are available.
Since you've got a site which is not intended to be anonymous, but rather to
provide anonymous access to others by an alternate gateway, it may be good to
reduce the number of hops the tunnel takes on the I2P network.

|tunnel stuff|

Next are the encrypted leaseset options. You can probably leave these as the
defaults, since your site isn't anonymous it probably doesn't need features like
blinding or encrypted leasesets. If you were to choose encrypted leasesets, you
would not be accessible to anyone unless you shared a key with them in advance.

|leaseset stuff|

The next few parts may be especially useful to you if you run a high-traffic
site or find yourself subject to DDOS attacks. Here you can configure various
kinds of connection limits.

|rate limiting stuff|

After that, there are a few other ways of filtering connections by client
characteristics. First, you can block access via inproxies like I2P.to and
similar. Since you have a clearnet presence already, changing this may be better
if you want to encourage I2P users to only use your eepSite. You can also block
accesses via specific user-agents, for instance blocking wget may be helpful if
you want to prevent spidering. Finally, and of particular interest to Fail2Ban
users, the "Unique local address per client" will give each client it's own
local IP address instead of them all appearing to the server to be from
127.0.0.1.

|coarse blocking stuff|

You can probably leave these next few options to the defaults.

|Reduced tunnel stuff|

Lastly, you can set up an advanced filter definition. Writing filters is beyond
what I'm prepared to do in this document, for more information see the format
specification for now.

|granular blocking stuff|

Multi-Home an Application
^^^^^^^^^^^^^^^^^^^^^^^^^

One interesting thing that I2P can do is host the same site on multiple servers
at the same time transparently, which is referred to as "Multihoming." In order
to multihome your application, you will need to return to the tunnel menu and
change the location of your private key file to it's own, non-shared location.

|multihoming key stuff|

When you're done, copy the new key file for your new multihomed service to a
storage device. Now, you can re-produce your service/tunnel configuration with
those same keys on any I2P router and increase your service's redundancy.

Step four: Publicize and Authenticate your eepSite
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since you're running an anonymously accessible instance of an existing clear-net
service, you'll probably want to leverage some existing form of trust to
distribute your eepSite URL, like a TLS Certificate signed by a recognized and
reputable authority. What can I say we live in an imperfect world.

.. _place-your-b32i2p-link-on-your-clearnet-page:

Place your .b32.i2p link on your clearnet page
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The simplest way to provide a link to your eepSite using an existing site to
distribute the link is to distribute a so-called "Base32" address. The Base32
address is the hash of the public key of your I2P destination, so it cannot be
forged if it is provided by a reliable source. In the case of a clear-net site
with a hidden service presence, one of those places is likely to be that
clear-net site.

Your base32 address is visible on the main i2ptunnel configuration page and it
looks like this:

|base32 stuff|

Your users can copy-and-paste this link directly into their I2P browsers and
it will just work, no additional configuration required.

Distributing an "Addresshelper" link from your clearnet page
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can also distribute a human-readable link to suggest to your potential users
by taking advantage of I2P's "Address Book" feature, which allows the users to
decide to assign a human-readable domain name to your cryptographically
assured identity. You can do this by distributing a specially crafted link
containing the domain name that you want to suggest, followed by a slash,
followed by ?i2paddresshelper=, followed by the Local Destination of the tunnel
you just created, which you can see here:

|local destination stuff|

So, for the example site, such a link would point to this address

::

       http://mirror.i2p/?i2paddresshelper=HGPghWp0cEIjgjzqKQg~brL0TXkvV6IqyyEvQxOmVIecPIY~qFD0xYCwLFxTv2Hmi781ngqGo5OImRSeI-4cy167Pb1d0sTArtm6csq~HL8nj~UDP28q1DZFgR4mXX6VJMp7XJR~Mvjfzj0x7-JVaoMhrOKDE0P~tplH5Uik3xbS1rq3VF5vILx9lvkmSyZnu4bD7jk-h-na49gpk1Yx4znP0V3Mi9C6AAEzB4GexiSBxbFJyXFlO3byi-ca-jHqiMqtVE183TbXQNGPBI6FO-iBwYcFtIkWC0cBMneqj~kl3nXEn8RrO-yd-060oueyaza8NyN4FfSTHS5F1r9rru0ntX7GLg1k3QO7fTVhly0q2B0gZqnaHP808aTGD7OFuX69wT40uF3UWPmhsSE-M9AUYbYR64OFmk0jS70qnIApzWrjoye7K3KSaJuyVUQ1sD94aqRUKRKM2QCill6f8XmIyaCv02GkzEJxngBx009OwaDIvmEdOGpLJJLXw7QQBQAEAAcAAA==

I keep saying suggest because when the such a link is visited, I2P asks for the
user's consent to add this human-readable name to the user's local address book.
That means there is no expectation that this domain be universally agreed upon
by all visitors on the I2P network, whereas in the case of base32 addresses,
the opposite is true.

Registering with an Addresshelper service
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Nonetheless, there do exist publicly available address subscription feeds, and
special services for discovering new human-readable addresses, such as no.i2p,
inr.i2p, and stats.i2p. These are sometimes known as Address helpers or Jump
Services, and can also be subscribed to automatically. This may be espescially
helpful to users of your service who wish to acquire the address without leaving
i2p or visiting your clearnet service.

-  `Register a name with stats.i2p <http://stats.i2p/i2p/addkey.html>`__
-  `Register a new name with inr.i2p <http://inr.i2p/postkey/>`__

Create a subscribable address feed
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`I2P Subscription Feed Commands <https://geti2p.net/spec/proposals/112-addressbook-subscription-feed-commands>`__

.. |config stuff| image:: /_static/images/http-1.png
.. |host stuff| image:: /_static/images/http-2.png
.. |key stuff| image:: /_static/images/http-3.png
.. |tunnel stuff| image:: /_static/images/http-4.png
.. |leaseset stuff| image:: /_static/images/http-5.png
.. |rate limiting stuff| image:: /_static/images/http-6.png
.. |coarse blocking stuff| image:: /_static/images/http-7.png
.. |Reduced tunnel stuff| image:: /_static/images/http-8.png
.. |granular blocking stuff| image:: /_static/images/http-9.png
.. |multihoming key stuff| image:: /_static/images/http-3-b.png
.. |base32 stuff| image:: /_static/images/http-1-b.png
.. |local destination stuff| image:: _static/images/http-3.png

