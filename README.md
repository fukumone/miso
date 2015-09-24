# miso

WebSocket Demo Application

# To Install and Run:

```
$ echo DATABASE_URL='postgresql://root:@localhost/miso_development' > .env.development
$ rake db:create
$ rake db:migrate

$ bundle install

$ rackup
# open localhost:9292
```
