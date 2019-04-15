
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
