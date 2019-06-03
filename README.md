# Make it Cheaper Code Test

## 1. Fork this project to your GitHub

## 2. Do the test

- API documentation on [http://mic-leads.dev-test.makeiteasy.com/api/v1/docs](http://mic-leads.dev-test.makeiteasy.com/api/v1/docs)
- Copy/paste `.env.example` to `.env`
- Setup API token provided by Make It Cheaper
- `bundle install`
- `rails s`

## 3. When finished

- provide a git URL to allow us to read/run your code
- and/or create a pull request

## 4. Your app must start by running the following commands

- `bundle install`
- `rake db:create db:migrate` (If you use a database. It's possible to do the test without any database)
- `rails s`

## Test

```shell
bundle exec rspec
```

## Environments variables

Check `.env.example`

- LEAD_API_PGUID="CFFBF53F-6D89-4B5B-8B36-67A97F18EDEB"
- LEAD_API_PACCNAME="MicDevtest"
- LEAD_API_PPARTNER="MicDevtest"
- LEAD_API_ACCESS_TOKEN=provided_by_make_it_cheaper

## Docker

If you prefer you can use docker to run and work with the application.
You will need `docker` and `docker-compose` installed.

#### To build and run the image and the server
`docker-compose up --build`

#### To run the rails console
`docker-compose run web bundle exec rails console`

#### To get a shell inside the container
`docker-compose run web /bin/bash`

## Solution notes
- I've included only the most basic validations in LeadForm as generally I'm not really sure I should duplicate the validations done by the API, especially since they could change in the future,
- the Swagger docs for the API endpoint show that a 401 unauthorized response from the API returns a json with `message` and `errors` fields but it actually returns only the `message` field. I've added some code that takes that into account (see `LeadAPI#errors_from_response`).
