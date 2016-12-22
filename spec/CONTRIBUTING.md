
# Development of this Specification

## Specification Style

The specification style is "less is more." If a reasonable developer
who is fully up on modern web development practices could figure out
how write an interoperable implementation after looking at some
examples and code and asking a few questions, well that's good enough
for us. If you can find it on Wikipedia, we don't need to explain it
here.

The build chain allows for an internet draft to be produced from separate parts: a basic draft skeleton that includes narrative text; examples; an API specification; and a schema. Markdown is used for text. RAML and JSON Schema are used to describe
the API. Examples play a central role in the specification. The build
chain has the goal of being simple and obvious with no black magic.

## Following Discussion

We welcome all contributions. Discussion takes place in a few places:

* We discuss specific issues on the appropriate issues list in [Github](https://github.com/fluffy/spad/issues). If you don't want to use Github to follow these discussions, you can subscribe to the [issue announce list](https://www.ietf.org/mailman/listinfo/spad-issues).

* Our [mailing list](https://www.ietf.org/mailman/listinfo/spad) is used for confirmation of consensus.

## Resolving Issues

Consensus for the resolution of an issue can be established through discussion on the issues list. Once a resolution is found, the issue will be labeled as `editor-ready`. The editor will then write a pull request suggesting the specific changes to make to resolve the issue. Consensus to adopt the change will be judged on the mailing list. Once a pull request has consensus, the editor will merge it and close the issue.


## Pull Requests

We welcome pull requests, both for editorial suggestions and to resolve open issues. In the latter case, please identify the relevant issue.

Please do not use a pull request to open a new design issue; it may not be noticed.


## Published Versions

The web site at (https://coopdanger.github.io/spad/) provides an overview of the specification that is focused on a developer audience. However, all
the key information to implement the specification that is used to
generate the web site is also used to generate and internet draft that
can be found at [draft-jennings-dispatch-spad-v0]
(https://datatracker.ietf.org/doc/draft-jennings-dispatch-spad-v0-00/).

Periodically the information on the master is branched to a versioned draft branch and the content of that branch is used to produce an updated version of the internet draft. A typical cadence for this is monthly
so that the draft can receive broader review.

When the work is at a good
point to form a stable version of the API, it is progressed through the IETF publication process with the goal of publishing an RFC. Once approved, the
text of the RFC is used to form a released version of the API. The first version would be v1. The current working pre-standard
version is always referred to as v0.  The API includes the version in
the URL so that developers can implement to a specific non-changing
specification. Future versions attempt, but do not guarantee, to be
backwards-compatible with the previous version.
