
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

### Step two: Determine which port to Forward to I2P and Optionallly locate your TLS certificate

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
[.I2P domains to clearnet TLS certificates](/IDENTITY/tls.html), we have to do
this in another way. To do this, **even if you are forwarding the HTTP port**'
**and not HTTPS**, make a note of the location of your TLS certificate for use
in the final step.
