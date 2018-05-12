# Upgrade PostgreSQL on Mac OS X

If you mostly develop on a MacBook Pro, you may find it difficult to upgrade to newer PostgreSQL servers. If you need to know how to install PostgreSQL on Mac OS to begin with, you should [read my post on how to do that here](/blog/postgresql/postgres_macos_el_capitan). I'm assuming you've followed that post and have installed PostgreSQL using Homebrew. Assuming that's the case, your PostgreSQL installation directory should be **/usr/local/Cellar/postgresql/9.5.4_1/** and your data directory should be **/usr/local/var/postgres/**.

PostgreSQL ships with a tool called **pg_upgrade**. The general idea behind this tool is that you install the newer version of PostgreSQL, keep the old binary and data directories of the previous version, and **pg_upgrade** will convert your old databases into the new format, loading them onto the new server.

Before running **pg_upgrade**, we need to stop the server:

```shell
brew services stop postgres
# Or, if you're using pg_ctl:
pg_ctl -D /usr/local/var/postgres stop
```

Next, we'll make a copy of our existing old data directory:

```shell
mv /usr/local/var/postgres/ /usr/local/var/postgres.bak/
```

Now we need to initialize a new data directory where our old one used to sit:

```shell
initdb /usr/local/var/postgres/
```

Let that whir and hum until it's done. It shouldn't take that long on a fairly modern system.

Now it's time to run **pg_upgrade**:

```shell
pg_upgrade -b /usr/local/Cellar/postgresql/9.5.4_1/ \
           -B /usr/local/Cellar/postgresql/9.6.1/ \
           -d /usr/local/var/postgres.bak/ \
           -D /usr/local/var/postgres/
```

This command upgrades any old databases to the new format and loads them into the new PostgreSQL server instance. The options are:

-   **-b** The old PostgreSQL installation path. In my case, **/usr/local/Cellar/postgresql/9.5.4_1/**.
-   **-B** The new PostgreSQL installation path. **/usr/local/Cellar/postgresql/9.6.1/**.
-   **-d** The old PostgreSQL data path. **/usr/local/var/postgres.bak/**.
-   **-D** The new PostgreSQL data path. Remember that earlier I moved my old directory to **/usr/local/var/postgres/**.

Now that the upgrade has been completed, there will be some scripts created in your current working directory. One is named "analyze_new_cluster.sh" and the other is "delete_old_cluster.sh". The first one will perform a health check to ensure everything upgraded correctly. The second will delete the old cluster. I would recommend you double check your databases by logging in with psql and ensuring everything looks good before deleting the old cluster, especially if this is a production environment.

Now you are ready to start up the new instance of PostgreSQL:

```shell
brew services start postgres
# Or, if you're using pg_ctl:
pg_ctl -D /usr/local/var/postgres start
```
