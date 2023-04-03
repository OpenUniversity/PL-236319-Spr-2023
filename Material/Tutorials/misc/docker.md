
# Docker
![docker](../../imgs/docker.png)  <!-- .element height="30%" width="30%" -->

---

## important notes

Docker is not included in this course materials, i.e. you wont be asked about it in homework or final exam.

However, you are expected to use it in order to check you homework before submitting.

---

## what is docker?

Docker is a platform for running *containerized* applications.

It provides a standard way to package an application and its dependencies into a container which can be easily run on any compatible host.

<!--vert-->

### use cases

Docker is widely used for testing, devops automation, deploying scalable web servers and many more uses.

In general it is used whenever a custom running environment is required.

---

## how does docker works

When we work with docker, there are three main components we consider: `Dockerfile`, `Docker Image` and `Docker Container`.

<!--vert-->

### Dockerfile

This is a text file which is the "recipe" of how to create the virtual environment.

For example it may look like this:
```docker
# syntax=docker/dockerfile:1
FROM ubuntu:18.04
COPY . /app
RUN make /app
CMD python /app/app.py
```

<!--vert-->

### docker image

This is the basis of our environments. The Docker Image is created once out of the docker file and then can be used to create as many containers as needed.

<!--vert-->

### docker container

This is our virtual environment. It contains everything included in the image, and is isolated from our host environment.



---

## why do we use docker in this course

Throughout the semester you will be required to use various tools in your homework assignments such as FreePascal compiler, ML interpreter and so on...

<!--vert-->


### why do we use docker in this course

These dependencies are not installed on our department's server.
Therefor we wanted to supply you with an environment where you can find and use all the tools you need for this course.

<!--vert-->

### why do we use docker in this course

In the docker image we supply, you can find any tool needed to run you homework assignments.

Furthermore, these are the same images your assignments will be tested with.

---



## how to use docker

First of all, you need to install docker. for installation please refer to [this guide](https://docs.google.com/document/d/1JsjRnOC4oHi4SPF6R9xOravEu7tHIAw_mMqFgjRo_4E/edit) (can be found in our website)

<!--vert-->

### how to use docker

We already created docker images for you to use throughout this course. you will only need to run containers using these images and run your tests.

<!--vert-->

### running docker

In every homework assignment we tell you which docker image to use for that assignment.

For example, in order to test the first assignment you were supplied with an image called **twyair/safot-hw:1**

<!--vert-->


### running docker

When you try to run a container based on a certain image for the first time, it will be download the image from the docker registry.

That way, you don't need to manage your images and docker will do it for you!

<!--vert-->


### running docker

In order to run a new container, you can use the following command:

> `docker run --rm -it -v` <!-- .element style="font-size: 0.6em" -->
**\<host_path\>:\<containter_path\> \<image_name\>**   <!-- .element style="font-size: 0.6em" -->

for example:

```shell
docker run -it --rm -v $(pwd):/source twyair/safot-hw:1
```

<!--vert-->

### Running docker
> `docker run --rm -it -v` <!-- .element style="font-size: 0.6em" -->
**\<host_path\>:\<containter_path\> \<image_name\>**   <!-- .element style="font-size: 0.6em" -->

* `--rm` deletes the container after it exits.
* `-it` opens the container in *interactive mode*. this will allow you to use the container's shell and run your commands inside.

<!--vert-->

### Running docker
> `docker run --rm -it -v` <!-- .element style="font-size: 0.6em" -->
**\<host_path\>:\<containter_path\> \<image_name\>**   <!-- .element style="font-size: 0.6em" -->

* `-v` will mount a folder from the host file system so you can use it inside the container. In the example showed earlier the current working directory will be mounted to "source" directory inside the container.
* `image_name` is the image the new container will be created from.
