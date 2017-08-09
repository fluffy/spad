%%%
    title = "Simple Port and Address Discovery"
    abbrev = "SPAD "
    category = "std"
    docName = "draft-jennings-dispatch-spad-v0-latest"
    ipr = "trust200902"
    area = "ART"

    [pi]
    symrefs = "yes"
    sortrefs = "yes"
    toc = "yes"

    [[author]]
    initials = "C."
    surname = "Jennings"
    fullname = "Cullen Jennings"
    organization = "Cisco"
      [author.address]
      email = "fluffy@iii.ca"


%%%

.# Abstract

This specification defines a simple JSON format and well known URL for
firewalls and other devices to discover what IP addresses, ports, and
related transports a given cloud service uses.

{mainmatter}

# Introduction

Simple Port and Address Discovery (SPAD) allows a web application to
inform others of what ports and IP addresses it uses so that things
like firewalls can correctly re-configure themselves as the ports and
addresses change. Applications are identified by a domain name which
is used to form a URL in a well-known location where a client can do an
HTTPS REST call to get a JSON file that describes information about
what addresses and transports the service uses.

{{spec/overview.md}}

# Terminology

In this document, the key words "MUST", "MUST NOT", "SHOULD", "SHOULD
NOT", "MAY", and "OPTIONAL" are to be interpreted as described in RFC
2119 [@!RFC2119] and indicate requirement levels for compliant
implementations.

RAML is defined at <https://github.com/raml-org>. 

JSON Schema is defined at <http://json-schema.org/>. Further
information is available in [@I-D.wright-json-schema].

# Example

To figure out what IP addresses are used by the service example.com,
the first step is to form the query URL by constructing an endpoint at
".well-known/spad/v0/spad".

Then an HTTPS GET query is sent to that URL.

~~~
curl https://example.com/.well-known/spad/v0/spad
~~~

The response would be a JSON result that could look like

{{gen/example1.json.md}}

The example above indicates that the "example.com" application has a
single service with a single flow that uses only HTTPS to connect to
port 443 on the IP address "203.0.113.2".  This SPAD information is
not valid after "Fri 11 Nov 2016 22:20:08 UTC" and a new SPAD file
should be retrieved before that point in time.

The following shows a more complex example result for an application
that uses two flows. One is TLS to the SIP port of a server with a v4
and v6 address. The TLS connection will have a name of example.com in
the SNI.  The other flow is media sent over UDP to port 5004 on a few
different ip addresses. If devices in the network are capable of
re-marking DSCP, the desired marking is "AF41".

{{gen/example2.json.md}}


{{spec/gettingStarted.md}}

{{spec/examples.md}}

# Protocols

The protocol field is filled out with the most specific instance of a
well defined protocol that is running. Any protocols that are implied
as the normal default by this that it runs over are omitted. For
example, HTTPS runs over TLS over TCP over IP. In this case the only
thing listed is HTTPS. However if HTTPS was being used over SCTP which
is not the normal thing, and the SCTP was over UDP which is also not
the default, then it would be listed at HTTPS/SCTP/UDP but IP is not
added as that is the normal thing for UDP to be over.

URI scheme from
https://www.iana.org/assignments/uri-schemes/uri-schemes.xhtml. is
preferred thing to use if defined, followed by the service name from
https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml
followed by the protocol by the Transport Protocol from RFC 6335. All
names are moved to all lower case for consistency.







# Schemas

The JSON returned in a response MUST correspond to the following JSON schema:

{{gen/spad-schema.json.md}}

{{spec/schemas.md}}



{backmatter}

{{spec/CONTRIBUTING.md}}

# IANA Consideration 

{{spec/iana.md}}

# Security Considerations 

{{spec/security.md}}

# Acknowledgements 

Thank you for the contributions from: 
{{gen/Contributors.md}}

# Blueprint

{{spec/blueprint.md}}

# RAML

The RAML specification for the API is:

{{spec/raml.md}}

# YANG

{{spec/yang.md}}

