#!/bin/sh

#Resore KB from current backup, set read only then launch neo4j service
cd /opt/VFB/backup/ && \
curl --retry 3 --retry-delay 5 -O http://data.virtualflybrain.org/archive/VFB-KB.tar.gz  && \
tar -xzvf /opt/VFB/backup/VFB-KB.tar.gz && \
chmod -R 777 /opt/VFB && \
/var/lib/neo4j/bin/neo4j-admin restore --from=/opt/VFB/backup/VFB-KB.db --force=true && \
cd /var/lib/neo4j && \
rm -rf /opt/VFB/backup/* && \
sed -i s/read_only=false/read_only=${NEOREADONLY}/ ${NEOSERCONF} && \
exec /docker-entrypoint.sh neo4j
