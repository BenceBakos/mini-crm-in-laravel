# mini-crm-in-laravel

*This project is for educational purposes only. For use in production, you should contact your local devops engineer, or at least change dangerous defaults in the `docker-compse.yaml` file regarding mariadb.*

## Run

### Start docker
In `/server`:
```
composer install
```

```
docker-compose up
```

### Migrating & Seeding database
```
sudo docker-compose exec myapp php artisan migrate:fresh 
sudo docker-compose exec myapp php artisan db:seed
```
### Link storage
```
sudo docker-compose exec myapp php artisan storage:link
```

### Localhost
Visit [localhost:8001](localhost:8001)

### Admin login
User:
```
test@example.com
```
Password:
```
hardcoded
```

### Troubleshoot

## "file_get_contents(/app/.env): Failed to open stream: No such file or directory" error
```
cp server/.env.example server/.env.exaple
sudo docker-compose exec myapp php artisan key:generate
```


## Flutter
For the sake of simplicity, I added flutter build to the repository, so you don't have to build it.

### Build flutter(only necessary for development):
In `client` folder run:
```
flutter build web
```
after building, the files from `/client/build/web` will be served on `http://localhost:8001/`

### Development in flutter
Flutter let's you use chrome(ium) as your dev device, no need to build every time to use the API, you can use the API provided by laravel in that device. :)

## sources

 - https://hub.docker.com/r/bitnami/laravel/
 - https://hub.docker.com/r/danjellz/http-server/#!

