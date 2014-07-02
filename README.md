Debate [![tip for next commit](http://tip4commit.com/projects/827.svg)](http://tip4commit.com/projects/827)
======

The goal of this system is to codify rational discourse and allow polling on issues.

The basic concept is laid out in a little more detail [in the wiki](https://github.com/TheFuturistParty/debate/wiki/Data-Model).

Installation
------------

# Locally

- `git clone https://github.com/TheFuturistParty/debate.git`
- `cd debate`
- `bundle install`
- `rake db:create db:migrate db:seed`
- `rails s`

# Heroku

- `heroku create app dbate`
- `heroku addons:add heroku-postgresql`


Contributing
------------

If you make improvements to this application, please share with others.

- Fork the project on GitHub.
- Make your feature addition or bug fix.
- Commit with Git.
- Send a pull request.
