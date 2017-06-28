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
firewalls and other devices to discover whats IP addresses, ports, and
related transports a given cloud services uses.

{mainmatter}

# Introduction

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

{{spec/gettingStarted.md}}


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


# Blueprint

{{spec/blueprint.md}}


# Schemas

{{spec/schemas.md}}


# IANA Consideration

{{spec/iana.md}}

# Security Considerations

{{spec/security.md}}

# Acknowledgements 

Thank you for the contributions from:
{{gen/Contributors.md}}


{backmatter}

{{spec/CONTRIBUTING.md}}

