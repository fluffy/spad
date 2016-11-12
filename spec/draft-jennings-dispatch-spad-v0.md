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

