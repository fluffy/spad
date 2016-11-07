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

TODO

{mainmatter}

# Introduction

{{overview.md}}

# Terminology

In this document, the key words "MUST", "MUST NOT", "SHOULD", "SHOULD
NOT", "MAY", and "OPTIONAL" are to be interpreted as described in RFC
2119 [@!RFC2119] and indicate requirement levels for compliant
implementations.

RAML is defined at <https://github.com/raml-org>. 

JSON Schema is defined at <http://json-schema.org/>. Further
information is available in [@I-D.wright-json-schema].

# Example

The following shows an example JSON result for an applications that 
uses only HTTP and QUIC over a small set of IP addresses. All traffic 
will be connecting to example.com or api.example.com from the point of 
view of TLS and proxies.

A firewall that wanted to find out what transports the "example.com" application
uses would doe a HTTPS GET to <https://example.com/.well-known/spad/v0/transports> and get back a
JSON result such as the following:

{{gen/example1.json.md}}


# RAML

To discover the transports used by example.com, an HTTP REST call
would be made corresponding to the following RAML:

{{gen/spad.raml.md}}

# Schemas

The JSON returned from MUST corespond to the following JSON schema.

{{gen/spad-schema.json.md}}


# IANA Consideration

{{iana.md}}

# Security Considerations

{{security.md}}

# Acknowledgments 

Thank you for the contributions from:
{{Contributors.md}}



{backmatter}

{{CONTRIBUTING.md}}

