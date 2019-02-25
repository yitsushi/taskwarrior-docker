# TaskWarrior docker image

Environment variables:

```
ENV TASKDDATA=/data

ENV BITS=4096
ENV EXPIRATION_DAYS=365
ENV ORGANIZATION="Göteborg Bit Factory"
ENV COUNTRY=SE
ENV STATE="Västra Götaland"
ENV LOCALITY="Göteborg"
```

Start server:

```
$ docker run \
    -v ~/taskd-data:/data \
    -h myserver.box \
    -p 60000:60000 \
    --name taskd \
    yitsushi/taskwarrior
...
Start taskd!
```

Create org and user

```
$ docker exec taskd taskd-create-org myorg
Created organization 'code-infection'

$ docker exec taskd taskd-create-user myorg myuser
creating myorg/myuser
New user key: 11111111-1111-1111-1111-111111111111
Created user 'myuser' for organization 'myorg'
/data/certs/myuser.tar.gz created
```
