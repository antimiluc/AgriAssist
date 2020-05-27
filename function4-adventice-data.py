import datetime
import logging
import os

from flask import Flask, render_template, request, Response
import sqlalchemy

# Remember - storing secrets in plaintext is potentially unsafe. Consider using
# something like https://cloud.google.com/kms/ to help keep secrets secret.
db_user = os.environ.get("DB_USER")
db_pass = os.environ.get("DB_PASS")
db_name = os.environ.get("DB_NAME")
cloud_sql_connection_name = os.environ.get("CLOUD_SQL_CONNECTION_NAME")

app = Flask(__name__)

logger = logging.getLogger()

# [START cloud_sql_mysql_sqlalchemy_create]
# The SQLAlchemy engine will help manage interactions, including automatically
# managing a pool of connections to your database
db = sqlalchemy.create_engine(
    # Equivalent URL:
    # mysql+pymysql://<db_user>:<db_pass>@/<db_name>?unix_socket=/cloudsql/<cloud_sql_instance_name>
    sqlalchemy.engine.url.URL(
        drivername="mysql+pymysql",
        username=db_user,
        password=db_pass,
        database=db_name,
        query={"unix_socket": "/cloudsql/{}".format(cloud_sql_connection_name)},
    ),
    pool_pre_ping=True
)

@app.route("/", methods=["GET"])
def test():
    res = []
    with db.connect() as conn:
        # Execute the query and fetch all results
        test = conn.execute("SELECT * FROM CULTURE").fetchall()
        # Convert the results into a list of dicts representing votes
        for row in test:
            res.append({"id": row[0], "name": row[1]})
    #return render_template("index.html", test=votes)
    return(res[0])

if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8080, debug=True)
