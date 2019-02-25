#!/usr/bin/env ash

export SERVER=$(hostname -f)
export CN=$SERVER

if [[ ! -f "$TASKDDATA/server.key.pem" ]]; then
  taskd init

  cp -r /usr/share/taskd/pki/ $TASKDDATA/pki
  cd $TASKDDATA/pki

  cat << EOF > $TASKDDATA/pki/vars
BITS=$BITS
EXPIRATION_DAYS=$EXPIRATION_DAYS
ORGANIZATION="$ORGANIZATION"
CN=$SERVER
COUNTRY=$COUNTRY
STATE="$STATE"
LOCALITY="$LOCALITY"
EOF

  ./generate > /dev/null 2>&1

  cp client.cert.pem $TASKDDATA
  cp client.key.pem  $TASKDDATA
  cp server.cert.pem $TASKDDATA
  cp server.key.pem  $TASKDDATA
  cp server.crl.pem  $TASKDDATA
  cp ca.cert.pem     $TASKDDATA

  taskd config --force client.cert $TASKDDATA/client.cert.pem
  taskd config --force client.key  $TASKDDATA/client.key.pem
  taskd config --force server.cert $TASKDDATA/server.cert.pem
  taskd config --force server.key  $TASKDDATA/server.key.pem
  taskd config --force server.crl  $TASKDDATA/server.crl.pem
  taskd config --force ca.cert     $TASKDDATA/ca.cert.pem

  taskd config --force log $TASKDDATA/taskd.log
  taskd config --force pid.file $TASKDDATA/taskd.pid
  taskd config --force server $SERVER:60000

  mkdir $TASKDDATA/certs
fi

echo 'Start taskd!'
taskd server --data $TASKDDATA
