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

{{gettingStarted.md}}


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

