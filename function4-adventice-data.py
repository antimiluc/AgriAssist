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
url_infloweb = "http://www.infloweb.fr/"
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
def test(request):
    res = ""
    request_json = request.get_json()
    if request.args and ('culture' in request.args) and ('adventice' in request.args):
        culture = request.args.get('culture')
        adventice = request.args.get('adventice')
    elif request_json and ('culture' in request_json) and ('adventice' in request_json):
        culture = request_json['culture']
        adventice = request_json['adventice']
    else:
        return f'Adventice et culture non renseignées'
    with db.connect() as conn:
        # Execute the query and fetch all results
        query_culture = "SELECT id FROM CULTURE WHERE name ='"+culture+"'"
        query_adventice = "SELECT id,extension_url FROM ADVENTICE WHERE name ='"+adventice+"'"
        id_culture = str(conn.execute(query_culture).fetchall()[0][0])
        id_adventice = str(conn.execute(query_adventice).fetchall()[0][0])
        url_adventice = url_infloweb + str(conn.execute(query_adventice).fetchall()[0][1])
        query_list_destruction_method = "SELECT id_destruction_method FROM IS_DESTROYED_BY WHERE id_culture ='"+id_culture+"' AND id_adventice= '"+id_adventice+"'"
        list_destruction_method = conn.execute(query_list_destruction_method).fetchall()
        # Pour chaque id, on fait une requete dans la table DESTRUCTION_METHOD pour récupérer les names et descriptions
        for row in list_destruction_method:
            query_info = "SELECT name, description_infloweb, description_euralis FROM DESTRUCTION_METHOD WHERE id ="+str(row[0])
            info = conn.execute(query_info).fetchall()
            name = info[0][0]
            info_infloweb = info[0][1]
            info_euralis = info[0][2]
            if info_euralis == None:
                info_euralis = "..."
            res += "Methode de destruction : "+name+"\n"+info_infloweb+"\nInformation issue de Infloweb "+url_adventice+"\nEuralis vous recommande "+info_euralis+"\n \n"
    return res

if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8080, debug=True)
