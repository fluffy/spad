
To figure out what IP addresses are used by the service example.com,
the first step is to form the query URL by constructing an endpoint at
".well-known/spad/v0/spad".

Then an HTTPS GET query is done that to that URL.

~~~
curl https://example.com/.well-known/spad/v0/spad
~~~

The responses would be a JSON result that could looks like

{{gen/example1.json.md}}

The example above  indicates that the "example.com" application has a
single service with a single flow that uses only the HTTPS to connect to
port 443 on the IP address "203.0.113.2".  This SPAD information is
not valid after "Fri 11 Nov 2016 22:20:08 UTC" and a new SPAD file
should be retrieved before that point in time. 

The following shows a more complex example result for an application
that uses two flows. One is TLS to the SIP port of a server with an v4
and v6 address. The TLS connection will have a name of example.com in
the SNI.  The other flow is media sent over UDP to port 5004 on a few
different ip addresses. If devices in the network are capable of
remarking DSCP, the desired marking is "AF41".


{{gen/example2.json.md}}


