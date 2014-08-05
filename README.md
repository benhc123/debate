Debate [![tip for next commit](http://tip4commit.com/projects/827.svg)](http://tip4commit.com/projects/827)
======

The goal of this system is to codify rational discourse and allow polling on issues.

Users should be able to [proxy their vote](https://www.youtube.com/watch?v=fg0_Vhldz-8) either to an individual or organization.

Identity will be verified via postal mail sent to their name and address as registered with the election commission.

Participation
-------------

Development information is spread out over a few services:

* [Development Listserv](https://groups.google.com/forum/#!forum/debate-dev/)
* [Github Repo](https://github.com/TheFuturistParty/debate/)
* [Futurist Party Slack](https://futuristparty.slack.com/messages/web-dev/) ([e-mail me](mailto:Will%20Holcomb%20%3Cwill+slack@dhappy.org%3E) for an invite)

If you're interested in paid development, [estimate and rate hours](https://crwdfund.herokuapp.com) then [e-mail me](mailto:Will%20Holcomb%20%3Cwill+work@dhappy.org%3E) since I never look at that site.

Installation
------------

# Locally

1. `sudo apt-get install git`
2. `git clone https://github.com/TheFuturistParty/debate.git`
3. `curl -sSL https://get.rvm.io | bash`
4. `source ~/.rvm/scripts/rvm`
5. `cd debate`
6. `rvm install ruby-2.1.2`
7. `bundle install`
8. *optional* edit `config/secrets.yml` and change the admin credentials
9. `rake db:create db:migrate db:seed`
10. `rails s`
11. `chrome http://localhost:3000`

# Heroku

- `git clone https://github.com/TheFuturistParty/debate.git`
- `cd debate`
- `heroku create app dbate`
- `heroku addons:add heroku-postgresql`
- `heroku config:add DOMAIN_NAME='dbate.herokuapp.com'`
- `git push heroku master`
- `heroku config:add ADMIN_NAME='admin'`
- `heroku config:add ADMIN_EMAIL='root@futuristparty.org' ADMIN_PASSWORD='secret'`
- `heroku run rake db:migrate db:seed`
- `rake figaro:heroku`

If you change anything, it has to be precompiled before it is sent to Heroku.

- `RAILS_ENV=production rake assets:precompile`
- `git add -A`
- `git push heroku master`
