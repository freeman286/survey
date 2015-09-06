## About

This is the Spider Diagnostic tool at http://spider-diagnostic.herokuapp.com


### Prerequisites and notes

You will need to install the following first:

1. Heroku toolbelt

## Deploy the code to Heroku

TODO

## Getting the production database

To download the database from the production environment to your development computer


#### 1. Create the database locally:

```
bundle exec rake db:create
```

#### 2. Download database

```
heroku pg:backups capture --app spider-diagnostic
curl -o database.dump `heroku pg:backups public-url --app spider-diagnostic`
pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $USER -d survey_development database.dump
rm database.dump
```

### Paypal

# How to find your merchant id

Go to https://www.paypal.com/webapps/customerprofile/summary.view

