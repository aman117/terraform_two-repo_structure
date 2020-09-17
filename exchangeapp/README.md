# Exchange App's Setup

## Sample Three Tier App

This repo contains code for a Node.js multi-tier application.

The application overview is as follows

```
web <=> api <=> db
```

The folders `web` and `api` describe how to install and run each app.

## To Do List

***FYI***
Update:
> IT IS JUST TESTED AND WORKS.

I created `Dockerfile` and `.dockerignore` file for both app.

And then I just automated to push their images to `AWS ECR` by using `Makefile`.

Also I wrote down the YAML files for the deployments, services, secret, and namespace.

I prepared a imperative command to get `the secret in AWS Secrets Manager` and injected the secrets to the secret's YAML file for creating a secret in Kubernetes, **as a _best practice_**.

~~Additionally, I did add the `docker-registry` for pulling images in Private Registry which is AWS ECR, in this case.~~

~~I searched about how to connect EKS to RDS DB, and found that ExternalName feature of the Kubernetes. It provides you to create a CNAME as a service in your cluster for the pods. It really helps me.~~

I added to Makefile the commands all you need to have.

## The Problems I Faced

There was a bug in connection between RDS and EKS and realized that the Security Groups of RDS wasn't allowed to 5432 port. I just opened it, but it didn't work again. After lots of researching I realized that the bug about my DB Name in RDS DB instance. I was struggling to communicate with the DB Name which wasn't created in RDS DB instance, and just changed the DB Name to default name which is called `postgres`, then it just worked.

The other problem was about using shell commands in Makefile. I was using like `$(echo something)`, but it wasn't working. Then I researched on it, and figure out the problem. In Makefile, if you want to use shell commands, you have to add `shell` front of the command you want to run like `$(shell echo something)`.

In Makefile, I was trying to replace the content of YAML files by using `sed command` then I got an error. I used to use `/` as the sed command's delimiter, but it was conflicted with repository name. I just changed the sed delimiters with `|`, and it worked.
