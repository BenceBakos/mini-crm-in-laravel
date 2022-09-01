# mini-crm-in-laravel

*This project is for educational purposes only. For use in production, you should contact your local devops engineer. Or at least change dangerous defaults in the `docker-compse.yaml` file.*

## What to look for?
 - `/client/lib/`

## Run
```
docker-compose up
```

## Build flutter:
In `client` folder run:
```
flutter build web
```
after building, the files from `/client/build/web` will be served on `http://localhost:8001/`

## Development in flutter
Flutter let's you use chrome(ium) as your dev device, no need to build every time to use the API, you can use the API provided by laravel in that device. :)

## sources

 - https://hub.docker.com/r/bitnami/laravel/
 - https://hub.docker.com/r/danjellz/http-server/#!

