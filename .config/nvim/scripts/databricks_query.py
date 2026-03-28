#!/usr/bin/env python3
"""
Databricks SQL warehouse query runner for vim-dadbod.

Usage: databricks_query.py <host> <http_path> <token>
Reads SQL from stdin and outputs tab-separated results.

Requires: pip install databricks-sql-connector
"""
import sys


def main():
    if len(sys.argv) < 4:
        print(
            "Usage: databricks_query.py <host> <http_path> <token>",
            file=sys.stderr,
        )
        sys.exit(1)

    host = sys.argv[1]
    http_path = sys.argv[2]
    token = sys.argv[3]

    sql = sys.stdin.read().strip()
    if not sql:
        sys.exit(0)

    try:
        from databricks import sql as dbsql
    except ImportError:
        print(
            "Error: databricks-sql-connector not installed.\n"
            "Run: pip install databricks-sql-connector",
            file=sys.stderr,
        )
        sys.exit(1)

    with dbsql.connect(
        server_hostname=host,
        http_path=http_path,
        access_token=token,
    ) as connection:
        with connection.cursor() as cursor:
            # Support multiple semicolon-separated statements; run each in turn
            statements = [s.strip() for s in sql.split(";") if s.strip()]
            for statement in statements:
                cursor.execute(statement)
                if cursor.description:
                    headers = [col[0] for col in cursor.description]
                    rows = [
                        [str(v) if v is not None else "NULL" for v in row]
                        for row in cursor.fetchall()
                    ]
                    widths = [
                        max(len(h), max((len(r[i]) for r in rows), default=0))
                        for i, h in enumerate(headers)
                    ]
                    print("  ".join(h.ljust(w) for h, w in zip(headers, widths)))
                    print("  ".join("-" * w for w in widths))
                    for row in rows:
                        print("  ".join(v.ljust(w) for v, w in zip(row, widths)))
                    if len(statements) > 1:
                        print()


if __name__ == "__main__":
    main()
