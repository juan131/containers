#!/bin/bash
# Copyright Broadcom, Inc. All Rights Reserved.
# SPDX-License-Identifier: APACHE-2.0

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Load libraries
. /opt/bitnami/scripts/libclickhousekeeper.sh

# Load ClickHouse Keeper environment settings
. /opt/bitnami/scripts/clickhouse-keeper-env.sh

# Ensure 'daemon' user exists when running as 'root'
am_i_root && ensure_user_exists "$CLICKHOUSE_DAEMON_USER" --group "$CLICKHOUSE_DAEMON_GROUP"

# ClickHouse Keeper initialization, skipped if custom keeper_config.xml was mounted
if ! is_boolean_yes "$CLICKHOUSE_KEEPER_SKIP_SETUP" && [[ ! -f "$CLICKHOUSE_KEEPER_CONF_FILE" ]]; then
    # Ensure ClickHouse Keeper environment settings are valid
    keeper_validate
    # Ensure ClickHouse Keeper is initialized
    keeper_initialize
fi
