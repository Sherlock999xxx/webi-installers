#!/bin/sh
# shellcheck disable=SC2034

set -e
set -u

__init_sql_migrate() {
    pkg_cmd_name="sql-migrate"

    pkg_dst_cmd="${HOME}/.local/bin/sql-migrate"
    pkg_dst="${pkg_dst_cmd}"

    pkg_src_cmd="${HOME}/.local/opt/sql-migrate-v${WEBI_VERSION}/bin/sql-migrate"
    pkg_src_dir="${HOME}/.local/opt/sql-migrate-v${WEBI_VERSION}"
    pkg_src="${pkg_src_cmd}"

    pkg_install() {
        pkg_src_bin=$(dirname "${pkg_src_cmd}")
        mkdir -p "${pkg_src_bin}"
        mv ./sql-migrate "${pkg_src_cmd}"
    }

    # pkg_get_current_version is recommended, but (soon) not required
    pkg_get_current_version() {
        # 'sql-migrate version' has output in this format:
        #       sql-migrate v0.0.0-dev 0000000 (0001-01-01)
        # This trims it down to just the version number:
        #       v0.0.0-dev
        sql-migrate version 2> /dev/null | head -n 1 | cut -d ' ' -f 2
    }
}

__init_sql_migrate
