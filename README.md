# FQL
Festival SQL project for school 

DBMS: postgresql

### To connect to the SGBD (the university one)
```shell
ssh surname.name@sshX.pgip.universite-paris-saclay.fr
# Enter your password: 

psql -h tp-postgres -U <shortusername>_a
# Enter your password: <shortusername>_a
```
Notes: 
- for the ssh session, use whatever machine is currently available and as such replace X with either 1,2,3 or 4.
- if you don't know your `<shortusername>` it is written when you open a terminal (the "name" just before the @) and it is also indicated if you use the following command:

```shell
pwd
```
and it should return you a path looking like this `/home/tp-homeXXX/<shortusername>`

- And yes to connect to your db, you just put shortusername. This is not intended to be secure

### Load DB:
Execute the file `winrar.py` with
```shell
cd Python_scripts
python winrar.py
```
And load the schema and data with
`\i out.sql`
inside the shell with postgres opened
