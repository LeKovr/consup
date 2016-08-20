
Postgresql shared container
===========================


Dump / restore databases
------------------------


### Dump

Check in postgres.yml:
```
volume:
- app/shared:/opt/shared

env:
- DB_DUMPDIR=/opt/shared/dump
```

Run in consup dir `make pg-exp` or `DB_NAME=<name> make pg-exp` and all or named databases will be backed up into app/shared dir

### Restore

Resore used to load data just after database was created

Any of database related applications (ie consup containers) use dbinit.sh as database init script.
On database creation, it call .ondbcreate script from app startup directory.

So, check in application's fidm.yml:
```
volume:
- ../../app/shared:/opt/shared

env:
- DB_DUMPDIR=/opt/shared/dump
```

Add [.ondbcreate](demo/mmost/.ondbcreate) in app dir, set non existent database in .config and run `make start`. Database (and user) will be created and dump will be loaded.
