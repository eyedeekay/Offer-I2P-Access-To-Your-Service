
I2P and TLS Certificates(not a step)
====================================

NOTE
----

It's perfectly possible to use a TLS certificate to identify a site inside of
I2P in addition to I2P's self-authenticating properties. However, the most
useful application of this I can think of, using a TLS certificate to show that
an eepSite and a clearnet site are served by the ame organization is currently
impossible, or at least so difficult it would be counter-productive to instruct
people to do it in this way. This section is therefore temporarily abandoned, to
be revived if circumstances change for any reason.

My sincerest thanks to the helpful young lady at Digicert who made sure we
exhausted all the options I didn't yet know about.

BEGIN
-----

In order to ensure that your eepSite deployment gets the same benefits as your
clear-web site as possible, it's usually a good idea to connect your service to
I2P at the same point that you connect to the clear web, with some exceptions
you might decide on based on the questions above. If you are not a corporation
offering .I2P access, you can probably skip this section entirely in favor of
side-channel validation of the I2P base32 and addresshelper links, which is
arguably easier, much less expensive, and apolitical.

#### Important Reading:

 * [Tor Blog](https://blog.torproject.org/facebook-hidden-services-and-https-certs)
 * [CA/Browser Forum Discusson](https://cabforum.org/pipermail/public/2015-November/006213.html)
 * [Even more CA?Browser forum Siscussion](https://cabforum.org/pipermail/public/2014-October/thread.html#4210)
 * [Digicert announcement](https://www.digicert.com/blog/anonymous-facebook-via-tor/)
 * [Let's Encrypt Discusson](https://community.letsencrypt.org/t/letsencrypt-for-onion/10045)
 * [CA?Browser Forum Ballot/Spec](https://cabforum.org/2015/02/18/ballot-144-validation-rules-dot-onion-names/)
 * [Stack Exchange Question on Validation](https://tor.stackexchange.com/questions/9740/how-to-easily-verify-certificates-on-onion-versions-of-clearnet-sites)
 * [CertBot issue](https://github.com/certbot/certbot/issues/91)
 * [Blog entry](https://medium.com/@alecmuffett/onions-certs-browsers-a-three-way-mexican-standoff-7dc987b8ebc8)
 * [Matt Traudt](https://matt.traudt.xyz/p/o44SnkW2.html)

#### If you want to use TLS for your site

If your site uses TLS, which it should on the clearnet unless it's literally
[Designed specifically to be hijacked at a McDonalds](http://neverssl.com), then
you may want to link your eepSite to your identity as authenticated by TLS.
Unfortunately, this is easier said than done, I combed through every bit of
documentation that I could find and there doesn't seem to be any way to add a
.b32.I2P or .I2P domain name to a certificate *except* possibly for some
Universal Communications Certificates, which I cannot afford. Unlike .onion,
.I2P domain names are not recognized as special use domain names yet and cannot
be included in the SAN field of other kinds of certificates.

*So* as a workaround to establish a trusted link between your clearnet presence
and your I2P presence, we're going to use a simple trick. Unfortunately, it
won't fix all the usability issues that come with self-signed certificates, but
it *will* allow visitors to confirm that a self-signed certificate was created
by a person with access to your private key and establish a link to your
corporate presence. We will generate this self-signed certificate in a future
step, for now, identify the certificates and keys used to authenticate your
clearnet site and make a note of their location.

##### Future work: TLS-in-I2P without self-signed certificates

In the future, it will probably be beneficial to authenticate .I2P domains in
another way. [darkweb-everywhere](https://github.com/chris-barry/darkweb-everywhere)
may be an interesting prospect.

#### Once you have determined whether or not it is beneficial to you to use TLS

Find the port that your services are using to communicate with the net, for
example, with HTTP it will usually be 80 or 8080, with HTTPS it will usually be
port 443. The exact answer will depend upon your set-up.
