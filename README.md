# centos7-dev-ssh
This repo is for dockerfile of dev env based on centos7

# How to build
```
docker build -t centos7-dev:1.0 .
```

# How to run
```
docker run -d --name ssh.1 -P centos7-dev:1.0
```
or
```
docker run -d --name ssh.1 -p 2020:22 centos7-dev:1.0
```
