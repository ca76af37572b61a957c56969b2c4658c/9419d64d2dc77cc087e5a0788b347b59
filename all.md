# Lab 1

## Git Intro

You will keep all the code (and more) written during this course in a Git
repository.

Teachers will check your work in your Git repo -- not in your text editor.
Having all the task completed with results pushed to your Git repository is a
requirement to access the exam.

GitHub is a well-known and widely used (but not the only one) service to host
Git repositories. We'll use GitHub for this course as a collaboration platform.

If you feel some lack of experience with Git and GitHub we recommend to read
[this tutorial](https://guides.github.com/introduction/git-handbook).
It's also ok to use GUI version if you prefer: [GitHub Desktop](https://desktop.github.com/)


## Ansible Intro

We will use Ansible in this course as a configuration management tool. There are
dozens of configuration management tools out there but we've chosen Ansible as
one of the simplest one to get started with.

You can run Ansible from your laptop directly in case you have Linux or MacOS.
In case you have Windows, we recommend to use
[VirtualBox](https://www.virtualbox.org/wiki/Downloads) running Ubuntu as guest VM.


## Task 1: Set up your Git repository

If you have a GitHub account already, skip this step. Otherwise
[create a new GitHub account](https://github.com/join). The most basic free
account is more than enough -- you won't need any premium GitHub features for
this course.

[Create a GitHub repository](https://github.com/new) named `ica0002`. Note: this
repository should be **private**!

Add our course bot as a collaborator to your repository. This is needed for the
teachers to provision virtual machines for you to practice, and check your task
submissions. Go to your new repository settings, select `Manage access` in the
left menu, click `Invite collaborator` and add user `ica0002-bot` (here is its
GitHub profile: [https://github.com/ica0002-bot](https://github.com/ica0002-bot)).

Once you have completed all the steps above your repository should appear in
[this list](http://193.40.156.86/students.html) automatically within 2..3
minutes. If it does not, please ask the teachers for help.

Note: You don't have to wait until your repository is added to this list, you
can continue with the next task.


## Task 2: Set up SSH keys

**(on a Control node -- same machine you'll be running Ansible from)**

If you have an SSH  keypair already you can reuse it for this course. You can
check for existing SSH keys on your machine by running

    ls -la ~/.ssh

If there are files named `id_rsa` and `id_rsa.pub` you're probably good to go
already. If not, generate a new keypair by running `ssh-keygen`.

Your **public** SSH key can be found in `~/.ssh/id_rsa.pub` file. Add this key
(entire file content) to your GitHub account:
 - In GitHub web UI click your profile icon in the top right corner
 - Select `Settings`
 - Select `SSH and GPG keys` in the left menu
 - Click `New SSH key`
 - Paste the content of `~/.ssh/id_rsa.pub` file to the `Key` field
 - click `Add SSH key`

Once you have added your public key to your GitHub account our bot should detect
it automatically within 2..3 minutes. You can see the result
[here](http://193.40.156.86/students.html).

Note: You don't have to wait until your key is added to this list, you can
continue with the next task.


## Task 3: Install Ansible

**(on a Control node -- same machine where your SSH keys reside)**

Note: we will use Ansible version 4.4.0 (ansible-core 2.11.4) for this course. Teachers will have this
version installed and use it to check your tasks. Your code is considered
working only if it executes successfully on Ansible 4.4.0. If you're using other
Ansible versions -- you're on your own with them.

Note for Windows users: Ansible does not officially support running on Windows,
neither do we support Windows as a workstation. Although we have nothing against
you get Ansible running on Windows, we recommend to install Ubuntu (Desktop
or Server) in VirtualBox, and run the Ansible from there -- it's simpler.

For Linux or OS X, we recommend to use Python virtual env:

    python3 -m venv ~/ansible-venv
    ~/ansible-venv/bin/pip install ansible==4.4.0
    ~/ansible-venv/bin/ansible --version

Last command should print something like

    ansible [core 2.11.4]

Then, add this line to your `~/.profile` file (if the file is missing, create it)
so you can use 'shorter' commands:

    PATH="$HOME/ansible-venv/bin:$PATH"

Logout and log in again. Now this command should also work:

    ansible --version


## Task 4: Test access to your virtual machine

First, make sure that your Git repository is set up correctly -- check
[this list](http://193.40.156.86/students.html) for details.

Then, make sure that your virtual machine is set up -- click your name here and find the
SSH access details on your page. Note the SSH port number!

Finally, test that SSH access works -- run this command on the **control node**
(replace the `122` with the port number from the list above):

    ssh -p122 ubuntu@193.40.156.86 uptime

The command above should print the virtual machine uptime (a few minutes, maybe
hours). This means that you can access your virtual machine via SSH.

If you cannot access the virtual machine or it's stuck in 'Creating' state,
please ask the teachers for help.


## Task 5: Create Ansible playbook

**(on a Control node -- same machine you'll be running Ansible from)**

Example of first playbook you can find [here](01-demo).

Step 1: Create a working directory named `ica0002` (same as your GitHub
repository name).

Step 2: In that directory, create files named `ansible.cfg`, `hosts`,
`roles/test_connection/tasks/main.yaml` and `infra.yaml` -- you can just copy
the contents of `01-demo` directory from the link above.

Note: directory structure and file names matter! Create the files and
directories named exactly as requested.

Step 3: Update your inventory file named `hosts` -- check your own page from
http://193.40.156.86/students.html to find the correct connection parameters.

Step 4: Run the Ansible playbook:

    ansible-playbook infra.yaml

You should see only green "ok" messages.


## Task 6: Commit and your work to GitHub

Once all the previous tasks are done make sure the files you've created in the
Task 5 are pushed to GitHub.

Run this commands in the working directory (`ica0002` created in the Task 5) to
initialize the Git repository:

    git init
    git remote add origin <your-repository-url>

Exact commands can be found in GitHub, on your repository page.

Then, run these commands to commit your changes:

    git add .
    git commit -m 'Lab 1'


Finally, run this command to push your changes to GitHub:

    git push origin main

Once done, the following files should appear in the root of your GitHub
repository:
 - `ansible.cfg`
 - `hosts`
 - `infra.yaml`
 - `roles/test_connection/tasks/main.yaml`


# Week 2 demo: simple web server

Create the directory named `demo`:

    mkdir demo
    cd demo

Create the file `hello.html` in this directory:

    <html>
        <head>
            <title>Demo demo demo!</title>
        </head>
        <body>
            <h2>Hello from webserver!</h2>
        </body>
    </html>

Start the web server in this directory:

    python3 -m http.server

Note that the web server is started on port 8000.

Request the web resource from the browser: http://localhost:8000/hello.html

URL parts:
 - `http`: protocol
 - `locahost:8000`: web server address and port
 - `hello.html`: requested resource

Note that the resource (HTML document created above) is fetched by the client
from the web server and transformed (rendered) to a human readable text. This is
possible because:
 - Web client knows how to talk HTTP to the web server and retrieve documents
 - Web server understands HTTP
 - Web client understands HTML and knows how to render it

Send another request to the web server without specifying any exact resource:
http://localhost:8000.

Note that if no resource is requested, web server just lists all available
resources in this directory. This list is called directory index. This behavior
is common convention for most web servers.

Go back to the terminal where web server logs are printed. You will see
something similar to:

    Serving HTTP on 0.0.0.0 port 8000 ...
    127.0.0.1 - - [07/Sep/2021 17:47:30] "GET /hello.html HTTP/1.1" 200 -
    127.0.0.1 - - [07/Sep/2021 17:49:41] "GET / HTTP/1.1" 200 -

Web server is telling about the requests it got, and how did it respond:
 - `GET` means that the client has requested some resource
 - `/hello.html` is the requested path, `/` means no resource were requested
 - `HTTP/1.1` is the protocol the client used for request
 - `200` is the server response code (means that resource was found on server
   and sent to client)

Web browser is not the only possible web client; there are command-line clients,
clients being part of other services etc.

Try some command line web client:

    wget --output-document=- http://localhost:8000/hello.html
    wget --output-document=- http://localhost:8000
    curl http://localhost:8000/hello.html
    curl http://localhost:8000

You may need to install cURL first, on Debian/Ubuntu/etc. run
`sudo apt install curl` the last two commands are not working.

Note that directory listing is also a HTML page. This is created by web server
automatically.

Hint: start using `wget`, `curl` or better, both. Get some practice with them.
These are essential tools and every developer, tester, devops and sysadmin must
know how to use them.

HTTP is text-based protocol, and it can be easily emulated manually. You don't
even need web client. Run the telnet session and connect to the web server:

    telnet localhost 8000

You may need to install telnet first, on Debian/Ubuntu/etc. run
`sudo apt install telnet` the command above is not working.

Request a resource from the web server:

    GET /hello.html

Press `Enter` twice to send the request to the web server.

Note that we didn't specify the protocol. Web server is smart enough to choose
one automatically.

This example with telnet is purely artificial though. You'll rarely need telnet
to talk to web servers; web browsers and command line tools mentioned above
(`wget` and `curl`) should cover most of the needs.

---

You should now have the basic understanding how web clients talk to web servers
using HTTP protocol.

Make sure to stop the web server (`Ctrl+C`) once done with your experiments!


# Lab 3

Goal of this lab is to deploy a simple web application with Ansible.

The application itself is rather trivial but all the stack needed to get it
running may be challenging to set up.

We recommend approaching the problems one by one, and moving in smaller steps.
This is the fastest way to complete these tasks.


## The application

We couldn't find any good web application for you to practice on -- which is
not too easy nor too difficult to set up, so we've created out own :)

Meet the
[AGAMA: A (very) Generic App to Manage Anything](https://github.com/hudolejev/agama).

Goal of this task is to get this application running on server, in the simplest
possible but still automated production-grade way.


## Requirements

There is one additional requirements for this lab:

**If you are using `pip` to install Python packages make sure to install them to
Virtualenv (not system-wide).**

In any case package instllation via APT -- if possible -- is a recommended
approach.


## Before you start

Update your Ansible inventory file from the [lab 2](../02-web-server)
and change your virtual machine connection parameters. You can find these on
your page [in this list](http://193.40.156.86/students.html).

Note that this step is needed every next day to run your Ansible successfully;
virtual machines are rebuilt every night, and connection details change.


## Task 1: the application

Create an Ansible role named `agama` that deploys the AGAMA application on the
managed host. If you don't remember the exact file structure in the role
subdirectory check out the Ansible related slides from the
[lab 2](../02-web-server).

This role should:
 1. Create a system user named `agama`
 2. Create the directory `/opt/agama` owned by user `agama` where the
    application will be installed
 3. Install application dependencies
 4. Install the application itself

For step 1 use Asnible module `user` as you did in the previous lab.

For step 2 use Ansible module
[file](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/file_module.html)
with attribute `state: directory`.

For steps 3 and 4 check out
[AGAMA installation instructions](https://github.com/hudolejev/agama#installation).

For step 3 use Ansible modules `apt` as you did in the previous lab to install
APT packages.

For step 4 use Ansible module
[get_url](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/get_url_module.html)
to download publicly available files from the Internet to the managed host.

Then, update a play `Web server` created in the previous lab and add a role
named `agama` to the role list. Note that this role should be added **before**
`nginx` -- we'll need the application to be fully set up before configuring the
web server.

This play should apply a role named `agama` on every web server, i. e. should
contain something like this:

	hosts: web_servers
	roles:
	  - users
	  - agama
	  - nginx

Once done, run Ansible to set up Agama, and make sure it executes sucessfully:

    ansible-playbook infra.yaml

After that you can verify that the application is working by running this
command on the **managed host** as user `ubuntu`:

	sudo -u agama AGAMA_DATABASE_URI=sqlite:////opt/agama/test.sqlite3 python3 /opt/agama/agama.py

This is a manual step just to verify the result. Don't do it with Ansible
please.

You should see this line in the output, without any errors:

	 * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)

Note that it's **not** the proper way to run web applications, but is good
enough for this lab to test your solution at this stage.

If you feel that something is not working as expected -- fix it first before
approaching the next task.


## Task 2: uWSGI

Create an Ansible role named `uwsgi` the deploys
[uWSGI](https://uwsgi-docs.readthedocs.io) on the managed host. uWSGI is an
application container server that will run our application.

This role should:
 1. Install uWSGI packages; Ubuntu 20.04 packages that we'll need are named
    `uwsgi` and `uwsgi-plugin-python3`, you can check the package details here:
    https://packages.ubuntu.com/.
 2. Add the uWSGI configuration for AGAMA application to
    `/etc/uwsgi/apps-enabled/agama.ini` file; requirements:
     - AGAMA application should be run by user `agama`.
     - uWSGI should listen on local interface (`localhost` or `127.0.0.1`);
       alternatively, you can use UNIX socket file if you want.
     - AGAMA should be configured to use SQLite3 database located at
       `/opt/agama/db.sqlite3`. No need to _create_ that file explicitly though,
       AGAMA will create it automatically on the first request.
 3. Ensure that uWSGI service is started (unconditionally) and enabled to start
    automatically on system boot.
 4. Ensure that uWSGI service is restarted automatically if uWSGI configuration
    is changed; note that uWSGI service shoud **not** be restarted if uWSGI
    configuration was not changed.

> Note:
> uWSGI on Debian/Ubuntu is pre-configured to read existing configuration files
> automatically from `/etc/uwsgi/apps-enabled` directory. This is Debian/Ubuntu
> specific behavior brought to you by `uwsgi` package from the APT repository;
> default (upstream) uWSGI is configured differently.

For step 2 use the Ansible module `copy` and check out
[AGAMA deployment instructions](https://github.com/hudolejev/agama#running) --
it has uWSGI configuration file example for MySQL; you will need to adjust it
for SQLite.

If you feel that AGAMA configuration example is not enough -- uWSGI
configuration reference can be found
[here](https://uwsgi-docs.readthedocs.io/en/latest/Options.html).

For step 3 use Ansible module 
[service](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/service_module.html)
to manage system services (start, enable etc.).

For step 4 use
[Ansible handlers](https://docs.ansible.com/ansible/latest/user_guide/playbooks_handlers.html)
to handle service restarts correctly; also check out the lecture slides about
Ansible handlers.

Then, update a play `Web server` and add a role named `uwsgi` to the role list.
Note that this role should be added **after** `agama` but **before** `nginx`
-- we'll need the application to be fully set up before configuring uWSGI, and
that should be completed before configuring the web server:

	roles:
	  - users
	  - agama
	  - uwsgi
	  - nginx

Once done, run Ansible to set up uWSGI, and make sure it executes sucessfully:

	ansible-playbook infra.yaml

After that you can verify that uWSGI is started by running this command on a
managed host (port number will be different if you changed it):

	ss -l | grep 5000

You should see the output very similar to this (last column may differ):

	tcp  LISTEN  0  100  127.0.0.1:5000  0.0.0.0:*

This is an indication that uWSGI is set up correctly.

If you feel that something is not working as expected -- fix it first before
approaching the next task.

Hints:
 - uWSGI logs can be found in `/var/log/uwsgi/app` directory. If something is
   not working as expected you will probably find an answer there. You can read
   logs using `cat`, `tail`, `less`, `grep` or any other tools available.
 - You can additionaly run `service uwsgi status` on the managed host to check
   the uWSGI system service status, and view a few latest logged messages -- it
   is surely helpful for debugging.
 - To test the automatic service restart you can simulate a configuration file
   change by adding or deleting an empty line to it; this change means nothing
   to uWSGI but triggers a change for Ansible.


## Task 3: Nginx as uWSGI frontend

In the previous lab we've installed Nginx web server that served static
documents (default mode). We'll now need to reconfigure it to "talk" to uWSGI
to generate dynamic documents instead.

Update the `nginx` role from the previous lab so that Nginx is configured as a
frontend for uWSGI. For that,

 1. Add new file to your Ansible repository: `roles/nginx/files/default`; this
    file should contain a Nginx configuration as uWSGI frontend -- you can find
    related examples in the lecture slides and in the AGAMA deployment
    instructions (section 'Running')
 2. Use Ansible module `copy` to replace the `/etc/nginx/sites-enabled/default`
    file on a managed host with your copy; this file comes from the APT package
    `nginx` and you can safely overwrite it for our labs.
 3. Ensure that Nginx service is restarted automatically if Nginx configuration
    is changed; note that Nginx service shoud **not** be restarted if
    Nginx configuration was not changed.
 4. Ensure that Nginx service is started (unconditionally) and enabled to start
    automatically on system boot.

For steps 3 use Ansible handlers, and for step 4 -- Ansible module `service`.
Solution here should be pretty similar to what you did with uWSGI in the
previous task.

Make sure that Nginx listens on a public interface port 80 -- otherwise your
public URL just won't work :( This line in the `server` section of Nginx
configuration should solve it:

	listen 80 default_server;

If you feel that examples mentioned above are not enough -- Nginx uWSGI module
configuration reference can be found
[here](https://nginx.org/en/docs/http/ngx_http_uwsgi_module.html#uwsgi_pass).

`Web server` play should already contain the `nginx` role from the previous
lab; if it doesn't -- add the role after the `uwsgi`.

Once done, run Ansible reconfigure Nginx, and make sure it executes sucessfully:

	ansible-playbook infra.yaml

Once done, AGAMA should be available at
[your public URL](http://193.40.156.86/students.html).

Feel free to click around and break all the things. If you feel that AGAMA app
has some issues please consider
[reporting them](https://github.com/hudolejev/agama#contributing).

If you need to 'reset' the app just delete the `/opt/agama/db.sqlite3` file on
the managed host; AGAMA will re-create it (if missing) on the next request.

Hints:
 - Nginx logs can be found in `/var/log/nginx` directory.


## Expected result

Your repository contains these files and directories; other files may (and
should) be there but these are the ones that we'll check:

```
ansible.cfg
hosts
infra.yaml
roles/agama/tasks/main.yaml
roles/nginx/files/default
roles/nginx/tasks/main.yaml
roles/uwsgi/files/agama.ini
roles/uwsgi/tasks/main.yaml
```

Your repository also contains all the required files from the previous labs.

AGAMA with uWSGI and Nginx can be installed and configured on empty machine by
running exactly this command exactly once:

	ansible-playbook infra.yaml

Running the same command again does not make any changes on the managed host.

AGAMA web application is available on
[your public URL](http://193.40.156.86/students.html).


# Lab 4

In this lab we'll improve setup from the [lab 3](../03-web-app) by adding a separate database
server for our app. We'll also learn how to use Ansible variables and Vault.

**Important!**

This and some following labs have tasks to handle secrets (passwords, keys etc.).
Make sure **not to commit plain text secrets to GitHub!**

Should you make this mistake, change the secret at once, encrypt it propperly (details are provided
below and in lecture slides) and push the next Git commit that overwrites the secret. Leaked secret
value still remains in the Git history -- but as you have changed it it's not a big problem anymore.

Note that your solution is not accepted if your Git history contains secrets that are still valid
(can be used to access your running services).


## Task 1: Set up Ansible Vault

First, create a master password.
It will be used to encrypt and decrypt other secrets in your Ansible repository.
Use any password generator that you like.

Then, save this password to a file **outside of your Ansible repository**.
One good choice is `~/.ansible/vault_password` -- but you can use other path if you want.
This file should contain just password, nothing more:

    $ cat ~/.ansible/vault_password
    y0ur_p4ssw0rd_h3r3

Make sure this file is readable only to you.
You can use `chmod` command to set the file permissions:

    chmod 600 ~/.ansible/vault_password

Finally, configure the Ansible to read the Vault password from this file --
update `ansible.cfg` and add the following setting to the `defaults` section:

    vault_password_file = ~/.ansible/vault_password

(modify as needed if you use a different path).

You can verify that you did everything correctly by running these commands in the root of your
Ansible repository. Run them exactly as written, without any additional parameters.

Create a plain text file:

    echo WORKS > ansible-vault-test.txt

Encrypt this file; this should print 'Encryption successful':

    ansible-vault encrypt ansible-vault-test.txt

Decrypt this file and print the decrypted text; this should print 'WORKS':

    ansible-vault view ansible-vault-test.txt

If that worked, delete the file, we don't need it anymore:

    rm ansible-vault-test.txt

If these commands run without any errors and you could decrypt the file --
you're all set and good to go.


## Task 2: Update Ansible inventory

For this lab you'll need two virtual machines:
one for an app set up in the previous lab, and another for a standalone database server.

> Two empty machines are created for you if you have completed the lab 3 successfully, and can be
> found [on your page](http://193.40.156.86/students.html) as usually.
>
> If you haven't completed lab 3 yet -- please do that first, wait for machines to be created, and
> then continue with this lab.
>
> If you have completed the lab 3 and still don't see your machines, or see only one --
> please contact the teachers.

Update your Ansible inventory file and make sure machine connection parameters are correct.

Add the new host group `db_servers` to your inventory file.
Add the new machine named "<yourname-2>" there.
Leave the old machine as member of the existing group `web_servers`.

Once done your inventory file should look similar to this:

    elvis-1  ansible_host=... ...
    elvis-2  ansible_host=... ...

    [db_servers]
    elvis-2

    [web_servers]
    elvis-1


## Task 3: Add the init role

We have two machines now, and there are some tasks we want to execute on both of them before the
other configuration starts. One of this tasks is APT cache update that you previously did by adding
an `update_cache: yes` to your `apt` module tasks.

Let's add another role named `init` that will be assigned to every machine as the very first step
in out infrastructure deployment. List of tasks in this role should only contain one task so far --
APT cache update (more tasks will be added later). Let's write it this way:

    - name: Update APT cache
      ansible.builtin.apt:
        cache_valid_time: 86400

In this form it will update the APT cache on the first run, and won't do any further updates within
the next 24 hours.

If you do something like this instead:

    - name: Update APT cache  # WRONG! DON'T DO IT!
      ansible.builtin.apt:
        update_cache: yes

Ansible will update the APT cache on every run, and generate the unnecessary change. And as you
remember, changes in the infrastructure should only happen when needed, and the final Ansible run
should produce **no** changes.

Update the `infra.yaml` playbook and add another play (as the very first one) named "Init".
This play should apply the `init` role to all hosts in your infrastrucure.
This play will need administrative privileges to execute the tasks (add `become: yes`).

Now with this `init` role you don't need to add `update_cache: yes` to `apt` module tasks anymore.
You can delete these from the other roles.

Also delete the `users` role from the plays. It's not needed there anymore.
But please keep the role code in the `roles` directory.


## Task 4: Install MySQL server

Create an Ansible role named `mysql` that will install and configure MySQL server.

Add Ansible tasks to ensure that MySQL server is installed on a managed host:
1. Ubuntu package `mysql-server` is good enough for this task
2. use Ansible module `apt`. Note that you don't need to set the `update_cache: yes` anymore --
   APT cache is updated in the `init` role now
3. Ensure that the MySQL server is started and enabled to run on system boot (service name: `mysql`)

Add another play named "Database server" to `infra.yaml` playbook. It should apply `mysql` roles to
all machines from `db_servers` group. This play should be added after "Init" but before the
"Web server", so the playbook should look something like this:

    - name: Init
      ...

    - name: Database server
      ...

    - name: Web server
      ...

Run this command to apply the changes:

    ansible-playbook infra.yaml

You can verify that the MySQL service is started by running this command manually on a managed host:

    systemctl status mysql

If you'vbe done everything correctly you should see these two lines in the output:

    Loaded: loaded (/lib/systemd/system/mysql.service; enabled; vendor preset: enabled)
    Active: active (running) since Sun 2021-09-19 15:53:48 UTC; 4min 38s ago

Times will be different of course. If you see something else -- please fix it before moving forward.


## Task 5: Configure MySQL server

By default this MySQL server daemon will bind to local interface only.
This means that only local connections (from the same host) will work.
You can check it by running this command on the managed host (3306 is the default MySQL port):

	$ sudo ss -lnpt | grep 3306
    LISTEN  0  151  127.0.0.1:3306  0.0.0.0:*  users:(("mysqld",pid=9001,fd=24))
                    ^-------^
                      This

This MySQL server behavior is configured in `/etc/mysql/mysql.conf.d/mysqld.cnf` file (if you
installed the package mentioned above) by this setting:

    [mysqld]
    bind-address = 127.0.0.1

This behavior needs to be changed -- web application will connect to the database from the different
host, so MySQL server should bind to public interface to accept external connections. Easiest way to
achive this is to configure MySQL to bind to `0.0.0.0` which means 'any possible public interface
on this host'.

> Most of the tutorials in the Internet will suggest you to change `/etc/mysq/mysql.cnf` or
> `/etc/mysql/mysql.conf.d/mysqld.cnf` or any other similar file. It would work, but there is a
> better way -- you can _override_ the configuration instead of changing it.

Add the `/etc/mysql/mysql.conf.d/override.cnf` file to the managed host with the following content:

    [mysqld]
    bind-address = 0.0.0.0

It will override the existing `[mysqld]:bind-address` setting from the default configuration file --
no need to even touch that file. Awesome!

MySQL server needs to be restarted to apply the change. Use Ansible handlers for that -- you can
find more info about Ansible handlers in the [previous lecture slides](../03-web-app).

Once your role is updated, run Ansible again to apply the changes:

    ansible-playbook infra.yaml

Check the output carefully.
Make sure that MySQL server was actually restarted, and configuration override was applied!

If you have done everything correctly MySQL server should bind to public interface now.
Run this command on a managed host again to verify that:

	$ sudo ss -lnpt | grep 3306
    LISTEN  0  151  0.0.0.0:3306  0.0.0.0:*  users:(("mysqld",pid=9001,fd=24))
                    ^-----^
                      This is what you should see

If you see something else in the output, please fix it before moving forward.


## Task 6: Add MySQL connection variables

Web application will use this MySQL server as a storage backend --
so the application needs its own database, and credentials to access it.

MySQL connection parameters: host, database name, user and password -- are different for different
deployments, and are shared among different roles and tasks. These are clear candidates for
_variables_. Let's define them first.

Create a file named `group_vars/all.yaml` in your Ansible repository and define the variables there:

    mysql_host: 192.168.42.xxx
    mysql_database: agama
    mysql_user: agama
    mysql_password: !vault |
              $ANSIBLE_VAULT;1.1;AES256
              61383032323739633432663361343366396634613831346231303935396264623764306537373030
              3565623834333662626562303533636364366665663630370a613562626463623263633162653634
              62613637353161336437636663393338356437663933623061303438306634616434373837383439
              3361303630633039340a323433646332316634643735613936386131306662346563313535386663
              3132

Internal IP address (`192.168.42.xxx`) of your database server can be found
[on your page](http://193.40.156.86/students.html). Note that this _internal_ address is different
from the one that you have added to the inventory file:
 - you (and Ansible) connect to the _public_ IP (`193.40.156.86`) of the managed host
 - other hosts in the same network connect to _internal_ IP

Plase use the "<yourname>-2" machine address; we defined it as database server in the task 2.

Password **must** be encrypted.
You can get the encrypted value using Ansible Vault you have set up in the task 1:

    ansible-vault encrypt_string <mysql-password-for-agama-here>

Simplest way to test you solution here is to run the Ansible playbook again:

    ansible-playbook infra.yaml

It does not use variables yet, but still reads the variable file. If this file has syntax errors --
Ansible will print an error. If it executed successfully -- your variables file is likely fine.


## Task 7: Add MySQL database

Add another task to `roles/mysql/tasks/main.yaml` to create a MySQL database:
 - add this task after the one that starts and enables the MySQL server; MySQL server should be
   running before you can create databases
 - use Ansible module
   [mysql_db](https://docs.ansible.com/ansible/latest/collections/community/mysql/mysql_db_module.html);
   note the module name: it's community module and it's named `community.mysql.mysql_db`, not
   `ansible.builtin.<something>` as others you've seen before

Use the variables you have just defined:

    - name: MySQL database
      community.mysql.mysql_db:
        name: "{{ mysql_database }}"

Note the quotes around `{{ ... }}`. These are needed, otherwise Ansible will fail to parse the code.

On a first try Ansible may fail with an error saying

    The PyMySQL (Python 2.7 and Python 3.X) or MySQL-python (Python 2.X) module is required.

Ansible needs a Python library on the managed host to connect to MySQL and make required changes.
This library is called PyMySQL and can be installed as `python3-pymysql` package from the Ubuntu APT
repository.

Another error you may see is

    unable to find /root/.my.cnf.
    Exception message: (1698, "Access denied for user 'root'@'localhost'")

This means that Ansible could not authorize in the MySQL to make the required changes.

Don't hurry to create this file though. MySQL server (if installed from the package mentioned above)
is configured to authorize local `root` user already. This is done via local UNIX socket file, all
you need to do is to instruct Ansible how to use it. Try this instead:

    - name: MySQL database
      community.mysql.mysql_db:
        name: "{{ mysql_database }}"
        login_unix_socket: /var/run/mysqld/mysqld.sock

Exact socket file location can be found in the MySQL configuration file:
`/etc/mysql/mysql.conf.d/mysqld.cnf`.

Once done, run Ansible to apply the changes:

    ansible-playbook infra.yaml

If everything is done correctly, database `agama` should be created in the MySQL.
You can check that by running this command on a managed host:

    sudo mysql -e "SHOW TABLES" agama

IF database exists (good) it will produce no output. Otherwise an error will be printed:

    ERROR 1049 (42000): Unknown database 'agama'

If you get this error, please fix it before moving forward.


## Task 8: Add MySQL user

Add another task to `mysql` role to create a MySQL user for the web application:
 - use Ansible module
[mysql_user](https://docs.ansible.com/ansible/latest/collections/community/mysql/mysql_user_module.html)
 - use `login_unix_socket` trick from the previous task to get rid of "Access denied" error

Start with this:

    - name: MySQL user
      community.mysql.mysql_user:
        name: "{{ mysql_user }}"
        password: "{{ mysql_password }}"

By default Ansible will create a MySQL user that will only be able to login from the same machine
(called `agama@localhost`). We need a remote user that can login from a different host, it would be
called `agama@%` in MySQL where `%` means 'any host'.
This can be configured using `host` attribute of the `mysql_user` module:

    host: "%"

While creating the MySQL user for your application, make sure that it has access **only** to its own
database (not the other databases). This can be achived with `priv` attribute of the `mysql_user`
module, and `mysql_database` variable you defined in the task 6:

    priv: "{{ mysql_database }}.*:ALL"

Once ready, run the Ansible to apply the changes:

    ansible-playbook infra.yaml

After MySQL database and user are created you can verify that this user can login by running this
command (manually) on the database server (assuming user name is `agama`):

	mysql -u agama -p

It will ask you for the password you encrypted previously (`mysql_password` variable) and once
authorized you should get into MySQL console:

	mysql>

If that works, your MySQL server is set up correctly.

Type `exit` to quit the MySQL console.

If something doesn't work here -- please fix it before moving forward.


## Task 9: Reconfigure AGAMA to use MySQL

Finally, it's time to configure our web application to use MySQL as the storage backend.
This is an easy task now :)

Roles from the previous lab have almost everything needed already. We just need a few minor tweaks.

In the `uwsgi` role:
1. move `files/agama.ini` file to `templates/agama.ini`
2. update the task that uploads the AGAMA app configuration to use Ansible module
   [template](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/template_module.html
   instead of `copy`
3. update the `agama.ini` template and replace the `AGAMA_DATABASE_URI` value to use MySQL server
   you have set up in the previous tasks instead of SQLite file

[AGAMA docs](https://github.com/hudolejev/agama/#running) have the example how to configure MySQL
connection.

Note: when using MySQL backend AGAMA (namely, Python on which it's written) needs additional library
to connect to MySQL. It's already familiar to you `python3-pymysql` from the task 6, but now it also
needs to be installed on the _app server_.

In the `agama` role, update the task that installs AGAMA dependencies to include another package:

    ansible.builtin.apt:
      name:
        - python3-flask-sqlalchemy
        - python3-pymysql           <-- add this


Once ready, run the Ansible playbook to apply changes:

    ansible-playbook infra.yaml

Make sure that uWSGI is restarted after AGAMA configuration file is changed.

If you have done everything correctly AGAMA should be served from your web server public interface.
You can ensure that it uses the MySQL backend by doing this:
1. Add some items, or delete the default ones
2. SSH to the MySQL server and run

        sudo mysql -e "SELECT * FROM agama.item" agama

You should see your recent changes there:

    +----+-----------------------------------------------+-------+
    | id | value                                         | state |
    +----+-----------------------------------------------+-------+
    |  1 | A pre-created item with no particular meaning |     1 |
    |  2 | Another even less meaningful item             |     0 |
    |  3 | I HAVE JUST ADDED THIS TO TEST MYSQL BACKEND  |     0 |  <-- here it is
    +----+-----------------------------------------------+-------+

If AGAMA is not working, make sure to check the uWSGI logs. One often problem is AGAMA trying to use the
wrong Python MySQL library. If you see this error in uWSGI log:

	ModuleNotFoundError: No module named 'MySQLdb'

then it's exactly this case. Workaround is to tell AGAMA which exact Python MySQL library to use.
For this, change the `AGAMA_DATABASE_URI` in the uWSGI configuration file template for AGAMA to something like

	AGAMA_DATABASE_URI=mysql+pymysql://...
	                        ^------^
	                        Add this

Run the Asnible again to apply changes, and check if everything is working as expected.

That's it! All done! That was a long lab (:


## Expected result

Your repository contains these files and directories:

	ansible.cfg
	group_vars/all.yaml
	hosts
	infra.yaml
	roles/agama/tasks/main.yaml
	roles/mysql/tasks/main.yaml
	roles/uwsgi/tasks/main.yaml

Your repository also contains all the required files from the previous labs.

Your repository **does not contain** Ansible Vault master password.

Your deployment customizations: MySQL host, database name, user and password -- are variables and
are stored in `group_vars/all.yaml` file.

Web application that uses MySQL backend, and the MySQL server itself are installed and configured,
each on a separate machine, by running this command once:

	ansible-playbook infra.yaml

Running the same command again does not make any changes to any of the managed hosts.

AGAMA web application is available on
[your public URL](http://193.40.156.86/students.html) -- only on this host that you set up as a web
server, and not on the other one.


# Lab 5

In this lab we will install our local DNS server. After this lab we won't use IP addresses for service communication in the internal network.

## Task 1: Get your startup name

As you might remember, in this course you play a role of Infrastructure Engineer in a small startup. Last week the first app was launched, now it's time to publish it!

For startup name creation you can use:
1. Your head
2. Use startup name generator [example](https://namelix.com/)
3. Use random string generator [like that](https://passwordsgenerator.net/) and just add -ly or -fy to the end

Create your domain name using some fancy root zone:
1. .io
2. .ttu
3. .{yourname}
4. .{anything}

Example of what you should get: *pythox.io* or *junglezilla.rk* (rk came from Roman Kuchin)

## Task 2: Install Bind9 on vm2

Simply install "bind9" package and ensure that service is running even after VM restart.

## Task 3: Configure DNS forwarders

Check default /etc/bind/named.conf.options file to understand how to configure DNS forwarders.

*List* of DNS forwarders should come from variables.

Examples of public DNS forwarders:
 - 1.1.1.1
 - 8.8.8.8
 - 9.9.9.9
 - 9.9.9.10

## Task 4: Configure access rules for DNS server

Allow queries to your DNS server only from our local network and localhost: 192.168.42.0/24 and 127.0.0.0/8.

That networks are subject to change, means that values should come from variables section.

Use Bind9 docs, they have good config examples on page 9. [Link](https://downloads.isc.org/isc/bind9/cur/9.16/doc/arm/Bv9ARM.pdf)

Default config file location: /etc/bind/named.conf.options

## Task 5: Configure master zone

Expected file location on DNS server: /var/lib/bind/db.{startup_name}

Structure of the file you can find in 05-demo or in /etc/bind/db.local on your vm.

Check Bind9 docs page 10 to learn how to reference master zone from config file.

Use variables to feed your master zone file:
    {{ hostvars[{vm}]['ansible_default_ipv4']['address'] }}
Where '{vm}' is your managed host name as defined in inventory file (for example, vm2).

You can get these variables values by running Ansible module "setup" without parameters. [Docs](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/setup_module.html)

Check what variables were collected with Ansible "debug" module. [Docs](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/debug_module.html)

Example of playbook:

	- name: Collect info about all VMs
	  hosts: all <-- Play runs on all hosts
	  roles:
        - setup

	- name: DNS servers
	  hosts: dns_server <- Play runs only on DNS server
	  roles:
	    - bind

## Task 6: Update your VMs DNS settings

By default DNS settings in Ubuntu are managed by service called "systemd-resolved". If you want to manage DNS settings manually, you have to stop this service ans make sure it won't start after VM restart.

List of DNS servers should be in /etc/resolv.conf.

Example of /etc/resolv.conf file:

    nameserver 192.168.42.117
    search pythox.io

Use variables to populate this files: 
    {{ hostvars[{vm_with_bind9}]['ansible_default_ipv4']['address'] }}
    {{ startup_name }}

## Task 7: Update AGAMA MySQL connection

Change IP address to VM name in `mysql_host` variable.

Since now it is not allowed to use any IP addresses in configuration files unless explicitly specified.

## Hints:

Don't forget to restart service after config changes. Use Ansible "service" module for that.

Master zone file with DNS records is *not* a config file. After DB file update use command "rndc reload". You can use Ansible "shell" module inside handler.

Use "named-checkconf" to check syntax of your Bind9 configs. Use "named-checkzone" to check syntax of your zone files.

Use online Jinja2 compiler to try your templates: https://j2live.ttl255.com/

## Expected result

Your repository contains these files and directories:

	ansible.cfg
	group_vars/all.yaml
	hosts
	infra.yaml
	roles/bind/tasks/main.yaml

Your repository also contains all the required files from the previous labs.

Your repository **does not contain** Ansible Vault master password.

DNS server is installed and configured on one of VMs and DNS settings on all VMs are set to use local DNS server with this command:

	ansible-playbook infra.yaml

Running the same command again does not make any changes to any of the managed
hosts.

After playbook execution these commands should work from both your VMs (not from Ansible host):

    ping vm1.<your-startup-domain>
    ping vm2.<your-startup-domain>
    ping vm1
    ping vm2

AGAMA web application is available on
[your public URL](http://193.40.156.86/students.html) -- only on this host that you set up as a web
server, and not on the other one.


# Lab 6

In this lab we will install some monitoring. It's not a complete solution, we will make it better on next labs.

## Task 1: Install Node Exporters

Install Prometheus node exporters on all your VMs. No need to configure them, default settings are good enough.  

## Task 2: Install and configure Prometheus

Install Prometheus on VM that doesn't have bind9 running. For example, if your DNS server from previous lab is vm2, then install Prometheus on vm1 and vice-versa.

Configure Prometheus job "linux" with static_configs. Include **all** your VMs there, even future ones.

Hint: use Ansible variable "groups['all']".

It's not allowed to use IP addresses in Prometheus config, only names are allowed.

## Task 3: Make Prometheus and Node Exporters available from outside

Install Nginx and configure reverse proxy:

    vm:80/node-metrics -> localhost:9100/metrics  # Node exporters
    vm:80/prometheus -> localhost:9090  # Prometheus

VM with Prometheus should have at least 2 "proxy_pass" statements. VM with only Node Exporter should forward only /node-metrics.

## Task 4: Adjust Prometheus service

To make Prometheus reachable from outside, run it with

    --web.external-url=http://<your_public_http_endpoint>/prometheus

Put that argument in /etc/default/prometheus in ARGS variable.

## Task 5: Write some Prometheus queries

Using [docs](https://prometheus.io/docs/prometheus/latest/querying/basics/)
write a query for memory consumption and average CPU load for each VM.

Save queries to prom_queries.txt, you will use them during next lab.

## Expected result

Your repository contains these files and directories:

    ansible.cfg
    group_vars/all.yaml
    hosts
    infra.yaml
    prom_queries.txt
    roles/bind/tasks/main.yaml
    roles/node_exporter/tasks/main.yaml
    roles/prometheus/tasks/main.yaml

Your repository also contains all the required files from the previous labs.

Your repository **does not contain** Ansible Vault master password.

Prometheus and Node Exporters are installed and configured with this command:

	ansible-playbook infra.yaml

Running the same command again does not make any changes to any of the managed
hosts.

After playbook execution you should be able to:

1. Check node metrics by using \<your_VM_http_link\>/node-metrics.

2. Query historical data from Prometheus web interface \<your_VM_http_link\>/prometheus.


# Lab 7

In this lab we will continue with monitoring. The goal of this lab is to create a place where everyone can get overview of infrastructure state.

## Task 1: Install MySQL exporter

Install MySQL exporter from Ubuntu package repository.

Create MySQL user for it.

Docs: https://github.com/prometheus/mysqld_exporter

Use ~/.my.cnf for passing auth data to MySQL exporter. Find under what user it runs and what forder is home folder for that user. Nobody except user itself can read this file. Nobody can change the file.

Content of ~/.my.cnf:

    [client]
    user=your_user
    password=your_password

Make sure that exporter will be restarted in case username/password change.

**No cleartext passwords in repo**

## Task 2: Install Bind9 exporter

Install Bind9 exporter from Ubuntu package repository.

Expose Bind9 statistics for exporter.

Docs: https://github.com/prometheus-community/bind_exporter

## Task 3: Install Nginx exporter

Install Nginx exporter from Ubuntu package repository.

Make sure that Nginx exposes statistics to exporter.

Docs: https://github.com/nginxinc/nginx-prometheus-exporter/

## Task 4: Install Grafana

Install Grafana.

Docs: https://grafana.com/docs/grafana/latest/installation/debian/#install-on-debian-or-ubuntu

## Task 5: Configure reverse proxy

Add necessary locations to Nginx config:

    - location /mysql-metrics -> localhost:(mysqld_exporter_port)
    - location /bind-metrics -> localhost:(bind_exporter_port)
    - location /nginx-metrics -> localhost:(nginx_exporter_port)
    - location /grafana -> localhost:(grafana_port)
    
Helpful docs for Grafana: https://grafana.com/tutorials/run-grafana-behind-a-proxy/

Don't add locations that point to unexisting services. You can use this code for checking if we should expect exporter on this VM or not:

    {% if inventory_hostname in groups['dns_servers'] %}
    location /bind-metrics {
        proxy_pass http://localhost:xyz/metrics;
    }
    {% endif %}

## Task 6: Create dashboard in Grafana

Create Grafana `Main` dashboard that will show:
 - CPU load on VMs
 - Memory consumption on VMs
 - Bind9 status + amount of A DNS queries per minute (bind_resolver_queries_total)
 - MySQL status + amount of selects per minute (mysql_global_status_commands_total)
 - Nginx status + amount of requests per minute (nginx_http_requests_total)

Use Prometheus as datasource.

## Task 7: Configure Grafana provisioning

To avoid manual operations every time do the following during Grafana installation:

 - Set admin password (https://grafana.com/docs/grafana/latest/administration/cli/#reset-admin-password)
 - Configure Prometheus as default datasource (https://grafana.com/docs/grafana/latest/administration/provisioning/#data-sources)
 - Precreate `Main` dashboard (https://grafana.com/docs/grafana/latest/administration/provisioning/#dashboards)

## Expected result

Your repository contains these files and directories:

    ansible.cfg
    group_vars/all.yaml
    hosts
    infra.yaml
    roles/grafana/tasks/main.yaml
    roles/grafana/files/main.json
    roles/mysql_exporter/tasks/main.yaml
    roles/bind_exporter/tasks/main.yaml
    roles/nginx_exporter/tasks/main.yaml

Your repository also contains all the required files from the previous labs.

Your repository **does not contain** Ansible Vault master password.

Grafana, exporters and reverse proxy are installed and configured with this command:

	ansible-playbook infra.yaml

Running the same command again does not make any changes to any of the managed
hosts.

After playbook execution you should be able to:

1. See grafana dashboard by using \<your_VM_http_link\>/grafana.

2. Check your MySQL metrics by using \<your_VM_http_link\>/mysql-metrics.

3. Check your Bind9 metrics by using \<your_VM_http_link\>/bind-metrics.

4. Check your Nginx metrics by using \<your_VM_http_link\>/nginx-metrics.

5. Check your Node metrics by using \<your_VM_http_link\>/node-metrics (lab06).

6. Check your Prometheus web-interface by using \<your_VM_http_link\>/prometheus (lab06).

7. Access Agama by using \<your_VM_http_link\> (lab04).


# Lab 8

In this lab we will setup centralized logging.

## Task 1: Install InfluxDB

Follow the official guide: https://docs.influxdata.com/influxdb/v1.8/introduction/install/#installing-influxdb-oss

## Task 2: Create pinger service on one of VMs

Find bash script "pinger.sh" in 08-files.

Place this script to /usr/local/bin/pinger.

Create a service "pinger" that runs from user "pinger". Check previous 08-files for systemd service unit example. Place it into /etc/systemd/system/.

Don't forget to execute on systemd config change:

    systemctl daemon-reload

Pinger script requires config file:

    /etc/pinger/pinger.conf

Example can be found in 08-files as well.

## Task 3: Add latency monitoring to main Grafana dashboard

Add new Grafana datasource: influxdb:latency. It should be provisoned automaticaly via Grafana provisioning.

Use this datasource for new panel in dashboard from previous lab.

No ip addresses allowed.

## Task 4: Setup Telegraf

Install Telegraf on the same VM where InfluxDB is located. Docs: https://docs.influxdata.com/telegraf/v1.20/introduction/installation/#installation

Repo should be already added in task 1.

Installation steps can be done in "influxdb" role.

Configure Telegraph for only syslog input and only influxdb output. Hint:

    telegraf --help

UDP transport is more preferable.

## Task 5: Setup rsyslog

Configure rsyslog on all VMs to send all logs to Telegraf. Docs: https://github.com/influxdata/telegraf/blob/master/plugins/inputs/syslog/README.md

UDP transport is more preferable.

## Task 6: Create logging dashboard in Grafana

Add one more datasource: influxdb:telegraf

Import Grafana dashboard for Syslog: https://grafana.com/grafana/dashboards/12433

Add new datasource and dashboard to Grafana provisioning.

## Task 7: Add InfluxDB monitoring

Install InfluxDB stats exporter: https://github.com/carlpett/influxdb_stats_exporter

Download binary from latest [release](https://github.com/carlpett/influxdb_stats_exporter/releases/tag/v0.1.1) to /usr/local/bin/.

Create new systemd service. Run it with user `prometheus` as all other exporter do. Describe the service in /etc/systemd/system/prometheus-influxdb-stats-exporter.service.

Add couple more panels to your `Main` Grafana dashboard:

- InfluxDB health (influxdb_exporter_stats_query_success)
- InfluxDB write rate (influxdb_write_write_ok)

## Task 8: Supress InfluxDB request logging

By default InfluxDB logs every request, which floods the logs. Disable logging of HTTP requests. Use `influxdb.conf` from 08-files. 

## Expected result

Your repository contains these files and directories:

    ansible.cfg
    group_vars/all.yaml
    hosts
    infra.yaml
    roles/influxdb/tasks/main.yaml
    roles/influxdb_exporter/tasks/main.yaml
    roles/pinger/tasks/main.yaml
    roles/rsyslog/tasks/main.yaml

Your repository also contains all the required files from the previous labs.

Your repository **does not contain** Ansible Vault master password.

Everything is installed and configured with this command:

	ansible-playbook infra.yaml

Running the same command again does not make any changes to any of the managed
hosts.

After playbook execution you should be able to see all logs in one Grafana dashboard.


# Lab 9

The goal of this and the next lab is to configure the backups for your infrastructure.

In this lab we'll prepare the backup documentation and set up the connection with the backup server.

In the next lab we will set up automatic backups themselves, and improve the documentation
accordingly.


## Current infrastructure

This is what we have built so far:

![](lab-9-infra.png)

Teachers have also prepared a backup server for you. It is located in the same network with all your
virtual machines, so consider it an _on-site_ resource. See task 1 for more details.

For simplicity you can assume that all the data from this server is also copied to another storage
outside of our infrastructure perimeter, and whatever backup you'll upload to this server will also
get an _off-site_ copy automatically -- so you don't need to worry about the `-1-` part of the
`3-2-1` rule.


## Task 1

Configure your DNS server to resolve the backup server name in your domain.

Backup server IP address is 192.168.42.156. Note that this address may change in future, so do not
hard-code it but store as the Ansible variable.

Once done, each of your virtual machines should be able to resolve backup server name. You can check
it by running this command on any of your VMs (replace `foo.bar` with your domain you have set up in
[lab 5](../05-dns-server)):

    host backup.foo.bar.

You should receive something like this in response:

    backup.foo.bar has address 192.168.42.156


## Task 2

Backups will be uploaded from your managed hosts to the backup server over SSH. More details will be
provided in the next lab, but first we'll need to get this SSH connection working. Of course we'll
use SSH keys for user authentication.

For that we'll need a separate user account on every managed host, and also a few more SSH keypairs.

**Remember -- different users should have different private SSH keys!**

Add Ansible role `backup` with the tasks that will
 1. Create a user named `backup` on every managed host
 2. Generate a new SSH key pair for this user

Requirements:
 1. User `backup` home directory should be `/home/backup`
 2. User `backup` public SSH key should be located at `/home/backup/.ssh/id_rsa.pub`

Note that there may be user named `backup` created already on the managed host so you will need to
modify it to match the requirements above. Your Ansible code will be the same for both cases.

Make sure to generate a **new** keypair for the user `backup`; Ansible module
[user](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/user_module.html)
has an option to do it automatically -- check the module documentation.

**DO NOT upload YOUR OWN SSH private key (used for GitHub) to managed hosts!**

If you feel that SSH keys are still unclear topic for you please refer to
[lecture 2 slides](../02-web-server) that covered it.

Add this role to `Init` play created in [lab 4](../04-troubleshooting) and run Ansible to
apply the changes:

    ansible-playbook infra.yaml

Once the user is created and SSH keypair is generated for it the public key will be authorized on
the backup server automatically within some time (usually 15 minutes). A separate account will be
created for your backups, account name will match your GitHub username.

You can focus on the next task so far, and check the result later.

Once the key is authorized on the backup server the `backup` user you've just created should be able
to log in there. You can test it by running this command manually on the managed host:

    sudo -u backup ssh <your-github-username>@backup.<your-domain> id

Example for GitHub username `elvis` and domain `demo.tld` (modify for your names accordingly):

    sudo -u backup ssh elvis@backup.demo.tld id

Note that user account names are different:
 - on your managed host (which is only yours) it is `backup`
 - on the backup server (which is a shared resource) it matches your GitHub username

If the key was authorized successfully you should get something like this in response:

    uid=1042(elvis) gid=1042(elvis) groups=1042(elvis)

Numbers will be different but the username should match your GitHub username.

If you are getting this error:

    Permission denied (publickey).

then please
 1. make sure you are running the command from the correct server: your managed host
 2. make sure you are running the command as the correct user: `backup`
 3. make sure that user `backup` home directory is `/home/backup`: can be checked with `echo ~backup`
 4. make sure that `/home/backup/.ssh/id_rsa.pub` file is there
 5. if the problem is still there, contact the teachers for help


## Task 3

Create a free-text file named `backup_sla.md` in the root of your Ansible repository.

In that file describe the backup approach for:
 - Database servers
 - InfluxDB
 - Ansible repository

This document should contain the information about:
 - Backup coverage -- what is backed up and what is not
 - RPO (recovery point objective)
 - Versioning and retention -- how many backup versions are stored and for how long
 - Usability checks -- how is backup usability verified
 - Restoration criteria -- when should backup be restored
 - RTO (recovery time objective)

Note that you don't need to backup _each and every_ service. In case of disaster recovery it makes
more sense to re-create some service from scratch than restore it from the backup (Nginx, AGAMA,
Grafana, Bind). But for other services backups are must (MySQL and InfluxDB contain data that cannot
be restored with Ansible).

If you are missing some information to complete backup documentation (list of responsible IT staff,
amount of data, value of information, acceptable data loss) -- make it up! Be creative, but try to
keep it adequate and somewhat related to real life.


## Expected result

Your repository contains these files and directories:

    ansible.cfg
    backup_sla.md
    infra.yaml
    roles/backup/tasks/main.yaml

Your repository also contains all the required files from the previous labs.

Backup user is configured as required on every your managed host by running this command:

    ansible-playbook infra.yaml


# Week 10 demo: backup tools

## Intro

There are a lot of ways how to manage SQL backups. This demo will show only a few of them, not
necessarily the best ones -- but should give you some basic understanding of how backups work.

First, we will set up a primitive backup system using `mysqldump` and `scp`.

Then we will improve it using more advanced tools: `rsync` and `duplicity`.

Finally, we will automate our backups with Crontab.

All commands shown below should be run as user `backup` in its home directory `/home/backup` unless
explicitly stated otherwise.

This demo is by no means an example of a complete backup system. Its goal is to illustrate _some_ of
the aspects of a backup process.


## Setup

For this demo we will need to set up a few things first:
 1. App server with Agama stack
 2. MySQL server with Agama database from [lab 4](../04-troubeshooting)
 3. Working connection to backup server as described in [lab 9](../09-backups) -- user
    `backup` on the MySQL server can connect to backup server over SSH
 4. User `backup` access to MySQL database; it will be configred in the following lab task 1

![](./backups-demo-agama.png)

In this demo MySQL database named `agama` is used (yours may be named differently) with a single
table named `item` (it is created by Agama app automatically).

Also in this demo backup server hostname is `backup.foo.bar`. Yours will be different, should be
`backup.<your-domain>` as required in lab 9.

Note: make sure to complete task 2 of the lab 10 before running any further command from this demo.


## Extract data from the existing database

On a MySQL server we should have MySQL server running and database called `agama` created with a
single table called `item`. You can check the table contents by running this command as user
`backup`:

    mysql -e 'SELECT * FROM agama.item'

You should see something like this:

    +----+---------+-------+
    | id | value   | state |
    +----+---------+-------+
    |  3 | Frodo   |     1 |
    |  4 | Samwise |     1 |
    |  5 | Merry   |     1 |
    |  6 | Pippin  |     1 |
    +----+---------+-------+

This is the initial state of our database.

You can extract (called 'dump' in database world) the data from running MySQL database with this
command:

    mysqldump agama

This is the data we will need to backup, and this data should be sufficient to restore the database.

Save the MySQL dump to a file:

    mysqldump agama > agama.sql
    less agama.sql

That's it. We now have a dump of the latest state of MySQL database `agama`, and a simple script to
create another dump when needed.

We will now need to upload the backup to the backup server.


## SCP

SCP, or [Secure copy protocol](https://en.wikipedia.org/wiki/Secure_copy) is the simplest way to
transfer files between two different machines.

You can upload the MySQL dump to backup server with one simple command (note the `:` separating the
server address and the file name):

    scp agama.sql <user>@backup.foo.bar:agama.sql

First argument (`agama.sql`) is the name of the source files to copy, and the second one
(`backup.foo.bar:agama.sql`) is address of the remote machine and the destination file location.
It can be omitted if the file names are the same:

    scp agama.sql <user>@backup.foo.bar:

This will upload the previously created `agama.sql` file to the backup server over SSH. The dump
file copy should now appear **on the backup server**:

    less ~/agama.sql

So the '-2-' part of the backup rule '3-2-1' is implemented: you have two copies of the data stored
locally (on site).

However `scp` might be not the best choice for larger amounts of data.

For the single SQL table with just a few lines it may be enough, but for real data cases with lots
of larger files `scp` has a lot of limitations. For instance, it will upload the entire file every
time. Try running the same upload command again, multiple times:

    scp agama.sql <user>@backup.foo.bar:
    scp agama.sql <user>@backup.foo.bar:
    scp agama.sql <user>@backup.foo.bar:

Note that the number of bytes uploaded (column 3) is the same every time, and is equal to the actual
size of the file:

    ls -la agama.sql

What if we could just upload the difference between files to save the time and network bandwidth?
This approach is called 'synchronization', or 'sync' for short, and there is a tool for that.


## Rsync

[Rsync](https://rsync.samba.org/) is a protocol and simple utility for synchronizing files between
different directories on one computer, and also different computers over the network. We will use it
to upload our MySQL dump file to the backup server as we previously did with `scp`:

    rsync -rv agama.sql <user>@backup.foo.bar:

Same logic here: first argument is the list of files to copy, and the second one is the destination
directory.

Note that amount of bytes transferred is much less than the file size:

    ...
    sent 100 bytes  received 53 bytes  306.00 bytes/sec
    total size is 2,021  speedup is 13.21


This is happening because `rsync` is not uploading the entire file but only the differences; in this
case the file is the same in source (MySQL server) and destination (backup server), so no actual
data chunks are sent at all; only a few bytes (100 sent, 53 received in this example) are spent on
figuring out the difference.

Let's now add some data to the database by add a few more items via Agama web UI. Once done, check
the contents of the database again:

    mysql -e 'SELECT * FROM agama.item'

    +----+---------+-------+
    | id | value   | state |
    +----+---------+-------+
    |  3 | Frodo   |     1 |
    |  4 | Samwise |     1 |
    |  5 | Merry   |     1 |
    |  6 | Pippin  |     1 |
    |  7 | Aragorn |     0 |  <-- added
    +----+---------+-------+

Run the backup script again to extract the latest data:

    mysqldump agama > agama.sql

And run the `rsync` again to sync the dump to backup server:

    rsync -rv agama.sql <user>@backup.foo.bar:

This command should print something similar to:

    ...
    sent 1,434 bytes  received 53 bytes  974.00 bytes/sec
    total size is 2,037  speedup is 1.37

The amount of bytes transferred is now bigger, obviously some changes were sent. But the sent
changes together with `rsync` own protocol payload (1434 bytes) are still smaller than the actual
file size (2037 bytes here).

The win in this example may seem insignificant, but imagine that you have 100 GB database dumps, and
only small part of the actual data is changing between dumps. You will clearly win a lot of network
bandwidth while using `rsync` instead of `scp`.

So now we have at least two options how to upload the backups to the backup server. But are these
backups usable? Let's try to restore them to find out.

For things to look more real let's actually destroy the table first, and also delete all local
backups to make things more interesting:

    mysql -e 'DROP TABLE agama.item'
    rm agama.sql

Database is gone now, all data is lost:

    mysql -e 'SELECT * FROM agama.item'
    ERROR 1146 (42S02) at line 1: Table 'agama.item' doesn't exist

If you refresh the Agam app page it will re-create the database with default items, but all precious
customer data is gone :(

But we have backups! We now need to download the backup to restore the database. With `rsync` it
would just mean syncing the files in the 'other direction', from backup server to database server:

    mkdir restore
    rsync -rv <user>@backup.foo.bar:agama.sql restore/

Note that the first argument is the source file _on the remote machine_ in this case, and the second
one is the destination directory on the server that is being restored.

Also note that restore location is different from the backup location. It is always a good idea to
keep the backup and restore data separately in order not to destroy the latest backup accidentally.
Remember, it is better to have more copies of the backup than have no copies at all.

Check the downloaded backup:

    less restore/agama.sql

It should be the same SQL file as we previously uploaded to the backup server. Now let's try to
restore the database:

    mysql agama < restore/agama.sql

**Note:** this will destroy the current content of `agama` database, if any, and replace it with the
data from the backup!

Check the content of the `agama` table now; it should be the same as prior to the last backup:

    mysql -e 'SELECT * FROM agama.item'

And the Agama web UI should show the correct list now.

So the backup is usable -- it can be used to restore the service.

There is one significant problem with using `rsync` as a backup tool though. It cannot store
multiple versions of the files being synchronized. To be precise, `rsync` can either store one or
two versions of the files, but not more.

Let's add another record to the database:

    +----+---------+-------+
    | id | value   | state |
    +----+---------+-------+
    |  3 | Frodo   |     1 |
    |  4 | Samwise |     1 |
    |  5 | Merry   |     1 |
    |  6 | Pippin  |     1 |
    |  7 | Aragorn |     0 |
    |  8 | Boromir |     0 |  <-- added
    +----+---------+-------+

... and create another backup:

    rm -rf restore
    mysqldump agama > agama.sql
    rsync -brv agama.sql <user>@backup.foo.bar:

Note the `-b` parameter -- this tells `rsync` to create a backup copy of the file being synced if
this file was changed. Check file differences **on the backup server**:

    ls -la agama.sql*
    diff -u --color agama.sql~ agama.sql

If you create another version of the backup, the oldest version will be deleted, and only the last
two versions will be preserved. Add another record and create another backup:

    +----+---------+-------+
    | id | value   | state |
    +----+---------+-------+
    |  3 | Frodo   |     1 |
    |  4 | Samwise |     1 |
    |  5 | Merry   |     1 |
    |  6 | Pippin  |     1 |
    |  7 | Aragorn |     0 |
    |  8 | Boromir |     0 |
    |  9 | Gandalf |     0 |  <-- added
    +----+---------+-------+

    mysqldump agama > agama.sql
    rsync -brv agama.sql <user>@backup.foo.bar:

Check the backup directory content on the backup server:

    ls -la agama.sql*
    diff -u --color agama.sql~ agama.sql

So `rsync` alone does not quite solve the problem if you need more than two versions of the backup
to be stored :(

There are few other things that are essential for backups but cannot be handled with `rsync` alone:
 - You need data compression to optimize both the storage and bandwidth? Write another script.
 - You need to encrypt your backups? Write another script.
 - You need some mechanism to rotate backup versions and delete the old ones? Write another script.
 - And so on.

One important thing to keep in mind about `rsync` that it is not a backup tool -- it is
_data synchronization_ tool. This is a good choice to implement the '-1-' part of the '3-2-1' backup
rule: once you have a repository of usable backups on your backup server you can use `rsync` to
synchronize this repository to some remote (off-site) location.

But how to build this backup repository in the right way, with multiple version of the backup
stored? Surely there is a tool for that, too.


## Duplicity

[Duplicity](http://duplicity.nongnu.org/) is a specialized backup tool that operates over Rsync
protocol to transfer the data and adds some backup specific features to that. It is not installed on
Ubuntu servers by default, you may need to install it first:

    ansible.builtin.apt:
      name: duplicity

Duplicity supports incremental backups, backup versioning, rotation and encryption out of the box.
We will skip the encryption part for this demo, but again, this is only done
_for demonstration purposes_.

**Always encrypt your production backups, and make sure to backup the encryption keys separately!**

Let's create another backup with Duplicity. We have a recent MySQL dump already, we can reuse it:

    duplicity --no-encryption full agama.sql rsync://<user>@backup.foo.bar//home/<user>

Note that we're creating a _full_ backup here. First backup should always be a full one. Second,
third and later could be incremental, but the full backup should be created again from time to time.

Also note that Duplicity is a bit more picky about remote locations; you cannot omit the directory
path as you could with Rsync or SCP. Your directory on the backup server is
`/home/<your-github-username>`; you have to provide it explicitly if using Duplicity.

Check the files created by Duplicity **on the backup server**:

    ls -la duplicity*

Note that three additional files were created:

    duplicity-full-signatures.20211031T181141Z.sigtar.gz
    duplicity-full.20211031T181141Z.manifest
    duplicity-full.20211031T181141Z.vol1.difftar.gz

This solution seems more complicated than a regular `rsync`. So what's the win? Let's add some more
data to our database and create another backup, _incremental_ one this time, to find out:

    +----+---------+-------+
    | id | value   | state |
    +----+---------+-------+
    |  3 | Frodo   |     1 |
    |  4 | Samwise |     1 |
    |  5 | Merry   |     1 |
    |  6 | Pippin  |     1 |
    |  7 | Aragorn |     0 |
    |  8 | Boromir |     0 |
    |  9 | Gandalf |     0 |
    | 10 | Gimli   |     0 |  <-- added
    +----+---------+-------+

    mysqldump agama > agama.sql
    duplicity --no-encryption incremental agama.sql rsync://<user>@backup.foo.bar//home/<user>

Note the `incremental` parameter. On the backup server three more files are created:

    duplicity-inc.20211031T181141Z.to.20211031T181808Z.manifest
    duplicity-inc.20211031T181141Z.to.20211031T181808Z.vol1.difftar.gz
    duplicity-new-signatures.20211031T181141Z.to.20211031T181808Z.sigtar.gz

Let's now inspect what Duplicity is writing to these files (these commands should be run
**on the backup server**; your file names will differ):

    zless duplicity-full.20211031T181141Z.vol1.difftar.gz
    zless duplicity-inc.20211031T181141Z.to.20211031T181808Z.vol1.difftar.gz

Note that incremental backup contains only the part of SQL dump. Is it broken? Surely not. Duplicity
can use this increment, all previous increments and the full backup to restore your original SQL
dump file.

Also note that incremental file contains much more info than just a diff. This is happening because
Duplicity uses other mechanism to compute the file differences: `diff` operates on text files while
Duplicity computes binary data blocks of certain length.

So, main question -- is this backup usable? Restoring it is the way to find out!
Destroy the database first:

    mysql -e 'DROP TABLE agama.item'
    rm agama.sql

... and restore the backup:

    mkdir restore
    duplicity --no-encryption restore rsync://<user>@backup.foo.bar//home/<user> restore/agama.sql
    mysql agama < restore/agama.sql
    mysql -e 'SELECT * FROM agama.item'

Ta-daa!

Duplicity downloaded needed full backup and increments from the backup server and assembled the
original SQL dump file from these. Note that the file itself is the same as we backed up:

    less restore/agama.sql

And there are other Duplicity perks as well:
 - Backup encryption using GnuPG is enabled by default; we were disabling it in this demo with
   `--no-encryption` parameter, but in real life you shouldn't;
 - Backup data is compressed to optimize both the storage and network bandwidth; `rsync` tool would
   only care about the latter;
 - There are options to delete old backups -- these can be used in backup scripts to keep the backup
   repository fit;
 - Cloud storage support: you can upload backups directly to AWS S3 and others -- you may not even
   need a backup server, but only as long as you still keep following the '3-2-1' rule!

So seems that we have a good enough solution to create the backups manually. But good backup is run
automatically by established schedule. So how to automate it?

Of course, there is a tool for that :)


## Cron

Cron is a time based job scheduler for UNIX systems. It is very widely used, and your managed system
will have it installed by default in most cases.

Cron schedules (called 'crontabs') are stored in `/etc/cron.d` directory:

    ls -la /etc/cron.d/*

...and have the following structure:

    <schedule> <user> <shell-command>

`<user>` part is a later addition to some modern Cron implementations; originally Cron jobs could
only be run as `root`.

Cron schedule consists of five fields:

    <minute> <hour> <day-of-month> <month> <day-of-week>

whereas '*' means 'every'. For example, every-minute schedule definition is:

    * * * * *

Daily schedule (01:42 AM) would be defined as

    42 1 * * *

Weekly schedule (02:37 AM every Sunday) would be defined as

    37 2 * * 0

and so on.

You can also define more complex schedules with special characters;
[Wikipedia article on Cron](https://en.wikipedia.org/wiki/Cron#CRON_expression)
is a good starting point.

**Question:** For these Cron schedules, when would the job be run?

    1 2 3 * *

    1 2 3 4 5

    * * 3 4 *

There is a nice online tool to find out: https://crontab.guru.

Crontab is the simplest way to automate you backups: you will just need to write a script to create
a backup, and define a schedule when to run it.

Based on on current setup one possible backup crontab (stored in `/etc/cron.d/backup` for example)
could look like this:

    11 0 * * *    backup  mysqldump agama > agama.sql
    14 0 * * 0    backup  duplicity full agama.sql rsync://<user>@backup.foo.bar//home/<user>
    14 0 * * 1-6  backup  duplicity incremental agama.sql rsync://<user>@backup.foo.bar//home/<user>

This would
 - create a fresh MySQL dump nightly at 00:11 AM,
 - create a full backup every Sunday at 00:14 AM, and
 - create an incremental backup every other day (Monday to Saturday) at 00:14 AM

How to verify if your crontab is correct? Wait for 1..2 minutes and check the system logs:

    tail /var/log/syslog

-- if you made a typo in the crontab you will find something similar there:

    Oct 31 18:29:01 red cron[705]: (*system*backup) RELOAD (/etc/cron.d/backup)
    Oct 31 18:29:01 red cron[705]: Error: bad minute; while reading /etc/cron.d/backup
    Oct 31 18:29:01 red cron[705]: (*system*backup) ERROR (Syntax error, this crontab file will be ignored)

We can add another rule to clean up the backup repository and discard old backups:

    9 0 * * 0    backup  duplicity remove-older-than 30D rsync://<user>@backup.foo.bar//home/<user>

This would delete all backups older than 30 days.

Finally, we can add another rule to the _backup server_ crontab to sync the backup repository to
offsite location periodically:

    30 1 * * *  backup  rsync -v /home/user/duplicity* some-offiste-backup-server:/srv/backup

**Question:** What is RPO (recovery point objective) of this backup system?
For simplicity let's agree that
 - every data transfer session between servers takes 1 minute, i. e. backup is successfully written
   to remote server exactly 1 minute after the command was    started on local server, and
 - server clocks are in perfect sync


## Summary

This demo illustrates the usage of a few basic tools (`mysqldump`, `scp`, `rsync`, `duplicity` and
`cron`) in the context of a backup system.

The result is rather a proof of concept for simple services with small amount of data, but it is
certainly not a complete backup system. We are still missing:
 - monitoring -- how can we make sure that backup was created in time and successfully?
 - verification -- we know how to verify the backup manually, but ideally it should be automated as
   well
 - proper security measures
 - documentation and so on

Once your system grows out of home-made crontabs and Duplicity scripts there are lots of tools on
the market that you could consider:
 - [BorgBackup](https://www.borgbackup.org/) -- simpler one,
 - [Bacula](https://www.bacula.org/) and [Bareos](https://www.bareos.org/en/) -- more sophisticated
   ones,
 - a few proprietary solutions

But none of them will probably work for you as is, out of the box. You will still need to configure
them to do exactly what you need, and for that you will need a practical knowledge how backup
process works internally.

In simpler words, don't even attempt on complex systems until you know how to set up a backup system
with Cron and Duplicity :)


# Lab 10

In this lab we will set up automatic backups for your infrastructure and improve the documentation
from [the previous lab](../09-backups) accordingly.

There are multiple ways how to do backups; on this lab we'll use probably the simplest approach:
 1. Gather data to be backed up from certain services to a single location on this machine
 2. Upload all this data to the backup server
 3. Document the service restore process


## Task 1

Add `mysql_backup` role:
 - ensure that `/home/backup/mysql` directory is created on MySQL servers, owned and writeable by
   user `backup`
 - add this role to `MySQL servers` play

Add `influxdb_backup` role:
 - ensure that `/home/backup/influxdb` directory is created on InfluxDB servers, owned and writeable
   by  user `backup`
 - add this role to `InfluxDB servers` play

Update `backup` role:
 - ensure `/home/backup/restore` directory is created, owned and writeable by user `backup`
 - ensure [Duplicity](http://duplicity.nongnu.org/) is installed; the package is available in the
   Ubuntu APT repository
 - this role should be already added to `Init` play (lab 9)

Also SSH connection to backup server that we've set up in the lab 9 will not work automatically as
it requires that backup server host key is first accepted and verified. While testing in on the
previos lab you've probably seen this prompt:

    The authenticity of host 'backup (192.168.42.156)' can't be established.
    ECDSA key fingerprint is SHA256:ngxLWuTXPrk7UBzeLN2D6DEwA+evAzpU7pDJ4Jd4fGE.
    Are you sure you want to continue connecting (yes/no/[fingerprint])?

It was fixed by typing 'yes', and needs to be automated.

Update `backup` role to create a file `/home/backup/.ssh/known_hosts` on managed hosts with the
following content:

    backup {{ backup_server_ssh_key }}
    backup.{{ domain }} {{ backup_server_ssh_key }}

 - `backup_server_ssh_key` variable should be defined in `group_vars/all.yaml`
 - server key is `ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBSne71MCp6CQCHURWe3CLud6vPDkLfL83Oab/giAI7O`
 - note that server key may change if the backup server is rebuilt
 - `domain` is variable that holds your domain name; might be also called `startup_name` or
   something else -- update `known_hosts` file template accordingly if you want different variable
   names

This file should be owned and writeable by user `backup`. To verify that it works, run this command
on a managed host:

    ssh <your-github-username>@backup.<your-domain>

It shouldn't ask to verify the server key anymore.


## Task 2

Update `mysql_backup` role to configure MySQL access for a `backup` user created in the
[lab 9](../09-backups):
 - MySQL user named `backup` with privileges `LOCK TABLES,SELECT` on `agama` database
 - MySQL client configuration file `/home/backup/.my.cnf`

**Make sure that this `.my.cnf` file is readable only by user `backup` and noone else!**

Hint: you did something very similar for Prometheus MySQL exporter user in the
[lab 7](../07-grafana).

Ensure that user `backup` can create MySQL dumps; run this command manually on your MySQL host:

    sudo -u backup mysqldump agama >/dev/null; echo $?

This should print no errors; exit code (`$?`) should be 0; example:

    0

You may get errors like this when running the command above:

    mysqldump: Error: 'Access denied; you need (at least one of) the PROCESS privilege(s)
    for this operation' when trying to dump tablespaces

Simplest fix is to exclude tablespaces from the dump; add this to `/home/backup/.my.cnf` file:

    [mysqldump]
    no_tablespaces

and try making a dump again. There should be no errors printed now.


## Task 3

Uppdate `mysql_backup` role to schedule MySQL dumps with Cron. For that, ensure that
`/etc/cron.d/mysql-backup` file is created -- this is called "Cron tab".

This Cron tab file content is

    x x x x x  backup  <command>

    ^          ^       ^-- command itself
    |          |
    |          user that runs the command
    schedule

Replace `x x x x x` with the schedule you defined in the `backup_sla.md` (lab 9). Feel free to
update `backup_sla.md` if you feel that schedule defined there is not quite right. You can use
https://crontab.guru/ to check your schedule format.

Note: make sure that backups are completed by 01:40 UTC / 03:40 EET.
All machines are destroyed around 01:50 UTC / 03:50 EET every night.

Use this command for MySQL dumps:

    mysqldump agama > /home/backup/mysql/agama.sql

Note that only `agama` database is backed up; you can safely skip other databases.

Apply your changes with

    ansible-playbook infra.yaml

Use this commands to check that dump was created as scheduled (note the file modification times):

    ls -la /home/backup/mysql

Hint: _for testing period_ you can temporary change the Cron schedule to run the dumps earlier, for
example, use `45 10 * * *` if it's 10:42 now, so you can check if it works and see the results
faster.

**Make sure to change this back to what is defined in `backup_sla.md` once testing is finished!**

**Remember that server time zone is UTC!** If your clock shows 10:42 (Estonian time), server
believes it is 8:42 now. Run `date` command on server and check https://time.is/UTC if unsure.

Check if you can restore the backup; run this on managed host as user `root` (not `backup`; `root`
can write data to MySQL but `backup` user can only read):

    mysql agama < /home/backup/mysql/agama.sql

Make sure that service is up and running and contains all the data from the backup.


## Task 4

Update `/etc/cron.d/mysql-backup` Cron tab and add the backup upload jobs. Example for user `elvis`,
Duplicity running over Rsync, weekly full and daily incremental backups -- your file will look
similar but schedules will probably be different:

    12 0 * * 0  backup  duplicity --no-encryption full /home/backup/mysql/ rsync://elvis@backup.x.y//home/elvis/
    12 0 * * 1-6  backup  duplicity --no-encryption incremental /home/backup/mysql/ rsync://elvis@backup.x.y//home/elvis/

Make sure that whichever schedule you choose the first created backup is full -- not incremental.
You might need to create the first full backup yourself -- just run the command from the Cron tab
manually on the managed host as user `backup`.

Make sure that Duplicity is scheduled to run after local MySQL dump is finished!

It is okay to skip the backup encryption **for this lab**. But remember --
**backups should be encrypted in the production systems!**


## Task 5

Once Duplicity creates its first backup make sure you can restore the service from it. For that,
download the backup to the managed host and try restoring the service.

Example command to download the backup, run on the managed host as user `backup`:

    duplicity --no-encryption restore rsync://elvis@backup.x.y//home/elvis/ /home/backup/restore/

Example command to restore the backup can be found in the task 3. Make sure to restore from
`/home/backup/restore` this time, **not** from `/home/backup/mysql`!

Create a free text file named `backup_restore.md` and describe the detailed process of MySQL backup
restore (what commands to run, as which user, how to verify the result etc.). Restore can be a
manual process, no need to automate it with Ansible. For example,

    Install and configure infrastructure with Ansible:

        ansible-playbook infra.yaml

    Restore MySQL data from the backup:

        su - backup duplicity restore <args>
        <another-command>
        <yet-another-command>

    <add a few words here how the result of backup restore can be checked>

Target audience for this document is someone who has root access to the managed host but who is
**not** familiar with your service setup. In real life it would be your collegue who will be
restoring the service from the backup if you are not available to do it.

For this lab you can treat the teachers as target audience -- we should be able to restore your
service having only your GitHub repository (that also contains backup restore document) and the
backups, without asking you a single question.

Make sure to verify these instructions, i. e. each service should be restorable by running the
commands you documented.


## Task 6

Set up InfluxDB backups similarly as you did for MySQL, and add corresponding section to
`backup_restore.md`.

There are a few differences in case of InfluxDB:
 - Ansible role should be named `influxdb_backup`
 - Cron tab file should be named `/etc/cron.d/influxdb-backup`
 - dump and restore procedures are different

InfluxDB has native dump tool; you can find more details here:
https://docs.influxdata.com/influxdb/v1.8/administration/backup_and_restore.

Ensure that user `backup` can create InfluxDB dumps; run this command manually on your InfluxDB host:

    sudo -u backup influxd backup -portable /tmp; echo $?

This should print no errors; exit code should be 0; example:

    2021/10/31 20:42:19 backing up metastore to /tmp/meta.00
    2021/10/31 20:42:21 No database, retention policy or shard ID given. Full meta store backed up.
    2021/10/31 20:42:21 backup complete:
    2021/10/31 20:42:21 	/tmp/tmp/meta.00
    0

Use this command in Cron tab to create InfluxDB dumps:

    rm -rf /home/backup/influxdb/*; influxd backup -portable -database telegraf /home/backup/influxdb

Here the previous dump is deleted before creating a new one.

Note that only `telegraf` database is backed up; you can safely skip other databases.

To restore the backup you will need to delete existing `telegraf` database first. It also makes
sense to stop the Telegraf service so that it doesn't recreate the database before you could
restore it:

    service telegraf stop
    influx -execute 'DROP DATABASE telegraf'
    influxd restore -portable -database telegraf /home/backup/influxdb

After you have verified that backup was restore successfully, run

    ansible-playbook infra.yaml

to start the Telegraf service.


## Expected result

Your repository contains these files and directories:

    backup_restore.md
    backup_sla.md  # (updated if needed)
    group_vars/all.yaml
    infra.yaml
    roles/backup/tasks/main.yaml
    roles/influxdb_backup/tasks/main.yaml
    roles/mysql_backup/tasks/main.yaml

Your repository also contains all the required files from the previous labs.

Every service you've deployed so far can be restored by following the instructions in the
`backup_restore.md`.


# Lab 11

In this lab we will set up MySQL in highly available mode, namely configure a replication with two
MySQL servers.

A lot of things can go wrong with MySQL in this lab. If you feel that you are stuck and MySQL is
broken beyond repairs -- delete it and start from scratch:

    # On a managed host
    apt-get purge mysql-*
    rm -rf /etc/mysql /var/lib/mysql

    # On the Ansible host
    ansible-playbook infra.yaml

Answer 'yes' is asked about deleting all the databases. We have backups set up, right? :)

Also in this lab we'll try different approach to service provisioning -- first, we'll set up desired
monitoring, and then update the services and watch them appear in Grafana.


## Task 1

Update Prometheus MySQL exporter to export MySQL replication metrics (be default it doesn't export
them).

After the package is installed, ensure `/etc/default/prometheus-mysqld-exporter` file is updated and
has the following content:

    ARGS="--collect.slave_status"

Exporter service restart is needed to apply the changes.

You did something similar for Prometheus in [lab 6](../06-prometheus).

To verify that exporter is reconfigured successfully, open Prometheus Graph UI and run the following
queries:

    mysql_slave_status_slave_io_running
    mysql_slave_status_slave_sql_running

Each query should match at least one MySQL host. Query result value (0 or 1) doesn't matter here.

More info about MySQL replication threads (IO and SQL) can be found here:
https://dev.mysql.com/doc/refman/8.0/en/replication-implementation-details.html.


## Task 2

Add another dashboard named 'MySQL' to Grafana.

Copy all MySQL graphs there from Main dashboard (MySQL status, query statisticss); see
[lab 7](../07-grafana) for details.

Add a few more graphs for every MySQL server (we have one server so far but will have more soon):
 - widget(s) showing MySQL server ids (Prometheus metric `mysql_global_variables_server_id`)
 - graph(s) showing historical data for MySQL server read only status (Prometheus metric
   `mysql_global_variables_read_only`)
 - graph(s) showing historical data for MySQL replication threads (Prometheus metrics
   `mysql_slave_status_slave_io_running` and `mysql_slave_status_slave_sql_running`)

Save your updated Grafana dashboard as `roles/grafana/files/mysql.json` (same as other dashboards in
labs 7 and 8).


## Task 3

Modify your `mysql` role from previous labs and add another MySQL user named `replication`.

This user should use a password to log in and should be able to access this MySQL server from any
host in our network -- similar configuration as `agama` user.

This user, however, should have different permissions: `REPLICATION SLAVE` on every database and
table (`*.*`). Check Ansible module `mysql_user`
[documentation](https://docs.ansible.com/ansible/latest/collections/community/mysql/mysql_user_module.html)
for details on how to achieve this.

Run Ansible playbook to apply the changes.

Run this command on the managed host to verify that the user can log in:

    mysql -u replication -p


## Task 4

Update your Ansible inventory file and add another host to the `db_servers` group. This group should
contain two hosts now.

Update the MySQL configuration file (`override.cnf` discussed in detail in
[lab 4](../04-troubleshooting)) and add the following parameters to the `mysqld` section:

    log-bin = /var/log/mysql/mysql-bin.log
    relay-log = /var/log/mysql/mysql-relay.log
    replicate-do-db = {{ mysql_database }}
    server-id = {{ node_id }}

`replicate-do-db` only limits the replication to one database -- our application database. This is
needed to skip replication of MySQL own database named `mysql` that contains user and permission
info -- these are managed by Ansible on every MySQL server in our case, and it will interfere with
MySQL own replication mechanisms.

`node_id` should be set in `group_vars/all.yaml` and contain the last octet of the server IP
address:

    node_id: "{{ hostvars[inventory_hostname]['ansible_default_ipv4']['address'].split('.')[-1] }}"

Run the playbook again. It should install and configure the MySQL server on both machines.

Your Grafana dahsboard for MySQL should show that
 - both MySQL servers are up
 - id for every MySQL server as set in the configuration file -- make sure they are different!

If the new server is not added to Grafana automatically:
 - Make sure that MySQL is running on that server
 - Make sure that MySQL Prometheus exporter is running
 - Make sure that the new node is added to Prometheus targets for `mysql` job


## Task 5

Now it's time to test if replication actually works. Note: this is a one-time manual task.

First, ensure that `agama` database is empty on **source server**; run this command as root:

    mysql -e 'SHOW TABLES' agama

This command should print nothing: no errors, no output. It means that `agama` database is there,
and it has no tables.

If you see something like this:

    +-----------------+
    | Tables_in_agama |
    +-----------------+
    | item            |
    +-----------------+

it means that `agama` database is already initialized (you probably opened the Agama page at least
once, and it created the table automatically). Database needs to be wiped before we set up the
replication. Run this command as root to delete and re-create the database:

    mysql -e 'DROP DATABASE agama; CREATE DATABASE agama'
    mysql -e 'SHOW TABLES' agama

Output should be empty now; no errors should be printed.

Although not required for a fresh install, it might be needed to reset the MySQL source if you are
replicating the previously configured MySQL server that already has some changes recorded. Open the
MySQL shell on the source server by running `mysql` as user root, and there run

    STOP REPLICA;
    RESET MASTER;

Next: set up the replication; open the MySQL shell on **replica server** by running `mysql` as user
root, and there run:

    STOP REPLICA;
    CHANGE REPLICATION SOURCE TO
        SOURCE_HOST='<your-mysql-source-host>',
        SOURCE_USER='replication',
        SOURCE_PASSWORD='<your-replication-password>';
    RESET REPLICA;
    START REPLICA;
    SHOW REPLICA STATUS\G

The output of the last command should show contain no errors; fileds to check are `Last_IO_Error`
and `Last_SQL_Error`.

Chek your Grafana dashboard for MySQL:
 - graphs should show that one of the MySQL servers now has both IO and SQL replication threads
   running
 - both threads should run on exactly **one** server -- not both!

If there are no errors, open the Agama page and generate a few changes there: add or delete records,
change record status. Ensure that the change is replicated -- you can check it by running this
command on both MySQL source and replica servers as user root:

    mysql -e 'SELECT * FROM agama.item'

Also re-check the replication status -- run this on replica server as user root (note the `-Ee`
switch: `E` tells MySQL to format the output vertically):

    mysql -Ee 'SHOW REPLICA STATUS'

It should contain no errors in `Last_IO_Error` and `Last_SQL_Error` fields.

If the output of the last command contains something similar to

    Last_SQL_Error: Error executing row event: 'Table 'agama.item' doesn't exist'

It means that the MySQL replica cannot pick up some entries from the replication log on source
server (creating the database), and fails to proceed with the next steps (adding rows). This may
happen if you have created and populated the database _before_ setting up the replication. If you
are getting this error -- please re-do this task; you probably didn't wipe the database on source
server properly.

Otherwise -- congratulations! You now know how to set up the simple MySQL replication.

Next, let's automate it (:


## Task 6

We skipped one very important step in the previous task: MySQL replica should be read only.
Previously we've set MySQL parameters in the configuration file, and applying those required MySQL
server to be restarted. Some of the parameters, however, can (and should) be applied _dynamically_,
without the server restart. Setting read only mode dynamically will allow us to swap the source and
replica server without restarting the MySQL process.

There is Ansible module
[mysql_variables](https://docs.ansible.com/ansible/latest/collections/community/mysql/mysql_variables_module.html)
that handles dynamic MySQL parameters. Update the `mysql` role and add a task (or tasks) that will
set the read only mode for replica server; example:

    community.mysql.mysql_variables:
      variable: read_only
      value: "{{ 'OFF' if inventory_hostname == mysql_host else 'ON' }}"
      mode: persist

Another example (use this or the previous one, but not both):

    community.mysql.mysql_variables:
      variable: read_only
      value: 'ON'
      mode: persist
    when: inventory_hostname != mysql_host

    community.mysql.mysql_variables:
      variable: read_only
      value: 'OFF'
      mode: persist
    when: inventory_hostname == mysql_host

 - corresponding MySQL variable name is `read_only`
 - value `ON` or `OFF` is selected based on the host role here; if the host name matches the
   `mysql_host` value (this is the host Agama connects to; covered in labs 4 and 5) then `read_only`
   is set to `OFF` and writes are allowed, otherwise `ON` -- only reads are permitted
 - `mode: persist` is needed to preserve the read only mode after MySQL restart

Feel free to update the task for your needs.


## Task 7

Finally, we will need to set up the actual replication. You have already tried the needed steps
manually in the task 5, and Ansible module
[mysql_replication](https://docs.ansible.com/ansible/latest/collections/community/mysql/mysql_replication_module.html)
will be very useful to automate it.

Note that setting up replication in our setup is **destructive** action:
 - you should only configure replication with empty database, after the `agama` database is created
   but before the Agama app is deployed
 - running Ansible again without any code changes should not set up the replication again

Before setting up the replication automatically with Ansible, delete the `agama` database created
and updated in the previous task. Run this command manually on **every** MySQL server as user root:

    mysql -e 'DROP DATABASE agama'

Then, create two handlers in the `mysql` role:

    - name: Reset MySQL source
      community.mysql.mysql_replication:
        mode: "{{ item }}"
        login_unix_socket: /var/run/mysqld/mysqld.sock
      loop:
        - stopreplica
        - resetprimary
      when: inventory_hostname == mysql_host

    - name: Reset MySQL replica
      ...

`Reset MySQL source` will be run once for every element of the `loop` list:
 - once for `mode: stopreplica`
 - once more for `mode: resetprimary`

`Reset MySQL source` will only be run on MySQL source host: `when: inventory_hostname == mysql_host`

Use it as an example, and write the handler for MySQL replica:
 - it should have 4 steps as described intask 5 (`SHOW REPLICA STATUS` step can be skipped)
 - it should be run only on replica servers (not source)
 - check `mysql_replication` module docs for ideas, details and examples

Both handlers should be notified if the task that changes the read only mode (on or off) generates a
change:

    notify:
      - Reset MySQL source
      - Reset MySQL replica

Once ready, run the Ansible to apply the changes. Check your Grafana dashboard for MySQL:
 - both MySQL servers should be up
 - exactly one MySQL server should accept writes; another should be read only
 - IO and SQL replication threads both should be running exactly on one MySQL server, and that
   server should be read only

Open the Agama page (sure thing it should work) and generate some changes: add or delete some
records, change record states. Ensure that the changes are propagated to both databases, source and
replica -- run this on corresponding MySQL server as user root:

    mysql -e 'SELECT * FROM agama.item'


## Task 8

Implement and try the source/replica switchover with Ansible.

This should be really simple now, you have all the needed resources already.

The only missing thing is triggering replication on MySQL source host change; fix it by adding
`notify` statement from the task 7 to the task that sets up the read only mode to MySQL hosts (task
6).

Then, change the `mysql_host` value in the `group_vars/all.yaml` (from machine 1 to machine 2 or
vice versa) and run the Ansible:
 - MySQL source server should be changed
 - MySQL replication should be reconfigured on both MySQL servers
 - MySQL processes should not be restarted
 - Agama configuration should be change to connect to another database server
 - uWSGI should be restarted so that Agama could pick up the change

Check the Grafana dashboard. Verify that MySQL source and replica are changed, there is still one
source and one replica, which is read only.

Ensure that Agama still works, and any changes you make are visible in both databases.


## Task 9

There is one more problem to solve. Now when we have two MySQL servers, backups are also run on
both, which is not right:
 - database content on all servers should be the same, so no need to backup it twice
 - running `mysqldump` from both source and replica at the same time may end with two unusable dumps

Note that just deploying the Cron tab to only one server is not enough. If the source and replica
are swapped, not only the Cron tab needs to be deployed to the new server but also deleted from the
old one.

Easiest way to do it is to create the Cron tab on every server, but only add the jobs on replica.
Update the Cron tab template in the `mysql_backup` role created in [lab 10](../10-backups) to
something like:
 this

    {% if inventory_hostname != mysql_host -%}
    x x x x x  backup  <command>
    ...
    {% endif -%}

Run the Ansible again to apply changes. Make sure that Cron jobs are is deleted from the MySQL
source server (Cron tab is empty).

Then, swap the source and replica servers as you did in task 8. Make sure that Cron jobs is added to
the new replica, and deleted from the previous one.


## Expected result

Your repository contains these files and directories:

    ansible.cfg
    hosts
    roles/grafana/files/mysql.json
    roles/mysql/tasks/main.yaml
    roles/mysql_backup/tasks/main.yaml
    roles/mysql_exporter/tasks/main.yaml

You can change MySQL source and replica with changing only `mysql_host` variable value.

You can verify if MySQL replication is working by running needed shell commands on MySQL replica
server.

You can verify if MySQL replication is working by checking the Grafana dashboard for MySQL.


# Lab 12 demo: Docker basics

## Intro

First, we will need to install Docker daemon and client tools. There are multiple ways how to do it,
but we will use the simplest possible approach for the demo:

    - name: Docker package
      ansible.builtin.apt:
        name: docker.io

    - name: Docker service
      ansible.builtin.service:
        name: docker
        state: started
        enabled: yes

Note the package name, `docker.io` -- this name is inspired by previous Docker website name and
chosen not to conflict with another package in Debian and Ubuntu repositories called `docker`; the
latter has nothing to do with containers:

    Package: docker
    Description: System tray for KDE3/GNOME2 docklet applications

    Package: docker.io
    Description: Linux container runtime

Also note that if you decide to install the package from the Docker own repository as described
[here](https://docs.docker.com/engine/install/ubuntu/) the DEB package name will be different again:
`docker-ce`.

For this demo a bit older Docker version from Ubuntu `universe` repository is just fine.

Next, let's make sure that Docker container runtime itself is up and running:

    systemctl status docker

... and the Docker client is working:

    docker info


## First Docker container

Docker team has prepared one very simple container image to verify the Docker installation. Let's
download and run it:

    docker run hello-world

It should print something like

    Unable to find image 'hello-world:latest' locally
    latest: Pulling from library/hello-world
    2db29710123e: Pull complete
    Digest: sha256:cc15c5b292d8525effc0f89cb299f1804f3a725c8d05e158653a563f15e4f685
    Status: Downloaded newer image for hello-world:latest

    Hello from Docker!
    This message shows that your installation appears to be working correctly.

	...

Read the output carefully. It explains in details what Docker just did.

Docker Hub is a public Docker registry, in simple words, it is the "package repository" for Docker
where package is the container image.

The action above has left some artifacts on the Docker host, namely the downloaded container image:

    docker images

Now if you run `docker run hello-world` again it will not re-download the container but use the
local version instead:

    docker run hello-world


## Second Docker container

We cannot do much with this `hello-world` app. So let's run another container:

    docker run -it alpine /bin/sh

 - `alpine` here stands for image name; this is an image for container with
   [Alpine Linux](https://alpinelinux.org/), a minimalist Linux distribution quite popular for
   containerized applications;
 - `-it` means `--interactive --tty` which instructs Docker daemon to start the interactive session
   with the container and allocate the pseudo-terminal for that; check `docker run --help` for more
   details;
 - `/bin/sh` is the command we asked Docker to run inside the container

As a result, terminal prompt should change to something like

    / #

This is the shell inside the container! Let's look around there:

    cat /etc/issue
    > Welcome to Alpine Linux 3.14
    > Kernel \r on an \m (\l)

    uname -a
    > Linux eea680d8212b 5.4.0-72-generic #80-Ubuntu SMP Mon Apr 12 17:35:00 UTC 2021 x86_64 Linux

The first command will print the system identification -- the system running in the container as
seen by applications is Alpine Linux v3.14.

The second command will print the Linux kernel version, and you can easily notice that the kernel
(Ubuntu) does not quite match the userspace (Alpine).

This is how operating system virtualization (or containerization) work: both host and guest systems
share the same Linux kernel but their userspaces are isolated from each other. Let's make some
damage in the container:

    # Make sure to run this in the container, *not* on the Docker host!
    rmdir /opt
    exit

Note that `/opt` directory is still present on the host; it was only removed from the container:

    ls -la /opt

Also note that the Linux kernel version on the host system is the same as was in the container:

    uname -a


## Containerized service example

Docker containers were designed to run services. Every container is expected to run exactly one
process. In previous example the process was `/bin/sh` and it was running in interactive mode. Once
we terminated the session the process was terminated as well. You can list the terminated Docker
containers with

    docker ps -a

Running processes can be listed with

    docker ps

Note that there are none. So let's start on of the processes in Alpine Linux container and leave it
running in daemon mode. This process could be a `top` utility:

    docker run -d alpine top

`-d` here means `--detach`: Docker will launch the container and leave it running without keeping
any interactive session open.

The process should now appear in the list of running Docker containers:

    docker ps

You can attach to the running container using its id:

    docker attach 4e411b27a685

You should see the `top` process running. Note that it is the only running process in this
container; although it is technically possible to launch more than one process in the same container
it is still a bit of a witchcraft, and Docker discourages these attempts.

You can detach from the process by pressing `Ctrl+C`. The process will be terminated, and so the
container that hosted it:

    docker ps
    docker ps -a


## Some real services

Now once we know the basics of the Docker container anatomy we can try running some real services,
containerized. One possible candidate is Nginx web server:

    docker run -d nginx
    docker ps

It will take some time to download, but in the end you should see the Nginx container running and
listening on port 80/tcp. But is you check the local processes listening on port 80 you will find
none:

    ss -lnpt

(If there is something listening on port 80, it may be another Nginx installed locally -- not the
one from the container.)

This is another example of process isolation. By default Docker containers will not bind to host
system ports automatically, this needs to be allowed explicitly. Let's stop the running Nginx
container and launch it again, this time providing the port configuration:

    docker stop bb5f196693ea
    docker run -d -p8081:80 nginx

`-p8081:80` here means `--publish 8081:80` -- this exposes container's port 80 and binds it to
host's port 8081. This is done by another service called Docker proxy that listens on port 8081 on
the Docker host and forwards all the incoming traffic to the port 80 of the container:

    ss -lnpt

It should now be possible to communicate with the Nginx process running in the container via port
8081 on the Docker host:

    curl http://localhost:8081

should return the page served by Nginx.


## Grafana container

Let's get it further and deploy the entire Grafana in Docker container:

    docker run -d -p3001:3000 --name=grafana grafana/grafana

Note the `--name=grafana` part. We are naming the container `grafana` -- otherwise Docker will
generate some random name for it. You can 	find the container name in the rightmost column of
`docker ps` output.

Grafana will listen on the port 3000 in the container but we've instructed Docker proxy to bind to
port 3001 on the Docker host and forward all the incoming traffic to the port 3000 in the container:

    ss -lnpt

We can access Grafana login page from the same host now:

    curl http://localhost:3001
    curl -L http://localhost:3001

At this point it makes sense to stop doing the damage manually and switch to Ansible. Yes, there is
a module to manage Docker containers:
[docker_container](https://docs.ansible.com/ansible/latest/collections/community/general/docker_container_module.html)!

Let's take the last demonstarted `docker run` commands and reimplement then with Ansible:

    - name: Grafana Docker container
      community.docker.docker_container:
        name: grafana
        image: grafana/grafana
        published_ports: "3001:3000"

As you remember we've set up a Nginx proxy on the previous labs to serve Grafana from a custom path
like `http://193.40.156.86:xx80/grafana`, and that required additional Grafana configuration in
`grafana.ini` file. This file is now located in the Docker container now, and although it's possible
to change it dynamically -- there is a better way.

Certain files and directories from the host system can shared with the container. Docker implements
this as "volume mounting", so that shared directory is seen as a volume inside container. Actually
some files are already mounted inside container; you can check it by running

    docker exec grafana df

`docker exec` followed by a container name (or id) tells Docker daemon to execute this command
(`df` in this example) inside the container. Note that it doesn't kill the main process as when
using `attach`.

You'll notice a few rows like these:

    /dev/vda1  9983232  2652628  7314220  27%  /etc/resolv.conf
    /dev/vda1  9983232  2652628  7314220  27%  /etc/hostname
    /dev/vda1  9983232  2652628  7314220  27%  /etc/hosts

These are virtual volumes as container sees them, and are actually just files Docker daemon
generated and mounted inside the container. Note that these files are _not_ the same as on host
system:

    docker exec grafana cat /etc/hostname  # this shows the file in the container
    cat /etc/hostname                      # this shows the file on the host system

So let's create Grafana configuration directory, and mount it inside the container:

    - name: Grafana directory
      ansible.builtin.file:
        name: /opt/grafana
        state: directory

    - name: Grafana Docker container
      community.docker.docker_container:
        name: grafana
        image: grafana/grafana
        volumes: /opt/grafana:/etc/grafana    # <-- added this
        published_ports: "3001:3000"

`/opt/grafana:/etc/grafana` means that `/opt/grafana` directory from the host system is mounted as
virtual volume inside the container to `/etc/grafana`. Run the Ansible and check the result:

    docker exec grafana df

Oh no! The container is not running! Why? What happened?

    docker ps -a

You can find the reason in the container logs; it also workes with the stopped containers:

    docker logs grafana

You'll find the problem pretty quickly:

    GF_PATHS_CONFIG='/etc/grafana/grafana.ini' is not readable.
    failed to parse "/etc/grafana/grafana.ini": open /etc/grafana/grafana.ini: no such file or directory

The directory we have mounted is empty, and it has "overwritten" existing `/etc/grafana` directory
from the container. So Grafana could not read the `grafana.ini` file because, well, there were _no_
such file in the container! We have this file created on the previous labs, let's add it:

    - name: Grafana configuration
      ansible.builtin.template:
        src: grafana.ini.j2
        dest: /opt/grafana/grafana.ini   # not that path is changed form /etc/ to /opt/

Grafana container should be running now, and configuration directory should be mounted inside:

    docker ps
    docker exec grafana df

We're missing one more step to access the Grafana: Nginx proxy configuration needs to be changed to
serve Grafana from the Docker container:

    location /grafana {
        proxy_pass http://localhost:3001;  # <-- here
    }

After Ansible is run to apply the changes Grafana should be available on one of your public URLs:
http://193.40.156.86:xxx80/grafana

You should be able to log in to Grafana with password you specified in `grafana.ini`. Or, if you
didn't change it in `grafana.ini`, default login credentials are `admin:admin`.

Further Grafana configuration will be covered in the upcoming lab.


## Summary

In this demo we have discussed main Docker container lifecycle stages.

We've also learned how to

 - start Docker containers with `docker run` and with Ansible module `docker_container`
 - publish container ports to Docker host
 - mount directories from the Docker host to the containers
 - list available Docker images with `docker images`
 - list running Docker containers with `docker ps` and failed containers with `docker ps -a`
 - run commands inside containers with `docker exec`
 - stop containers with `docker stop`
 - delete containers with `docker rm`
 - read container logs with `docker logs`


## Final notes

This is a very basic demo on how to handle Docker containers. We did not create any container
images, yet, but only used available, ready made images from Docker Hub.

Images we used:
 - https://hub.docker.com/_/hello-world
 - https://hub.docker.com/_/alpine
 - https://hub.docker.com/_/nginx
 - https://hub.docker.com/r/grafana/grafana

**SECURITY NOTE ABOUT DOCKER HUB**

Do not blindly trust images from Docker Hub!

If downloading an image, make sure it is an official Docker image!

See also: https://docs.docker.com/docker-hub/official_images

Sometimes it is hard to tell if the image is released buy Docker team or the product team. Check out
these two and carefully inspect the pages:

 - https://hub.docker.com/_/nginx
 - https://hub.docker.com/r/grafana/grafana

Only one of them is official Docker image as it is built by Docker team. Another, although also
called 'official', is not provided by Docker but by the product developers. Both teams interpret the
word 'official' differently; you should understand this difference if working with Docker Hub.

**Only use Docker Hub images from the authors whom you trust!**


# Lab 12

In this lab we will install Docker, and redeploy a few services to run in Docker containers.

We'll learn how to launch a container from Docker Hub image, and also how to build the Docker image
locally.

Some hints common for all tasks:
 1. should you need to debug someting inside the container you can run most standard Linux commands
   there as `docker exec <container-name> <command>`, for example
   `docker exec grafana cat /etc/resolv.conf`
 2. container name can be found in the `docker ps` output (last column)
 3. DNS requests won't work from the container running on the _same_ host as Bind server unless you
   authorize requests from the container network; check [lab 5](../05-dns-server) for details on how
   to configure Bind access rules, and `docker exec <container-name> ip a` to find the network
   address (starts with `172.`)


## Task 1

Add another role named `docker` that will install Docker on your managed host.

Note: double check the package name you are installing! Package named `docker` in Ubuntu package
repository has nothing to do with containers. You will need a package named `docker.io` (yes, with
dot). You can find the package by running these commands on a managed host:

    apt show docker
    apt show docker.io

You will also need to install another package to allow Ansible to manage Docker resources. The
package name is `python3-docker`, it is a Python library that allows Ansible modules to execute
Docker commands and manage your Docker resources.

Ensure that the Docker daemon is running and is enabled to start on system boot.

You can check if Docker daemon is running with this command run as root on the managed host:

    docker info


## Task 2

Rename the existing Grafana files:

    roles/grafana/handlers/main.yaml --> roles/grafana/handlers/main_apt.yaml
    roles/grafana/tasks/main.yaml --> roles/grafana/tasks/main_apt.yaml

You won't need them anymore for any further labs on this course, but we recommend to keep the files
in your repository; you might find them useful in your future endeavors.

If you have already installed Grafana to one of your managed servers as described in
[lab 7](../07-grafana) -- stop and uninstall it; run these commands manually as root:

    service grafana-server stop
    apt purge grafana
    rm -rf /etc/grafana
    rm -rf /var/lib/grafana

Create the new file `roles/grafana/tasks/main.yaml` that will install and start the Grafana in the
Docker container. Use Docker image named [grafana/grafana](https://hub.docker.com/r/grafana/grafana))
from the Docker Hub, and Ansible module
[docker_container](https://docs.ansible.com/ansible/latest/collections/community/docker/docker_container_module.html).

Make sure the container you start is named exactly `grafana`. If you don't set the name Docker will
create a random name for the container, and it will make the debugging harder.

Also provide this parameter to `docker_container` module to avoid deprecation warning:

    container_default_behavior: no_defaults

Update the playbook `infra.yaml` and add the `docker` role to the Grafana play role list, before the
`grafana` role. Run Ansible to apply the changes:

    ansible-playbook infra.yaml

If you have done everything correctly, Grafana container should be started now. You can check if the
container is running with this command:

    docker ps

Example output:

    CONTAINER ID  IMAGE            COMMAND    CREATED  STATUS         PORTS     NAMES
    4edd5904d11d  grafana/grafana  "/run.sh"  ...      Up 42 seconds  3000/tcp  grafana


'Up 42 seconds' here means that Grafana container is running. If it's not, you can probably find
your container in the failed state:

    docker ps -a

Example output (note the 'STATUS' column):

    CONTAINER ID  IMAGE            COMMAND    CREATED  STATUS                     PORTS  NAMES
    6596819763cb  grafana/grafana  "/run.sh"  ...      Exited (1) 42 seconds ago         grafana

If the container is not starting, or not working as expected you can check its logs with:

    docker logs grafana

Hint: it also supports the "follow" mode:

    docker logs -f grafana    # exit with Ctrl+C


## Task 3

Configure Grafana and provision datasources.

Previously we installed Grafana from the APT package, and it created needed files and directories
automatically. It does so in the container as well, but we cannot change these files there. Instead,
we can pre-create the needed files on Docker host, and mount them into container as _volume_.

For that, update `roles/grafana/tasks/main.yaml` to create the needed files and directories on
Docker hosts before the Grafana container is started.

Directories:

    /opt/grafana/provisioning/dashboards
    /opt/grafana/provisioning/datasources

Files:

    /opt/grafana/grafana.ini
    /opt/grafana/provisioning/dashboards/default.yaml
    /opt/grafana/provisioning/dashboards/main/json
    /opt/grafana/provisioning/dashboards/mysql/json
    /opt/grafana/provisioning/dashboards/syslog.json
    /opt/grafana/provisioning/datasources/default.yaml

Purpose of these directory and files should be familiar to you from the lab 7.

 - use your old tasks file `main_apt.yaml` as an example
 - create both directories in one task; use `loop` construct -- check out lab 11 for examples
 - use `recurse` property of the Ansible module `file` to easily create the full directory tree
   if one of the parent directories is missing

Example:

      name: "/opt/grafana/conf/provisioning/{{ item }}"
      recurse: yes
    loop:
      - ...
      - ...

Update the dashboard provisionging configuration file (`provisioning/dashboards/default.yaml`) and
change the provider path to `/etc/grafana/provisioning/dashboards`. Check Grafana provisioning
reference for details:
https://grafana.com/docs/grafana/latest/administration/provisioning/#dashboards

Note that in this lab we keep both dashboard provisioning configuration and the dashboards
themselves (JSON files) in the same directory. Grafana is not allowed to change these files in our
setup anyway, so there is no point to keep them in `/var/lib/grafana`.

Update the `grafana.ini` file to set the Grafana admin password if you haven't done it yet.
Check Grafana configuration reference for details:
https://grafana.com/docs/grafana/latest/administration/configuration/#admin_password

Update your `docker_container` task in the `grafana` role and mount the Grafana configuration
directory; add this parameter to the `docker_container` module:

    volumes: /opt/grafana:/etc/grafana

Run Ansible to apply the changes. Make sure that Grafana container is restarted and is still
running after your changes are applied:

    docker ps

Note the time in 'STATUS' column. if the contaimer was not restarted, trigger the restart by
modifying the `grafana.ini` file (add or remove empty line) and running Ansible again.


## Task 4

Configure public access to the Grafana.

So far Grafana is only accessible from inside the Docker container; we need to expose it by binding
the container port to the Docker host port, and configuring the Nginx proxy to forward requests to
this host port.

Grafan is configured to run behind proxy already -- you've done it in the lab 7, and reused the same
configuration file (`grafana.ini`) for the Docker container.

Next, update your `docker_container` to bind the container port Grafana is listening on (3000) to
port 3001 of the Docker host. Make this number a variable so you can change it later:

    published_ports: "{{ grafana_port }}:3000"

Also make sure to update the Nginx proxy configuration accordingly, for example:

    proxy_pass: http://localhost:{{ grafana_port }};

Run the Ansible to apply the changes. If you've done everything correctly, Grafana should be now
available on one of your public URLs, for example, http://193.40.156.86:11180/grafana (yours will be
different).

 - you should see the Grafana login form there
 - use password set in `grafana.ini` to log in
 - all datasources (Prometheus, 2 x InfluxDB) and dashboards (Main, MySQL, Syslog) should be there

If the dashboards or datasources are not there, re-check ifyou've done task 3 fully and correctly.

If you don't see Grafana login form, check that:
 1. You are accessing the correct URL
 2. You have configured the Nginx proxy correctly
 3. Grafana container is running, and needed port is published to the Docker host

You can check that Grafana container is running with this command:

    docker ps

Note the 'PORTS' column, and make sure that correct ports are published:

    0.0.0.0:3001->3000/tcp


## Task 5

Rename the existing Agama tasks file:

    roles/agama/tasks/main.yaml --> roles/agama/tasks/main_apt.yaml

If you have already installed Agama and/or uWSGI to one of your managed servers as described in
[lab 3](../03-web-app) -- stop and uninstall it; run these commands manually as root:

    service uwsgi stop
    apt purge python3-flask python3-pymysql uwsgi
    apt autoremove
    rm -rf /etc/uwsgi
    rm -rf /opt/agama
    userdel -r agama

Install the new Agama that runs in Docker container. For that, create the new `main.yaml` file in
`roles/agama/tasks`.

Create a directory `/opt/agama`. This time it shouldn't be owned by user `agama` as in lab 3;
in fact, we don't need a user `agama` at all on this host. Don't set the directory ownership in
Asnible -- it will be owned by root by default.

Agama does not have an image in the Docker Hub, so it needs to be built on the managed host.

Dockerfile can be found in the Agama repository:
https://github.com/hudolejev/agama/blob/master/Dockerfile -- click 'Raw' to get the direct download
URL. You will need to download it to the managed host -- use Ansible module
[get_url](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/get_url_module.html)
for that.

Save this file as `/opt/agama/Dockerfile`.

Build Docker image from this file using Ansible module
[docker_image](https://docs.ansible.com/ansible/latest/collections/community/docker/docker_image_module.html)

It has many arguments but don't get too excited with that. Something simple like this would work
just fine:

    name: agama
    source: build
    build:
      path: /opt/agama

 - build directory (path) should be `/opt/agama`
 - image name should be `agama`
 - building the image will take a few minutes...

Please **do not** push the image to Docker Hub.

Once done, use `docker_container` module to start the container from the built image, similarly as
you did for the Grafana. Make sure to use the same image name (`agama`) in `docker_image` and
`docker_container` modules so that Docker would use your local image instead of downloading it from
Docker Hub.

Note that you will need to provide additional environment variable to the container with MySQL
connection URL for Agama, similarly as you did for uWSGI in the [lab 4](../04-troubeshooting); add
this parameter to the `docker_container` module:

    env:
      AGAMA_DATABASE_URI: mysql+pymysql://<...>

You can reuse the conection string from the `uwsgi` role.

Bind the container port to port 8001 of the Docker host.

Update your Nginx configuration for Agama proxy accordingly. Note that  Agama from Docker is exposed
as _HTTP service_ (similar to Prometheus and Grafana), not uWSGI.

Once installed, new dockerized AGAMA should be accessible on the same URL as the old one before, via
Nginx proxy.


## Expected result

Your repository contains these files:

    infra.yaml
    roles/agama/tasks/main.yaml
    roles/docker/tasks/main.yaml
    roles/grafana/tasks/main.yaml

Your Agama application is accessible on its public URL.

Your Grafana is accessible on its public URL.

Agama and Grafana are both running in Docker containers; no local services named `grafana-server` or
`uwsgi` are running on any of your managed hosts.


# Lab 13

In this lab we will install Keepalived and HAProxy in front of our Docker containers.

## Task 1. Run Agama in Docker containers

Start at least 2 containers with Agama app on each VM. Reuse role from lab12.

## Task 2. Install Keepalived

Keepalived will assign to pair of your VMs additional virtual IP. That IP will be assigned to one VM at a time, that VM will be MASTER. Second VM will become BACKUP and in case MASTER is dead will promote itself to MASTER and assign that additional virtual IP to its own interface.

Some configuration should be done before. After you install `keepalived` with APT module there won't be any configuration template provided, but in order to start, Keepalived needs non-empty `/etc/keepalived/keepalived.conf`.

Here is an example of `keepalived.conf` with some comments:

    vrrp_script check_haproxy {                 
        script "path-to-check-script" 
        weight 20                              
        interval 1               
    }
    vrrp_instance XXX {             
        interface ens3
        virtual_router_id XXX
        priority XXX
        advert_int 1                            
        virtual_ipaddress {                     
            192.168.100.XX/24                   
        }
        unicast_peer {                          
            192.168.42.XX
        }
        track_script {
            check_haproxy
        }
    }

Some comments to config example:

`vrrp_script` will add some weight to node priority if it was executed sucessfully. Put check script to `keepalived_script` user home folder. Script that will success in case port 88 is open and return 1 in case nothing listens on that port:

    #!/bin/bash
    ss -ntl | grep -q ':88 '

`virtual_router_id` should be the same on different VMs.

`priority` should be different of different VMs. Use if-else-endif statements in Jinja2 template.

`virtual_ipaddress` should be the same on different VMs. if `your-name-1` VM has IP 192.168.42.35, virtual IP will be 192.168.100.35 (3rd octet changed from 42 to 100).

`unicast_peer` should contain IP of another VM. Multicast is default message format for VRRP, but it doesn't work in most of public clouds, you should specify IPs of your other VMs here that VRRP can start use unicast messages. Use Ansible facts to get IPs.

If all done correctly, command `ip a` on VM with higher priority will show that there are 2 IPs on ens3 interface. No changes on VM with lower priority.

Hints:

After `service keepalived stop` on MASTER, BACKUP should become a MASTER and `ip a` will show that `192.168.100.X` assigned to another VM.

If everything done correctly you should NOT see these logs on keepalived start:

    WARNING - default user 'keepalived_script' for script execution does not exist - please create.
    SECURITY VIOLATION - scripts are being executed but script_security not enabled.

That's one of the 2 roles, where IPs are allowed in configuration.

## Task 3. Install HAProxy

Can be installed with APT module as easy as Keepalived.

Clear installation will provide you config template in `/etc/haproxy/haproxy.cfg`.

Copy blocks `global` and `default` to your template.

Add section `listen` to template. Example of section:

    listen my_ha_frontend
        bind :88
        server docker1 web-server1:8081 check
        server docker2 web-server2:7785 check

Port should be `88` because our NAT is configured to forward all requests to `192.168.100.X:88`.

88 is not the default HTTP port, but in our labs ports 80 and 8080 already have some services running, so we decided to use 88 to avoid any binding conflicts.

Usage of IPs is not allowed here.

If all done correctly, `Public HA URLs` of vm1 should show you Agama app. Stopping HAProxy service on Keepalived MASTER should not affect Agama service reachability.

## Task 4. Add HAProxy monitoring

Install `prometheus-haproxy-exporter` using APT module. Add correct `haproxy.scrape-uri` to ARGS in `/etc/default/prometheus-haproxy-exporter`. Don't forget to expose HAProxy stats on that uri, find examples [here](https://www.haproxy.com/blog/the-four-essential-sections-of-an-haproxy-configuration/).

## Task 5. Add Keepalived monitoring

There are a few Keepalived exporters available, we propose to use this one: https://github.com/cafebazaar/keepalived-exporter. Sometimes we get banned by GitHub, so you can download the file from our local backup server: http://backup/keepalived-exporter-1.2.0.linux-amd64.tar.gz

Download a binary, create systemd unit. Same as for `pinger` few labs back. Exporter user should be root because keepalived runs as root.

## Task 6. Grafana dashboard

Add new metrics to your main Grafana dashboard. Should be panels for each node with those metrics:
  
  - haproxy_up (last value)
  - haproxy_server_up (last value for each backend)
  - keepalived_vrrp_state (last value)

Hint:

If you don't see these metrics in Grafana drop-down, make sure you have added HAProxy and Keepalived exporters to Prometheus configuration.

Don't forget to update your Grafana provisioning files after dashboard changes.

## Expected result

Your repository contains these files:

    infra.yaml
    roles/haproxy/tasks/main.yaml
    roles/keepalived/tasks/main.yaml


Your Agama application is accessible on its public HA URL.

Your Grafana and Prometheus are accessible on its public URLs, just public, not HA.


# Lab 14

In this lab we will install DNS slave to provide DNS high availability.

## Task 1. Change location of DNS zone file

In lab 5 you might be created zone files in `/etc/bind/` directory. This directory should be managed by root, Bind9 service doesn't have permissions to write there by default.

For files that should be changed by service there is a special directory: `/var/cache/`.

Make sure your zone database files are located inside `/var/cache/bind/`. Configuration files are still in `/etc/bind/`.

Why do we need to do that? We're going to stop managing database files with Ansible directly.

## Task 2. Generate DNS key

You need to generate DNS key that will be used to authenticate slave on master.

Keys are generated with command on DNS server or any other server where `tsig-keygen` exists. Example:

    tsig-keygen example.key

Key name in your case should be `transfer.key`.

Generated output should be added to `named.conf.options`.

Obviously, key secret is secret data, use Ansible Vault to store it in your repo.

For more detailed explanation check section `TSIG` in the docs: https://bind9.readthedocs.io/en/v9_16_23/advanced.html#tsig.

## Task 3. Create DNS slave

Install Bind9 on second VM.

Configuration file with global options will be the same for master and slave, file with zone configuration will be different. Check docs how to configure zone as slave: https://bind9.readthedocs.io/en/v9_16_23/configuration.html#an-authoritative-only-name-server.

On DNS master allow zone transfer only for those who have `transfer.key` set. Section `TSIG` in the docs.

On DNS slave configure to use `transfer.key` when sending requests to master.  Section `TSIG` in the docs.

After this step slave should be able to resolve all your internal FQDNs. Command for checking:

    dig name.domain @slave_ip

Hint #1: Bind9 master and slave should be configured in one role. Role should be applied to group `dns_servers`, which includes groups `dns_slaves` and `dns_masters`. When you want to apply some task only to slave, use conditions:

    when: "inventory_hostname in groups['dns_slaves']"

Hint #2: If you don't like hint #1, you can create host variable `dns_role` and execute tasks based on this value. For example:

    when: "dns_role == 'slave'"

## Task 4. Update /etc/resolv.conf

/etc/resolv.conf now should contain IPs of both DNS servers.

Good idea to include `search` option there as well. In that case you don't need to specify your full domain every time. Template example:

    search {{ your_domain }}     // will be added to short names
    nameserver {{ dns_master }}  // should be a loop over all masters
    nameserver {{ dns_slave }}   // should be a loop over all slaves

## Task 5. Rewrite Ansible bind role

Change the way how you create zone file and records.

Initial zone file since now should contain only minimum required set: SOA record, NS record for each DNS server and A record for each NS record.

All other records Bind9 will add there by itself. Problem that might happen with this approach: next Ansible run will overwrite the database file and delete all the records created by Bind9. Solution: database file should be uploaded by Ansible only if it's missing. If file already there, Ansible should not touch it. Check docs for template module how to achieve this: https://docs.ansible.com/ansible/latest/collections/ansible/builtin/template_module.html

In Bind9 configuration allow zone updates only for those who have `nsupdate.key` set. Generate it same way as `transfer.key` from task 2. Example configuration:

    zone example.com {
      type master;
      file ...;
      allow-update {
        key nsupdate.key;
      };
    }
  
All other records should be added with Ansible nsupdate module. Docs: https://docs.ansible.com/ansible/latest/collections/community/general/nsupdate_module.html

Use update.key and localhost as server. Run task only on one DNS master.

## Task 6. Create records for your services

A Records:
- backup

CNAME records:
- grafana           // Points to vm-name with Grafana
- influxdb          // Points to vm-name with InfluxDB
- lb1, lb2          // Points to vm-names with HAProxy
- mysql1, mysql2    // Points to vm-names with MySQL
- ns1, ns2          // Points to vm-names with Bind9
- prometheus        // Points to vm-name with Prometheus
- web1, web2        // Points to vm-names with Agama containers

Switch services configuration to CNAMES where applicable, examples: Grafana datasources, logging destination, Agama mysql host, Prometheus targets, etc...

## Task 7. Create PTR records for your VMs

Add new zone to your DNS servers: `42.168.192.in-addr.arpa`. It should have the same configuration as your main domain zone.

Reverse zone has the same mandatory fields: SOA, NS, A records for NS. PTR records look like this:

    <last-octet-of-vm1-IP>	IN	PTR	<vm1-name>.<your-domain>.
    <last-octet-of-vm2-IP>	IN	PTR	<vm2-name>.<your-domain>.

Docs: https://bind9.readthedocs.io/en/v9_16_23/reference.html#inverse-mapping-in-ipv4

Hint: Dot at the end of your FQDN is very important. Recheck lecture 5 if not sure why.

## Task 8. Grafana dashboard

Make sure that DNS slave metrics are gathered by Prometheus.

Add DNS slave graphs to your Grafana dashboard (same as for DNS master).

## Post task

Create a file `name.txt` in the root of your repo with this content:

    real name:github username:discord username

Example:

    Roman Kuchin:romankuchin:RomanK

*Wrong*:

    real name: Roman Kuchin
    github username: romankuchin

*Wrong as well*:

    real name: Roman Kuchin username: romankuchin

## Expected result

Your repository contains these files:

    infra.yaml
    roles/bind/tasks/main.yaml
    name.txt



Exam related information
------------------------

Exam task: [README.md](./README.md)


Access
------

Exam times are listed on the [main course page](../README.md).

You can choose any 2 times to take the exam in addition to week 16 exam attempt,
3 attempts in total.

To get access to the exam you need to:

1. Complete all the 14 lab tasks
2. Get your solution verified by Judge Dredd:
    http://193.40.156.86/students.html > your-name > Results should be all green

Once done, you will soon get a third virtual machine to prepare and test your
solution.


Rules
-----

Exam starts strictly at the announced time and lasts for exactly
**3 hours and 15 minutes** (195 minutes) -- not a minute longer.

Submissions are checked on first-come-first-served basis.

This is open-everything exam: you can use whatever materials you want while
writing the code, testing it or presenting.


Pre-testing
-----------

Before taking the exam you should verify your solution yourself.

Run script `pre-exam.sh` when you have *empty VMs*. It will create a file `pre_exam.txt` -- commit it to `main` branch. Just a reminder: commiting your passwords is a bad idea. If playbook execution failed -- fix your code, recreate VMs and try again.

Expected result:

- Many changes on 1st run
- Zero changes on 2nd run
- Zero changes on 3rd run

If you have something different -- fix your code. No point to take the exam until you have achieved the
expected result. Note that we will still check your code during the exam.

To run the script, put it next to `infra.yaml`, make it executable and type `./pre-exam.sh`.


Testing
-------

This is what we (teachers) may do to test your infrastructure.


**1. Kill any of the services mentioned above**

You should be able to restore the infrastructure in exactly one Ansible run.

Note: to _restore_ the services with Ansible here and in other cases you may --
but don't have to -- use Ansible tags.


**2. Kill one of the highly available service instances**

Agama in Docker container, Bind (master or slave), Docker daemon, HAProxy,
Keepalived, MySQL replica.

The application should remain accessible for the clients, i. e. public URL of
Agama should remain working as nothing happened.

Your monitoring (Grafana) should be able to detect which component is down.

You should be able to restore the infrastructure in exactly one Ansible run.


**3. Kill one of the services and break its configuration file**

We will only break the files that are (or expected to be) managed with Ansible.

You should be able to restore the infrastructure in exactly one Ansible run.


**4 Break one of your services and ask you to find the problem**

We may tell you which service is broken, or you may need to identify that
yourself -- your monitoring (Grafana) will be helpful here.

We will only produce the damage that can be easily detected with commands
explained on the "Troubleshooting" lecture and lab, by checking
 - service status
 - service configuration syntax
 - service logs
 - ability to communicate with other services

For example, we may:
 - Make a typo in the HAProxy configuration
 - Change Bind configuration so that name resolution does not work
 - Change MySQL user, password, port
 - Stop Prometheus
 - etc.

You should be able to find the problem and explain what is broken and, ideally,
how to fix it.


**5. Reboot any of your VMs**

After the machine is started all your services there should be started
automatically **without any Ansible runs**, and of course without any manual
intervention.


**6. Ask you to change some configuration value**

Username, password, port, file permissions etc. for any of the service mentioned
above.

This change should be then fully applied in a single Ansible run.

> We will not ask you to make changes that silently break your infrastructure.
> If we do ask a breaking change -- we'll make it openly.


**7. Stop one of your services and restore it from the backup**

We will only use the instructions from your `backup_restore.md` document.

Note that _we_ will restore the service, not you.


**8. Ask you questions about your infrastructure**

A few examples:

 - How to check if the service X is working (multiple ways)?
 - What files does service X work with? Where are configuration files, where is
   working directory etc.
 - What other services does service X communicate to?
 - What services will be affected and how if machine A is turned off?
 - How do you back up your infrastructure (coverage, retention, versioning,
   usability, RPO/RTO etc.)?
 - When was the last backup for service X created?

And other questions of similar complexity and detail level: we won't ask you to
disassemble the binary files -- but you should have a basic understanding of how
the deployed services work.

Expected answer is usually a few, most often one-two, sentences.


**9. Ask you questions about your code**

Be ready to explain every line of your code.

You don't need to learn the documentation by heart precisely. You can always
check it any time -- it's an open-everything exam. We well accept cited online
references as answers -- if they answer the question, of course :)


This is the exam task for IT Instastructure Services 2021 course.

More exam related information (access, setup, rules, testing process) can be
found [here](./meta.md).


Intro
-----

Our application is ready to be released!

Today is the release day, link to Agama app was published in the Internet and
you start to serve your first happy customers. You monitor all your
insfastructure components and ready to react on any problems.

Of course everything that could go wrong -- goes wrong! Suddenly one of your DNS
instances just died without any reason. While you were checking the logs one
HAProxy crashed! And Docker containers with Agama app just start to disappear!

Luckily, you did a great job in the last few months to build fault-tolerant
infrastructure and happy customers didn't notice any problems with Agama app
during that time. Great job, you got many benefits and congratulations. But the
most important thing: now you can tell everyone that you sucessfully finished
"IT Infrastructure services" course in TalTech.

Sounds great?

There is one last step though -- put all the bits and pieces together to build
this infrastructure one last time.


Infrastructure
--------------

You will have 3 virtual machines to use: 1 for internal services and 2 for the
main application stack.

Each application stack machine should have these services set up and running:
 - HAProxy
 - Keepalived
 - Agama in the Docker container
 - MySQL (master on one machine, replica on the another)
 - Bind slave
 - Prometheus exporters for HAProxy, Keepalived, MySQL and Bind slave

Remaining machine should have these services set up and running:
 - Bind master
 - InfluxDB
 - Telegraf
 - Prometheus
 - Grafana
 - Nginx as frontend for Grafana and Prometheus


Differences with previous tasks
-------------------------------

We tried to make this infrastructure as similar as possible to what you did
during the course, however there are a few differences worth pointing out.

There is one Bind master and _two_ Bind slaves now; you don't need to add master
address to `/etc/resolv.conf` -- only both slave addresses. For example, in this
setup:

	192.168.42.35   # Bind slave
	192.168.42.87   # Bind slave
	192.168.42.124  # Bind master

`/etc/resolv.conf` could look like this:

	nameserver 192.168.42.35
	nameserver 192.168.42.87
	search mydomain.tld

Also, as there are three machines now, so your Grafana dashboards, backup
scripts and documentation should reflect and support it.


Task
----

Update your Ansible playbook named `infra.yaml` to deploy the infrastructure
described above.

Infrastructure should be fully set up and online by running exactly this
command:

	ansible-playbook infra.yaml

Provide the backup SLA document (`backup_sla.md`)
and backup restore instructions for every service that is being backed up
(`backup_restore.md`).

Requirements
------------

1. After the infrastructure is deployed, running `ansible-playbook infra.yaml`
   command again should not produce any changes on the managed hosts
2. Every variable should be defined exactly once -- in `hosts`,
   `group_vars/all.yaml` or some other file if you feel needed
3. No active plain text passwords should be found anywhere in your repository
   (including history); note that it's okay to have old passwords in the code
   -- but only if you changed them already
4. No IP addresses should be used in configurations, except Bind and Keepalived
   configuration and `/etc/resolv.conf`. Should you address local machine, use
   `localhost` -- not `127.0.0.1`!


Presenting your solution
------------------------

If you have run the Ansible command mentioned above, and it did not trigger any
changes, you are ready to present your solution.

[Here](./meta.md#Testing) you can find more details on how we will test your
submission.

**But make sure to test it yourself first!**


Good luck!
----------

![](./unicorn.jpeg)


