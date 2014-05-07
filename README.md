det_sker
========

Rails based crowd-sourced calendar
See IssueTracker for user stories and current iteration state.
To load sample data (taken from Modkraft's calendar) run ```rake db:fixtures:load FIXTURES_PATH=spec/fixtures```.
The data contains embedded erb so that event date's relate to the date that they have been loaded in. So reload them
often, otherwise the data will get stale and your app will show nothing.

# Testing
We use rspec for model tests and cucumber for integration. Travis should be doing Continuous Integration for us.
Cucumber tests are still a work in progress. In particular, we need Cucumber tests for our JS functionality.