#!/bin/sh

# ENVIRONMENT: possible values dev, test, prod
# export PROJECT_ENVIRONMENT=dev

# PROJECT
export PROJECT_HOME=/home/dsteiner/Dropbox/projects/packtKettleVideoTutorial/git/SecondhandLensStore/SecondhandLensStore

# PENTAHO
# export PENTAHO_JAVA_HOME=/usr/lib/jvm/java-6-sun/jre
# export KETTLE_JNDI_ROOT=$PROJECT_HOME/config/$PROJECT_ENVIRONMENT/simple-jndi
# export KETTLE_HOME=$PROJECT_HOME/config/$PROJECT_ENVIRONMENT
export KETTLE_HOME=$PROJECT_HOME/config-pdi
export KETTLE_JNDI_ROOT=$PROJECT_HOME/config-pdi/simple-jndi

# SQLWORKBENCH
#export SQLWORKBENCH_CONFIG_DIR=$PROJECT_HOME/config/$PROJECT_ENVIRONMENT/sqlworkbench
#export JDBC_DRIVER_DIR=$PROJECT_HOME/config/$PROJECT_ENVIRONMENT
