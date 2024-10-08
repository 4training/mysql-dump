# Clean mysql dump and docker image for it
Aim: Build a mysql container with all data that we need

Documenting what I did:

## Generate the dump
Take a database dump and clean it to remove all personal data:

1. import the database dump:
```
mysql -u USER -p 4training < mysql-dump.sql`
```
2. Run `cleanup.sql`:
```
mysql -u USER -p 4training < cleanup.sql`
```
3. Export the new dump:
```
mysqldump -u USER -p 4training > dump.sql`
```

## Build
```
docker build -t 4training/mysql .
```

## Test the docker image
Run the image locally:
```
docker run -d -p 1234:3306 4training/mysql
```

Connect to it (important: you need to have `-h 127.0.0.1`, otherwise mysql may connect to your local mysql server if you have one running)
```
mysql -h 127.0.0.1 -P 1234 -u root -p
```

## Push to docker hub
Login (finding out the currently logged in user: `docker info`):
```
docker login
```

Push to docker hub:
```
docker push 4training/mysql
```