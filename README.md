[![Build Status](https://travis-ci.org/ronan-mch/det_sker.svg?branch=master)](https://travis-ci.org/ronan-mch/det_sker)
det_sker
========

DetSker is a Rails based crowd-sourced calendar.

# The project
It is been developed for the evenio project. It is not to be confused with IT-Kollektivets Evenio, which was created
for the same purpose but was never completed. The Issue Tracker should give a good picture of the current development status.
The evenio project group defines user stories and priorities. There is a mailing list for issues and discussion.
You can see the Roadmap to see our vision for the full release.

# Try it out
If you want to try it out, you will need a ruby 2.0 development environment, rails 4 and git.
If this fills you with doubt and confusion, have a look at the [Railsbridge install guide](http://docs.railsbridge.org/installfest/)
and follow relevant points for your platform (ignore all that guff about Heroku).
Clone the project and start it up using ```rails s```.
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
We have a couple of Cucumber integration tests, but we're not entirely sure if they're worth the hassle.
Travis is running Continuous Integration and giving us pleasant/unpleasant news about our test suite.
We need tests for our JS functionality, not quite sure what the best way to do this is though.