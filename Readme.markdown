# soff.es

This is my new blog in Rails 3.1. I [moved my blog to Jekyll](http://soff.es/post/new-blog-on-github-and-jekyll/) a few months ago and really missed playing with a Rails app, so I'm moving it back and starting from scratch.

## Running Locally

**Note:** I am using Ruby 1.9.3 both on Heroku and locally.

Get the source (obviously)

    $ git clone https://github.com/soffes/soff.es.git
    $ cd soff.es

I'm also using Postgres locally. If you don't have it already, you'll need to install Postgres. You can do this easily with [Homebrew](https://github.com/mxcl/homebrew):

    $ brew install postgresql

(Be sure and read the caveats after it installs. You must run some additional commands to get it to complete the installation.)

Run the following queries to setup the user in Postgres:

    $ psql postgres
    # CREATE USER samsoffes SUPERUSER;\q

Now all you need to do to get going, all you need to is bundle (you'll need to install [Bundler](http://gembundler.com) if you don't have it with `gem install bundler`) and setup the database:

    $ bundle install
    $ rake db:create
    $ rake db:schema:load

Now you can start the server with [Foreman](https://github.com/ddollar/foreman):

    $ bundle exec foreman start

Then open <http://localhost:5000> in your browser to see it running. If you have issues getting it up and running, [send me an email](mailto:sam@soff.es).

### Admin

The default credentials for the admin area are `admin` and `passw0rd`. These are obviously different on production or if you have environment variables for `ADMIN_USERNAME` and `ADMIN_PASSWORD`.

To access the admin, go to <http://localhost:5000/admin/posts>.
