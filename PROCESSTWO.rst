
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
distribute the link is to distribute a so-called "Base32" address on your
existing web site. The Base32 address is the hash of the public key of your I2P
destination, so it cannot be forged if it is provided by a reliable source. In
the case of a clear-net site with a hidden service presence, one of those places
is likely to be a web page.

|base32 stuff|

Distributing an "Addresshelper" link from your clearnet page
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Create a subscribable address feed
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`I2P Subscription Feed Commands <https://geti2p.net/spec/proposals/112-addressbook-subscription-feed-commands>`__

Distributing
^^^^^^^^^^^^

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

