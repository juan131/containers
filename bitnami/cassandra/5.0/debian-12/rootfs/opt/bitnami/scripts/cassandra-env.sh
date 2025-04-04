#!/bin/bash
# Copyright Broadcom, Inc. All Rights Reserved.
# SPDX-License-Identifier: APACHE-2.0
#
# Environment configuration for cassandra

# The values for all environment variables will be set in the below order of precedence
# 1. Custom environment variables defined below after Bitnami defaults
# 2. Constants defined in this file (environment variables with no default), i.e. BITNAMI_ROOT_DIR
# 3. Environment variables overridden via external files using *_FILE variables (see below)
# 4. Environment variables set externally (i.e. current Bash context/Dockerfile/userdata)

# Load logging library
# shellcheck disable=SC1090,SC1091
. /opt/bitnami/scripts/liblog.sh

export BITNAMI_ROOT_DIR="/opt/bitnami"
export BITNAMI_VOLUME_DIR="/bitnami"

# Logging configuration
export MODULE="${MODULE:-cassandra}"
export BITNAMI_DEBUG="${BITNAMI_DEBUG:-false}"

# By setting an environment variable matching *_FILE to a file path, the prefixed environment
# variable will be overridden with the value specified in that file
cassandra_env_vars=(
    CASSANDRA_CLIENT_ENCRYPTION
    CASSANDRA_CLUSTER_NAME
    CASSANDRA_DATACENTER
    CASSANDRA_ENABLE_REMOTE_CONNECTIONS
    CASSANDRA_ENABLE_RPC
    CASSANDRA_ENABLE_USER_DEFINED_FUNCTIONS
    CASSANDRA_ENABLE_SCRIPTED_USER_DEFINED_FUNCTIONS
    CASSANDRA_ENDPOINT_SNITCH
    CASSANDRA_HOST
    CASSANDRA_INTERNODE_ENCRYPTION
    CASSANDRA_NUM_TOKENS
    CASSANDRA_PASSWORD_SEEDER
    CASSANDRA_SEEDS
    CASSANDRA_PEERS
    CASSANDRA_NODES
    CASSANDRA_RACK
    CASSANDRA_BROADCAST_ADDRESS
    CASSANDRA_AUTOMATIC_SSTABLE_UPGRADE
    CASSANDRA_STARTUP_CQL
    CASSANDRA_IGNORE_INITDB_SCRIPTS
    CASSANDRA_CQL_PORT_NUMBER
    CASSANDRA_JMX_PORT_NUMBER
    CASSANDRA_TRANSPORT_PORT_NUMBER
    CASSANDRA_CQL_MAX_RETRIES
    CASSANDRA_CQL_SLEEP_TIME
    CASSANDRA_INIT_MAX_RETRIES
    CASSANDRA_INIT_SLEEP_TIME
    CASSANDRA_PEER_CQL_MAX_RETRIES
    CASSANDRA_PEER_CQL_SLEEP_TIME
    CASSANDRA_DELAY_START_TIME
    CASSANDRA_AUTO_SNAPSHOT_TTL
    ALLOW_EMPTY_PASSWORD
    CASSANDRA_AUTHORIZER
    CASSANDRA_AUTHENTICATOR
    CASSANDRA_USER
    CASSANDRA_PASSWORD
    CASSANDRA_KEYSTORE_PASSWORD
    CASSANDRA_TRUSTSTORE_PASSWORD
    CASSANDRA_KEYSTORE_LOCATION
    CASSANDRA_TRUSTSTORE_LOCATION
    CASSANDRA_TMP_P12_FILE
    CASSANDRA_SSL_CERT_FILE
    CASSANDRA_SSL_KEY_FILE
    CASSANDRA_SSL_CA_FILE
    CASSANDRA_SSL_VALIDATE
    SSL_VERSION
    CASSANDRA_MOUNTED_CONF_DIR
    JAVA_TOOL_OPTIONS
)
for env_var in "${cassandra_env_vars[@]}"; do
    file_env_var="${env_var}_FILE"
    if [[ -n "${!file_env_var:-}" ]]; then
        if [[ -r "${!file_env_var:-}" ]]; then
            export "${env_var}=$(< "${!file_env_var}")"
            unset "${file_env_var}"
        else
            warn "Skipping export of '${env_var}'. '${!file_env_var:-}' is not readable."
        fi
    fi
