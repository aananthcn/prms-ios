import sys
import sqlite3
import pandas as pd

def export_to_excel(database_file):
    # Connect to SQLite database
    conn = sqlite3.connect(database_file)

    # Get list of tables in the database
    tables = pd.read_sql("SELECT name FROM sqlite_master WHERE type='table'", conn)

    # Export each table to Excel
    with pd.ExcelWriter('output.xlsx') as writer:
        for table in tables['name']:
            df = pd.read_sql(f"SELECT * FROM {table}", conn)
            df.to_excel(writer, sheet_name=table, index=False)

    # Close connection
    conn.close()

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python export_to_excel.py <database_file>")
        sys.exit(1)
    
    database_file = sys.argv[1]
    export_to_excel(database_file)
