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
different ip addresses including a /25 range of IPs. If devices in the
network are capable of re-marking DSCP, the desired marking is 46 wich
corresponds to "EF".

{{gen/example2.json.md}}


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


{backmatter}


# Development of this Specification

## Specification Style

The specification style is "less is more." If a reasonable developer
who is fully up on modern web development practices could figure out
how write an interoperable implementation after looking at some
examples and code and asking a few questions, well that's good enough
for us. If you can find it on Wikipedia, we don't need to explain it
here.

The build chain allows for an internet draft to be produced from
separate parts: a basic draft skeleton that includes narrative text;
examples; an API specification; and a schema. Markdown is used for
text. RAML and JSON Schema are used to describe the API. Examples play
a central role in the specification. The build chain has the goal of
being simple and obvious with no black magic.

## Following Discussion

We welcome all contributions. Discussion takes place in a few places:

* We discuss specific issues on the appropriate issues list in
  [Github](https://github.com/fluffy/spad/issues). If you don't want
  to use Github to follow these discussions, you can subscribe to the
  [issue announce list](https://www.ietf.org/mailman/listinfo/spad-issues).

* Our [mailing list](https://www.ietf.org/mailman/listinfo/spad) is
  used for confirmation of consensus.

## Resolving Issues

Consensus for the resolution of an issue can be established through
discussion on the issues list. Once a resolution is found, the issue
will be labeled as `editor-ready`. The editor will then write a pull
request suggesting the specific changes to make to resolve the
issue. Consensus to adopt the change will be judged on the mailing
list. Once a pull request has consensus, the editor will merge it and
close the issue.


## Pull Requests

We welcome pull requests, both for editorial suggestions and to
resolve open issues. In the latter case, please identify the relevant
issue.

Please do not use a pull request to open a new design issue; it may
not be noticed.


## Published Versions

The web site at (https://fluffy.github.io/spad/) provides an overview
of the specification that is focused on a developer audience. However,
all the key information to implement the specification that is used to
generate the web site is also used to generate and internet draft that
can be found at [draft-jennings-dispatch-spad-v0]
(https://datatracker.ietf.org/doc/draft-jennings-dispatch-spad-v0/).

Periodically the information on the master is branched to a versioned
draft branch and the content of that branch is used to produce an
updated version of the internet draft. A typical cadence for this is
monthly so that the draft can receive broader review.

When the work is at a good point to form a stable version of the API,
it is progressed through the IETF publication process with the goal of
publishing an RFC. Once approved, the text of the RFC is used to form
a released version of the API. The first version would be v1. The
current working pre-standard version is always referred to as v0.  The
API includes the version in the URL so that developers can implement
to a specific non-changing specification. Future versions attempt, but
do not guarantee, to be backwards-compatible with the previous
version.

# IANA Consideration 

TODO - register well known URL usage


# Security Considerations 

TODO - explain importance of HTTPS

TODO - Discuss merging with existing ACL


# Acknowledgements 

Thank you for the contributions from: 
Cullen Jennings, Alissa Cooper 

# RAML 

The RAML specification for the API is: 

{{gen/spad.raml.md}}

# Blueprint

This will likely be dropped from future version.

The Blueprint specification for the API is:

{{gen/spad.apib.md}}

# YANG

This is very preliminary and should not be taken very seriously at this
point.

The YANG data model for the JSON is:

~~~
<CODE BEGINS> file "ietf-spad@2017-10-02.yang"
~~~
{{gen/ietf-spad.yang.md}}
~~~
<CODE ENDS>
~~~