done
unset cassandra_env_vars
export DB_FLAVOR="cassandra"

# Paths
export CASSANDRA_BASE_DIR="/opt/bitnami/cassandra"
export DB_BASE_DIR="$CASSANDRA_BASE_DIR"
export CASSANDRA_BIN_DIR="${DB_BASE_DIR}/bin"
export DB_BIN_DIR="$CASSANDRA_BIN_DIR"
export CASSANDRA_VOLUME_DIR="/bitnami/cassandra"
export DB_VOLUME_DIR="$CASSANDRA_VOLUME_DIR"
export CASSANDRA_DATA_DIR="${DB_VOLUME_DIR}/data"
export DB_DATA_DIR="$CASSANDRA_DATA_DIR"
export CASSANDRA_COMMITLOG_DIR="${DB_DATA_DIR}/commitlog"
export DB_COMMITLOG_DIR="$CASSANDRA_COMMITLOG_DIR"
export CASSANDRA_INITSCRIPTS_DIR="/docker-entrypoint-initdb.d"
export DB_INITSCRIPTS_DIR="$CASSANDRA_INITSCRIPTS_DIR"
export CASSANDRA_LOG_DIR="${DB_BASE_DIR}/logs"
export DB_LOG_DIR="$CASSANDRA_LOG_DIR"
export CASSANDRA_TMP_DIR="${DB_BASE_DIR}/tmp"
export DB_TMP_DIR="$CASSANDRA_TMP_DIR"
export JAVA_BASE_DIR="${BITNAMI_ROOT_DIR}/java"
export JAVA_BIN_DIR="${JAVA_BASE_DIR}/bin"
export PYTHON_BASE_DIR="${BITNAMI_ROOT_DIR}/python"
export PYTHON_BIN_DIR="${PYTHON_BASE_DIR}/bin"
export CASSANDRA_LOG_FILE="${DB_LOG_DIR}/cassandra.log"
export DB_LOG_FILE="$CASSANDRA_LOG_FILE"
export CASSANDRA_FIRST_BOOT_LOG_FILE="${DB_LOG_DIR}/cassandra_first_boot.log"
export DB_FIRST_BOOT_LOG_FILE="$CASSANDRA_FIRST_BOOT_LOG_FILE"
export CASSANDRA_INITSCRIPTS_BOOT_LOG_FILE="${DB_LOG_DIR}/cassandra_init_scripts_boot.log"
export DB_INITSCRIPTS_BOOT_LOG_FILE="$CASSANDRA_INITSCRIPTS_BOOT_LOG_FILE"
export CASSANDRA_PID_FILE="${DB_TMP_DIR}/cassandra.pid"
export DB_PID_FILE="$CASSANDRA_PID_FILE"
export PATH="${DB_BIN_DIR}:${BITNAMI_ROOT_DIR}/common/bin:${BITNAMI_ROOT_DIR}/python/bin:${BITNAMI_ROOT_DIR}/java/bin:$PATH"

# System users (when running with a privileged user)
export CASSANDRA_DAEMON_USER="cassandra"
export DB_DAEMON_USER="$CASSANDRA_DAEMON_USER"
export CASSANDRA_DAEMON_GROUP="cassandra"
export DB_DAEMON_GROUP="$CASSANDRA_DAEMON_GROUP"

