# Jenkins TLS with aditionals tools 

The present dockerfile adding to jenkinsci:tls two additionals tools:

- Maven
- AWS CLI
- AWS ElasticBeanstalk

## Pre requisites

- docker
- docker-compose

**Note: If you need others version of jenkins, please change the Dockerfile or add more version if you wish**


## Command to build locally image

```bash
docker build -t jenkins-custom:v1 .
```

## Commando to run locally container in port 8080, change if you wish.

```bash
mkdir jenkins-data
docker run -u root --name jenkins --rm -d -p 8080:8080 -p 50000:50000 -v jenkins-data:/var/jenkins_home --name jenkins-custom:v1
```

## Access to the Web Console (Omit this step if you have jenkins up and runnings previuly)

1. Password

Firstly, you must to get the default password and put in the box requered into the jenkings web console.

```
docker run exec -it jenkins-custom:v1 cat /var/jenkins_home/secrets/initialAdminPassword
```

2. Configure Jenkins Server 

  2.1. Open Web Browser and Put the password saved in the previus step.
  2.2. Install Plugins
  2.3. Configure admin user and password.


3. Check the plugins are present

* Maven

```
docker run exec -it jenkins-custom:v1 mvn -version 
```

* AWS CLI

```
docker run exec -it jenkins-custom:v1 aws --version
```

## docker-compose

If you wish to run Jenkins with docker-compose please execute the follow command.

```
docker-compose up -d
```

## Autor

Gonzalo Acosta <gonzaloacostapeiro@gmail.com>

