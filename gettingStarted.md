
To figure out what IP addresses are used by the service example.com,
the first step is to form the querry URL  of

'''
https://example.com/.well-known/spad/v0/transports
'''

An HTTPS GET querry is done that to that URL. I would return a JSON
result that looks like

{{gen/example1.json.md}}

The return result indicates that this service uses only the IP address
"203.0.113.2".

The following shows an example JSON result for an applications that 
uses only HTTP and QUIC over a small set of IP addresses. All traffic 
will be connecting to example.com or api.example.com from the point of 
view of TLS and proxies.

{{gen/example2.json.md}}


