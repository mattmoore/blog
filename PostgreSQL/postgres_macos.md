# PostgreSQL on Mac OS X El Capitan

## Homebrew Installation

First, I always use Homebrew. If you're using Mac OS, you really should use Homebrew. You can [get it here](http://brew.sh/).

Once brew is installed, run the following command:

```shell
$ brew install postgres
```

Let it whir and hum a bit and then you'll have Postgres installed!


## Start Your Engines!

There are a couple of different ways to start Postgres on Mac OS.

You can start it up in the foreground:

```shell
$ postgres -D /usr/local/var/postgres/
```

But you'll probably want to run it as a background daemon (service):

```shell
$ pg_ctl -D /usr/local/var/postgres/ start
```

And, of course, you can stop and restart it:

```shell
$ pg_ctl -D /usr/local/var/postgres/ stop
$ pg_ctl -D /usr/local/var/postgres/ start
```

You can also get the current status:

```shell
$ pg_ctl -D /usr/local/var/postgres/ status
pg_ctl: server is running (PID: 20372)
/usr/local/Cellar/postgresql/9.5.3/bin/postgres "-D" "/usr/local/var/postgres"
```


## Create Users

You can create users with the following command:

```shell
createuser -P <USERNAME>
```

Hit enter, and this will prompt for a password. This user won't have permissions initially to create databases though. To do that, you can create the user this way:

```shell
createuser -P --createdb <DB_NAME>
```

Still, you might want to create another "superuser". A superuser is an administrative user that has full privileges in Postgres, so use wisely:

```shell
createuser -P --superuser <USERNAME>
```

If you want to get rid of a user:

```shell
dropuser <USERNAME>
```


## Create Databases

You will need to create a new database:

```shell
$ createdb <DB_NAME> --owner <USERNAME>
```

Now you can connect to the database:

```shell
$ psql -U <USERNAME> -d <DB_NAME>
```

Incidentally, if you named your database the same as your username, you can omit the *-d* option and just enter:

```shell
$ psql
```

It's useful to have a database named after your username so you can test various things out.

Finally, if you want to get rid of a database:

```shell
dropdb <DB_NAME>
```
