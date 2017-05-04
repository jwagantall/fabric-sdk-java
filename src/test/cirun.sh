#!/usr/bin/env bash
#Script for continuous integration run.  Cleanup, start docker containers for fabric and fabric ca
#Start integration tests.
# expect WD env set HLJSDK directory.

# unset ORG_HYPERLEDGER_FABRIC_SDKTEST_INTEGRATIONTESTS_TLS
# unset ORG_HYPERLEDGER_FABRIC_SDKTEST_INTEGRATIONTESTS_CA_TLS
export ORG_HYPERLEDGER_FABRIC_SDKTEST_INTEGRATIONTESTS_TLS=true
export ORG_HYPERLEDGER_FABRIC_SDKTEST_INTEGRATIONTESTS_CA_TLS=--tls.enabled

cd $WD/src/test/fixture/sdkintegration
rm -rf /tmp/keyValStore*; rm -rf  /tmp/kvs-hfc-e2e ~/test.properties; rm -rf /var/hyperledger/*
docker-compose up >dockerlogfile.log 2>&1 &
cd $WD
sleep 30
docker ps -a

# -P release < will tell consider release goal > 
mvn clean install deploy -P release -s settings.xml -DskipITs=true -Dmaven.test.failure.ignore=true


