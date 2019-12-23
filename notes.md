# Docker Information #
## Start Docker Services ##
Start the database and basic trillian services with:

```
docker-compose up -d
```


## Run Integration Test ##
This automatically runs the integration test: `./integration/integration_test.sh`

```
docker-compose run trillian 
```

## Enter Bash shell in Trillian Container ##
This is what we *most probably* need to mess around with our configured-trillian system:

```
docker-compose run trillian bash
```

------

# Database Information #
Hostname: db
Port: 3306
Name: test
Username: test
userpw: zaphod

uri: "test:zaphod@tcp(db:3306)/test"

docker will internally resolve `db` with the IP address of the database controller.

## Open a Direct MySql Shell to test db from Trillian bash ##
```
mysql -hdb -utest -pzaphod test
```


