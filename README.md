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
- LEAD_API_ACCESS_TOKEN=provide_by_maket_it_cheaper
