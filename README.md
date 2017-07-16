# [The  Futurist Party](//reddit.com/r/futuristparty) Voting Interface

[![tip for next commit](http://tip4commit.com/projects/827.svg)](http://tip4commit.com/projects/827) [![Codeship Status](https://www.codeship.io/projects/0b2a3570-0fc8-0132-0248-129d6db6c348/status)](https://www.codeship.io/projects/32717)
======

# Improvements

|| _Electoral_ | _Topical_ |
|-|-----------|-------|
| _Term Length_ | Fixed terms, 2-8 years. | At-will electronically-delegated terms. |
| _Election Process_ | Nomination then election. | Any account can proxy. [Elegibility verification using election commission rolls.](#identity-verification) |
| _Granularity_ | One delegate for all issues. | Proxy rights can be allotted topically based on keywords assigned by organizations.  |
| _Divisibility_ | Single proxy for votes. | Percentages of a vote may be allocated to multiple parties.  |
| _Overidability_ | Elected proxy votes all issues. | User may cast a direct ballot on any issue. |
| _Voters_ | Only elected proxy votes on issues. | All users may vote on all issues. |
| _Chaining_ | A proxy must directly cast a ballot. | A proxy may in turn proxy to someone else. |

# Identity Verification

1. User creates account
2. User enters registered voting address
3. Address is verified against election commission records
4. Code is sent to user via postal mail
5. User enters code into application
6. Account is verified

A Sybil account cannot be created without falsifying election commission records.

# Participation

Development information is spread out over a few services:

* [Development Listserv](https://groups.google.com/forum/#!forum/debate-dev/)
* [Github Repo](https://github.com/TheFuturistParty/vote/)
* [Futurist Party Slack](https://futuristparty.slack.com/messages/web-dev/)

## Loading bills from the Sunlight Foundation

To load bills from the Congress API:

* Get a key for the [Congress API](http://tryit.sunlightfoundation.com/congress) and put it in `config/application.yml` as `SUNLIGHT_KEY`.
* `rails c`
* `Issue.load_bills`

This will create `Issue`s and associated `Tag`s for the first ten bills retrieved having keywords.