# Cassandra cluster settings
export CASSANDRA_CLIENT_ENCRYPTION="${CASSANDRA_CLIENT_ENCRYPTION:-false}"
export DB_CLIENT_ENCRYPTION="$CASSANDRA_CLIENT_ENCRYPTION"
export CASSANDRA_CLUSTER_NAME="${CASSANDRA_CLUSTER_NAME:-My Cluster}"
export DB_CLUSTER_NAME="$CASSANDRA_CLUSTER_NAME"
export CASSANDRA_DATACENTER="${CASSANDRA_DATACENTER:-dc1}"
export DB_DATACENTER="$CASSANDRA_DATACENTER"
export CASSANDRA_ENABLE_REMOTE_CONNECTIONS="${CASSANDRA_ENABLE_REMOTE_CONNECTIONS:-true}"
export DB_ENABLE_REMOTE_CONNECTIONS="$CASSANDRA_ENABLE_REMOTE_CONNECTIONS"
export CASSANDRA_ENABLE_RPC="${CASSANDRA_ENABLE_RPC:-false}"
export DB_ENABLE_RPC="$CASSANDRA_ENABLE_RPC"
export CASSANDRA_ENABLE_USER_DEFINED_FUNCTIONS="${CASSANDRA_ENABLE_USER_DEFINED_FUNCTIONS:-false}"
export DB_ENABLE_USER_DEFINED_FUNCTIONS="$CASSANDRA_ENABLE_USER_DEFINED_FUNCTIONS"
export CASSANDRA_ENABLE_SCRIPTED_USER_DEFINED_FUNCTIONS="${CASSANDRA_ENABLE_SCRIPTED_USER_DEFINED_FUNCTIONS:-false}"
export DB_ENABLE_SCRIPTED_USER_DEFINED_FUNCTIONS="$CASSANDRA_ENABLE_SCRIPTED_USER_DEFINED_FUNCTIONS"
export CASSANDRA_ENDPOINT_SNITCH="${CASSANDRA_ENDPOINT_SNITCH:-SimpleSnitch}"
export DB_ENDPOINT_SNITCH="$CASSANDRA_ENDPOINT_SNITCH"
export CASSANDRA_HOST="${CASSANDRA_HOST:-}"
export DB_HOST="$CASSANDRA_HOST"
export CASSANDRA_INTERNODE_ENCRYPTION="${CASSANDRA_INTERNODE_ENCRYPTION:-none}"
export DB_INTERNODE_ENCRYPTION="$CASSANDRA_INTERNODE_ENCRYPTION"
export CASSANDRA_NUM_TOKENS="${CASSANDRA_NUM_TOKENS:-256}"
export DB_NUM_TOKENS="$CASSANDRA_NUM_TOKENS"
export CASSANDRA_PASSWORD_SEEDER="${CASSANDRA_PASSWORD_SEEDER:-no}"
export DB_PASSWORD_SEEDER="$CASSANDRA_PASSWORD_SEEDER"
export CASSANDRA_SEEDS="${CASSANDRA_SEEDS:-$DB_HOST}"
export DB_SEEDS="$CASSANDRA_SEEDS"
export CASSANDRA_PEERS="${CASSANDRA_PEERS:-$DB_SEEDS}"
export DB_PEERS="$CASSANDRA_PEERS"
export CASSANDRA_NODES="${CASSANDRA_NODES:-}"
export DB_NODES="$CASSANDRA_NODES"
export CASSANDRA_RACK="${CASSANDRA_RACK:-rack1}"
export DB_RACK="$CASSANDRA_RACK"
export CASSANDRA_BROADCAST_ADDRESS="${CASSANDRA_BROADCAST_ADDRESS:-}"
export DB_BROADCAST_ADDRESS="$CASSANDRA_BROADCAST_ADDRESS"
export CASSANDRA_AUTOMATIC_SSTABLE_UPGRADE="${CASSANDRA_AUTOMATIC_SSTABLE_UPGRADE:-false}"
export DB_AUTOMATIC_SSTABLE_UPGRADE="$CASSANDRA_AUTOMATIC_SSTABLE_UPGRADE"

# Database initialization settings
export CASSANDRA_STARTUP_CQL="${CASSANDRA_STARTUP_CQL:-}"
export DB_STARTUP_CQL="$CASSANDRA_STARTUP_CQL"
export CASSANDRA_IGNORE_INITDB_SCRIPTS="${CASSANDRA_IGNORE_INITDB_SCRIPTS:-no}"
export DB_IGNORE_INITDB_SCRIPTS="$CASSANDRA_IGNORE_INITDB_SCRIPTS"

# Port configuration
export CASSANDRA_CQL_PORT_NUMBER="${CASSANDRA_CQL_PORT_NUMBER:-9042}"
export DB_CQL_PORT_NUMBER="$CASSANDRA_CQL_PORT_NUMBER"
export CASSANDRA_JMX_PORT_NUMBER="${CASSANDRA_JMX_PORT_NUMBER:-7199}"
export DB_JMX_PORT_NUMBER="$CASSANDRA_JMX_PORT_NUMBER"
export CASSANDRA_TRANSPORT_PORT_NUMBER="${CASSANDRA_TRANSPORT_PORT_NUMBER:-7000}"
export DB_TRANSPORT_PORT_NUMBER="$CASSANDRA_TRANSPORT_PORT_NUMBER"

