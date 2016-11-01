# jupyter-pyspark-plus-oracle-and-postgres

[Jupyter|http://jupyter.org] (formerly known as [iPython|http://ipython.org] Notebooks) is a wonderful tool to work with and analyze data using Python, providing the means to report and visualize by means of a nice web interface.

I started learning my way through using this by developing some business reporting, and in order for thatto be worthwhile, I wanted to connect directly to live data. I have a few data stores I need to interact with, but most of what I needed was in Postgres and Oracle databases.

It's a _slight_ hassle to get it all set up, so I thought I'd take advantage of [Docker|https://docker.com]. The starting point comes right from the Jupyter's [docker-stacks|https://github.com/jupyter/docker-stacks] and does not modify any of their conventions. This Dockerfile is as simple as I could think to make it, but it does require that you have - in the same directory as this Dockerfile - the "basic" and "SDK" Oracle Instant Client (for 64-bit Linux), which you can only get from Oracle by means of a free developer account (try [here|http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html]). At time of writing this README, the files I have are:

* instantclient-basic-linux.x64-12.1.0.2.0.zip
* instantclient-sdk-linux.x64-12.1.0.2.0.zip

With those in place, I merely build like...

```docker
docker build -t papakpmartin/jupyter .
```

## Using this

I strongly recommend configuring a [Docker Volume|https://docs.docker.com/engine/tutorials/dockervolumes/] so that you can persist your work outside of the Docker container. Something like this is what I do...

```docker
docker run -p 8888:8888 -v /SOME/LOCAL/DIRECTORY/jupyter/work:/home/jovyan/work papakpmartin/jupyter
```

It's really kind of magical to be able to spin this up and be running in seconds and see all of your work there, ready to go.

Note: I do have this up in Docker Hub at [papakpmartin/jupyter-pyspark-plus-oracle-and-postgres|https://hub.docker.com/r/papakpmartin/jupyter-pyspark-plus-oracle-and-postgres/] but it won't build there because of the Oracle dependencies, so I'm not yet sure that's a good place to get this. (I'm pretty new to Docker right now.)
