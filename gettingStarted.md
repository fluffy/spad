
TODO write gettting started

The following shows an example JSON result for an applications that 
uses only HTTP and QUIC over a small set of IP addresses. All traffic 
will be connecting to example.com or api.example.com from the point of 
view of TLS and proxies.

A firewall that wanted to find out what transports the "example.com" application
uses would doe a HTTPS GET to <https://example.com/.well-known/spad/v0/transports> and get back a
JSON result such as the following:

{{gen/example1.json.md}}