# Retries and sleep time configuration
export CASSANDRA_CQL_MAX_RETRIES="${CASSANDRA_CQL_MAX_RETRIES:-20}"
export DB_CQL_MAX_RETRIES="$CASSANDRA_CQL_MAX_RETRIES"
export CASSANDRA_CQL_SLEEP_TIME="${CASSANDRA_CQL_SLEEP_TIME:-5}"
export DB_CQL_SLEEP_TIME="$CASSANDRA_CQL_SLEEP_TIME"
export CASSANDRA_INIT_MAX_RETRIES="${CASSANDRA_INIT_MAX_RETRIES:-100}"
export DB_INIT_MAX_RETRIES="$CASSANDRA_INIT_MAX_RETRIES"
export CASSANDRA_INIT_SLEEP_TIME="${CASSANDRA_INIT_SLEEP_TIME:-5}"
export DB_INIT_SLEEP_TIME="$CASSANDRA_INIT_SLEEP_TIME"
export CASSANDRA_PEER_CQL_MAX_RETRIES="${CASSANDRA_PEER_CQL_MAX_RETRIES:-100}"
export DB_PEER_CQL_MAX_RETRIES="$CASSANDRA_PEER_CQL_MAX_RETRIES"
export CASSANDRA_PEER_CQL_SLEEP_TIME="${CASSANDRA_PEER_CQL_SLEEP_TIME:-10}"
export DB_PEER_CQL_SLEEP_TIME="$CASSANDRA_PEER_CQL_SLEEP_TIME"
export CASSANDRA_DELAY_START_TIME="${CASSANDRA_DELAY_START_TIME:-10}"
export DB_DELAY_START_TIME="$CASSANDRA_DELAY_START_TIME"

# Snapshot settings
export CASSANDRA_AUTO_SNAPSHOT_TTL="${CASSANDRA_AUTO_SNAPSHOT_TTL:-30d}"
export DB_AUTO_SNAPSHOT_TTL="$CASSANDRA_AUTO_SNAPSHOT_TTL"

# Authentication, Authorization and Credentials
export ALLOW_EMPTY_PASSWORD="${ALLOW_EMPTY_PASSWORD:-no}"
export CASSANDRA_AUTHORIZER="${CASSANDRA_AUTHORIZER:-CassandraAuthorizer}"
export DB_AUTHORIZER="$CASSANDRA_AUTHORIZER"
export CASSANDRA_AUTHENTICATOR="${CASSANDRA_AUTHENTICATOR:-PasswordAuthenticator}"
export DB_AUTHENTICATOR="$CASSANDRA_AUTHENTICATOR"
export CASSANDRA_USER="${CASSANDRA_USER:-cassandra}"
export DB_USER="$CASSANDRA_USER"
export CASSANDRA_PASSWORD="${CASSANDRA_PASSWORD:-}"
export DB_PASSWORD="$CASSANDRA_PASSWORD"
export CASSANDRA_KEYSTORE_PASSWORD="${CASSANDRA_KEYSTORE_PASSWORD:-cassandra}"
export DB_KEYSTORE_PASSWORD="$CASSANDRA_KEYSTORE_PASSWORD"
export CASSANDRA_TRUSTSTORE_PASSWORD="${CASSANDRA_TRUSTSTORE_PASSWORD:-cassandra}"
export DB_TRUSTSTORE_PASSWORD="$CASSANDRA_TRUSTSTORE_PASSWORD"
export CASSANDRA_KEYSTORE_LOCATION="${CASSANDRA_KEYSTORE_LOCATION:-${DB_VOLUME_DIR}/secrets/keystore}"
export DB_KEYSTORE_LOCATION="$CASSANDRA_KEYSTORE_LOCATION"
export CASSANDRA_TRUSTSTORE_LOCATION="${CASSANDRA_TRUSTSTORE_LOCATION:-${DB_VOLUME_DIR}/secrets/truststore}"
export DB_TRUSTSTORE_LOCATION="$CASSANDRA_TRUSTSTORE_LOCATION"
export CASSANDRA_TMP_P12_FILE="${CASSANDRA_TMP_P12_FILE:-${DB_TMP_DIR}/keystore.p12}"
export DB_TMP_P12_FILE="$CASSANDRA_TMP_P12_FILE"
export CASSANDRA_SSL_CERT_FILE="${CASSANDRA_SSL_CERT_FILE:-${DB_VOLUME_DIR}/certs/tls.crt}"
export DB_SSL_CERT_FILE="$CASSANDRA_SSL_CERT_FILE"
export SSL_CERTFILE="$CASSANDRA_SSL_CERT_FILE"
export CASSANDRA_SSL_KEY_FILE="${CASSANDRA_SSL_KEY_FILE:-${DB_VOLUME_DIR}/certs/tls.key}"
export DB_SSL_KEY_FILE="$CASSANDRA_SSL_KEY_FILE"
export SSL_KEYFILE="$CASSANDRA_SSL_KEY_FILE"
export CASSANDRA_SSL_CA_FILE="${CASSANDRA_SSL_CA_FILE:-}"
export DB_SSL_CA_FILE="$CASSANDRA_SSL_CA_FILE"
export SSL_CAFILE="$CASSANDRA_SSL_CA_FILE"
export CASSANDRA_SSL_VALIDATE="${CASSANDRA_SSL_VALIDATE:-false}"
export DB_SSL_VALIDATE="$CASSANDRA_SSL_VALIDATE"
export SSL_VALIDATE="$CASSANDRA_SSL_VALIDATE"

