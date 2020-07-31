# discord-loggerbot
A ready to run docker-compose application that logs discord chat into elasticsearch and surfaces a website to search them.

**Note:** This repository was built before Discord offered their own (very powerful) search functionality. You likely don't need this, but feel free to fork/reference in case you're building something similar.

## Setup
### You'll need:
  1. **A server to run this on.** It can be virtual, I use [VirtualBox](https://www.virtualbox.org/wiki/VirtualBox) for mine. Whichever platform you choose, make sure it can run [Docker](https://www.docker.com/) and that it's got at least 256MB of free memory. This may even work using Docker for windows, although I haven't tested it.
  2. **A working Docker installation.** Here's the documentation for Ubuntu: https://docs.docker.com/engine/installation/linux/ubuntulinux/
  3. **A discord application.** See documentation here: https://discordapp.com/developers/docs/intro
  
### Then do this:
  1. Download or checkout this code
  2. Run `cd discord-loggerbot` and `docker build -t loggerbot .`
  3. Run `docker-compose run --rm loggerbot bash` and from within the container run `./loggerbot.rb` -- This will ask for your applicationId and token since it's the first time you've run the application.
  4. If you see any errors, press ctrl+c to stop the application and delete the .token file that was just created (with `rm .token`). Once you've fixed the problem you can try again.
  5. If you see `[INFO : gateway @ 2016-12-30 16:57:47.558] Discord using gateway protocol version: 4, requested: 4` then your application has successfully started!
  6. Type `exit` to get out of the container
  7. When you're ready to start the application for good, run `docker-compose up -d` which will run **all** services in the background.
  8. You can ensure everything is running smoothly by typing `docker-compose ps` and verifying each container's state is Up
  9. You can verify the website is accessible by visiting port 5600 (although it will throw errors until it's logged at least one message)
