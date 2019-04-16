
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
relevant to your i2p eepSite.

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

### Step two: Determine which port to Forward to I2P

In order to ensure that your eepSite deployment gets the same benefits as your
clear-web site as possible, it's usually a good idea to connect your service to
I2P at the same point that you connect to the clear web, with some exceptions
you might decide on based on the questions above.

#### Once you've evaluated proxies, filters, containers, et cetera

Once you've

