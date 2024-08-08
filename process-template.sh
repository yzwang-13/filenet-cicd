#!/bin/sh
OS_NUMBER=2
DB2_HOST=mssql.mssql.svc.cluster.local
FILE_STORAGE_CLASSNAME=azurefile-csi
BLOCK_STORAGE_CLASSNAME=managed-csi
LDAP_HOST=openldap.cp4ba-openldap.svc.cluster.local
mkdir -p manifests
oc process -f ./23.0.2/base-template.yaml \
-p FILE_STORAGE_CLASSNAME=$FILE_STORAGE_CLASSNAME \
-p BLOCK_STORAGE_CLASSNAME=$BLOCK_STORAGE_CLASSNAME \
-p DB2_HOST=$DB2_HOST \
-p LDAP_HOST=$LDAP_HOST \
-o yaml  --local=true --raw=true > manifests/cp4ba-base.yaml
for((i=1;i<=$OS_NUMBER;++i)) do
    oc process -f ./23.0.2/objectstore-template.yaml \
    -p OS_NUMBER=$i \
    -p DB2_HOST=$DB2_HOST\
    -o yaml  --local=true --raw=true > manifests/cp4ba-os-$i.yaml
done
