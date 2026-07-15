#!/usr/bin/env python3
"""
Databricks SQL warehouse query runner for vim-dadbod.

Usage: databricks_query.py <host> <http_path> <token>
Reads SQL from stdin and outputs column-aligned results.

If the SQL begins with a "-- csv" directive line, results are emitted as
CSV instead (RFC 4180 quoting via the csv module). Save the preview buffer
with :w file.csv to export.

SELECT/WITH statements automatically get "LIMIT 200" appended unless they
already end with a LIMIT clause. A leading "-- no-limit" directive line
disables this. Directive lines can be stacked in any order.

Requires: pip install databricks-sql-connector
"""
import csv
import re
import sys

DEFAULT_LIMIT = 200

DIRECTIVE_RE = re.compile(
    r"^[ \t]*--[ \t]*(csv|no[-_ ]?limit)[ \t]*(?:\r?\n|$)", re.IGNORECASE
)


def apply_limit(statement):
    """Append LIMIT 200 to SELECT statements that don't already end with one."""
    if not re.match(r"^\s*(SELECT|WITH)\b", statement, re.IGNORECASE):
        return statement
    if re.search(r"\bLIMIT\s+\d+(\s+OFFSET\s+\d+)?\s*$", statement, re.IGNORECASE):
        return statement
    return "{}\nLIMIT {}".format(statement, DEFAULT_LIMIT)


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

    # Detect leading directive lines ("-- csv", "-- no-limit") and strip
    # them before executing.
    csv_mode = False
    no_limit = False
    while True:
        directive = DIRECTIVE_RE.match(sql)
        if not directive:
            break
        if directive.group(1).lower() == "csv":
            csv_mode = True
        else:
            no_limit = True
        sql = sql[directive.end():].strip()
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
            writer = csv.writer(sys.stdout)
            for statement in statements:
                if not no_limit:
                    statement = apply_limit(statement)
                cursor.execute(statement)
                if not cursor.description:
                    continue
                headers = [col[0] for col in cursor.description]
                rows = [
                    [str(v) if v is not None else "NULL" for v in row]
                    for row in cursor.fetchall()
                ]
                if csv_mode:
                    writer.writerow(headers)
                    writer.writerows(rows)
                    if len(statements) > 1:
                        print()
                    continue
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
