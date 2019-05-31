
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
interface, go to the I2PTunnel configuration page. At the bottom of the "I2P
Hidden Services" section of the page, select an HTTP Service from the drop-down
and click "Create."

It will immediately drop you into the granular tunnel configuration page, which
we're about to explore from top-to-bottom.

#### Multi-Home an Application

One interesting thing that I2P can do is host the same site on multiple servers
at the same time transparently, which is referred to as "Multihoming."

### Step four: Publicize and Authenticate your eepSite


#### Place your .b32.i2p link on your clearnet page



#### Distributing an "Addresshelper" link from your clearnet page

#### Create a subscribable address feed

[](https://geti2p.net/spec/proposals/112-addressbook-subscription-feed-commands)


#### Distributing
