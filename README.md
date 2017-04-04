# PronosticosDashboard [![Build Status](https://travis-ci.org/chischaschos/pronosticos_dashboard.svg?branch=master)](https://travis-ci.org/chischaschos/pronosticos_dashboard) [![Code Climate](https://codeclimate.com/github/chischaschos/pronosticos_dashboard/badges/gpa.svg)](https://codeclimate.com/github/chischaschos/pronosticos_dashboard) [![Test Coverage](https://codeclimate.com/github/chischaschos/pronosticos_dashboard/badges/coverage.svg)](https://codeclimate.com/github/chischaschos/pronosticos_dashboard/coverage) [![Dependency Status](https://gemnasium.com/badges/github.com/chischaschos/pronosticos_dashboard.svg)](https://gemnasium.com/github.com/chischaschos/pronosticos_dashboard)



Try it out:

```
bundle install
bundle exec rake db:setup
bundle exec shotgun
```

In order to test the data importer you need a .env file with settings
like:

```
GOOGLE_DRIVE_EMAIL=some_email
GOOGLE_DRIVE_PASSWORD=some_password
GOOGLE_SPREADSHEET=Pronosticos Sales
```

The example spreadsheet is something like:
https://docs.google.com/spreadsheets/d/1njwIHZfk9zNNoSUr8CN9MfekiTqvdTVlz_geeL959Z4/edit?usp=sharing

The just run:

```
bundle exec rake import
```
