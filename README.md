Debate [![tip for next commit](http://tip4commit.com/projects/827.svg)](http://tip4commit.com/projects/827)
======

The goal of this system is to codify rational discourse and allow polling on issues.

The basic concept is laid out in a little more detail [in the wiki](https://github.com/TheFuturistParty/debate/wiki/Data-Model).

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
- `heroku config:add DOMAIN_NAME='dbate.herokuapp.com'
- `git push heroku master`
- `heroku config:add ADMIN_NAME='admin'`
- `heroku config:add ADMIN_EMAIL='root@futuristparty.org' ADMIN_PASSWORD='secret'`
- `heroku run rake db:migrate db:seed`
- `rake figaro:heroku`

If you change anything, it has to be precompiled before it is sent to Heroku.

- `RAILS_ENV=production rake assets:precompile`
- `git add -A`
- `git push heroku master`

Contributing
------------

If you make improvements to this application, please share with others.

- Fork the project on GitHub.
- Make your feature addition or bug fix.
- Commit with Git.
- Send a pull request.
