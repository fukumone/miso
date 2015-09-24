# miso

WebSocket Demo Application

# To Install and Run:

```
$ echo DATABASE_URL='postgresql://root:@localhost/miso_development' > .env.development
$ rake db:create
$ rake db:migrate

$ bundle install

$ foreman start
# open localhost:5000
```
