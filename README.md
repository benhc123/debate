# [The  Futurist Party](//reddit.com/r/futuristparty) Voting Interface

[![tip for next commit](http://tip4commit.com/projects/827.svg)](http://tip4commit.com/projects/827) 
[![GitHub issues](https://img.shields.io/github/issues/TheFuturistParty/vote.svg)](https://github.com/TheFuturistParty/vote/issues)
[![GitHub forks](https://img.shields.io/github/forks/TheFuturistParty/vote.svg)](https://github.com/TheFuturistParty/vote/network)
[![GitHub stars](https://img.shields.io/github/stars/TheFuturistParty/vote.svg)](https://github.com/TheFuturistParty/vote/stargazers)
======

# Improvements

|| _Electoral_ | _Topical_ |
|-|-----------|-------|
| **Term Length** | Fixed terms, 2-8 years. | At-will electronically-delegated terms. |
| **Election Process** | Nomination then election. | Any account can proxy. [Eligibility verification using election commission rolls.](#identity-verification) |
| **Granularity** | One delegate for all issues. | Proxy rights can be allotted topically based on keywords assigned by organizations.  |
| **Divisibility** | Single proxy for votes. | Percentages of a vote may be allocated to multiple parties. |
| **Overidability** | Elected proxy votes all issues. | User may cast a direct ballot on any issue. |
| **Voters** | Only elected proxy votes on issues. | All users may vote on all issues. |
| **Chaining** | A proxy must directly cast a ballot. | A proxy may in turn proxy to someone else. |

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

* Get a key for the Congress API and put it in `config/application.yml` as `SUNLIGHT_KEY`.
* `rails c`
* `Issue.load_bills`

This will create `Issue`s and associated `Tag`s for the first ten bills retrieved having keywords.
