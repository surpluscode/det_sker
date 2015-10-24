[![Stories in Ready](https://badge.waffle.io/ronan-mch/det_sker.png?label=ready&title=Ready)](https://waffle.io/ronan-mch/det_sker)
[ ![Codeship Status for ronan-mch/det_sker](https://www.codeship.io/projects/efb8ed90-03c6-0132-4808-06cd9fe8c123/status)](https://www.codeship.io/projects/30535)
det_sker
========

DetSker is a Rails based crowd-sourced calendar. You can see a sample app running [on Heroku](http://thawing-dawn-8343.herokuapp.com/).

# The project
It is been developed for the evenio project with a scheduled release date of January.
You can see the Roadmap to see our vision for the full release while the [Issue Tracker](https://github.com/ronan-mch/det_sker/issues)
 should give a good picture of the current development status.


# Try it out
If you want to try it out, you will need a ruby 2.0 development environment, rails 4 and git.
If this fills you with doubt and confusion, have a look at the [Railsbridge install guide](http://docs.railsbridge.org/installfest/)
and follow relevant points for your platform (ignore all that guff about Heroku).
Once you have cloned the project you will need to install all gems and system dependencies. Some gems have dependencies on system libraries, the following list works for me but you might very depending on your platform and pre-existing libraries.

```
sudo apt-get install postgresql libpq-dev imagemagick libmagickwand-dev libsqlite3-dev
```
Now you're ready to run `bundle install`.  
A custom rake task has been created to show sample data.
This will clear out the database, load the db seeds (default categories and locations), and load some sample fixtures.
To run it, navigate to the root directory of the application in your console and enter the following command:
```ruby
rake det_sker:reload
```
The data contains embedded erb so that event date's relate to the date that they have been loaded in. So reload them
often, otherwise the data will get stale and your app will show nothing.

To create content you will need an admin user, this is defined in one of the fixtures.

# Testing
We use rspec for model and controller tests and FactoryGirl for stubbing.
[Codeship](https://www.codeship.io/projects/30535) is running Continuous Integration and Continuous Deployment of the master branch to [staging](http://thawing-dawn-8343.herokuapp.com/).


# Development setup notes (ubuntu)

 1. Install ruby
    ```
    sudo apt-get install ruby
    ```
 1. Install rvm:
    ```
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --rails
    ```
 1. Activate and install correct ruby version
    ```
    rvm install 2.2.3
    ```
 1. Use it
    ```
    rvm use 2.2.3
    ```
 1. Install bundler
    ```
    gem install bundler
    ```
 1. Install dependencies
    ```
    bundle install
    ```