# cqlsh settings
export SSL_VERSION="${SSL_VERSION:-TLSv1_2}"

# Configuration paths
export CASSANDRA_CONF_DIR="${DB_BASE_DIR}/conf"
export DB_CONF_DIR="$CASSANDRA_CONF_DIR"
export CASSANDRA_DEFAULT_CONF_DIR="${DB_BASE_DIR}/conf.default"
export DB_DEFAULT_CONF_DIR="$CASSANDRA_DEFAULT_CONF_DIR"
export CASSANDRA_CONF_FILE="${DB_CONF_DIR}/cassandra.yaml"
export DB_CONF_FILE="$CASSANDRA_CONF_FILE"
export CASSANDRA_RACKDC_FILE="${DB_CONF_DIR}/cassandra-rackdc.properties"
export DB_RACKDC_FILE="$CASSANDRA_RACKDC_FILE"
export CASSANDRA_LOGBACK_FILE="${DB_CONF_DIR}/logback.xml"
export DB_LOGBACK_FILE="$CASSANDRA_LOGBACK_FILE"
export CASSANDRA_COMMITLOG_ARCHIVING_FILE="${DB_CONF_DIR}/commitlog_archiving.properties"
export DB_COMMITLOG_ARCHIVING_FILE="$CASSANDRA_COMMITLOG_ARCHIVING_FILE"
export CASSANDRA_ENV_FILE="${DB_CONF_DIR}/cassandra-env.sh"
export DB_ENV_FILE="$CASSANDRA_ENV_FILE"
export CASSANDRA_MOUNTED_CONF_DIR="${CASSANDRA_MOUNTED_CONF_DIR:-${DB_VOLUME_DIR}/conf}"
export DB_MOUNTED_CONF_DIR="$CASSANDRA_MOUNTED_CONF_DIR"
export CASSANDRA_MOUNTED_CONF_PATH="cassandra.yaml"
export DB_MOUNTED_CONF_PATH="$CASSANDRA_MOUNTED_CONF_PATH"
export CASSANDRA_MOUNTED_RACKDC_PATH="cassandra-rackdc.properties"
export DB_MOUNTED_RACKDC_PATH="$CASSANDRA_MOUNTED_RACKDC_PATH"
export CASSANDRA_MOUNTED_ENV_PATH="cassandra-env.sh"
export DB_MOUNTED_ENV_PATH="$CASSANDRA_MOUNTED_ENV_PATH"
export CASSANDRA_MOUNTED_LOGBACK_PATH="logback.xml"
export DB_MOUNTED_LOGBACK_PATH="$CASSANDRA_MOUNTED_LOGBACK_PATH"

# Java settings
export JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS:-}"

# Custom environment variables may be defined below
