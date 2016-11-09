---
title: Simple Port and Address Discovery (SPAD)
---

Simple Port and Address Discovery (SPAD) allows an web application to
inform others of what ports and IP addresses it uses so that things
like firewalls can correctly re-configure themsleves as the ports and
addresses change. Applications are identified by a domain name which
is used to form a URL in a well known location where a client can do a
HTTP REST call to get a JSON file that describes information about
what addresses and transport the service uses.

