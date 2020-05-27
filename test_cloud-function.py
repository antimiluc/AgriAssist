def hello_world(request):
    """Responds to any HTTP request.
    Args:
        request (flask.Request): HTTP request object.
    Returns:
        The response text or any set of values that can be turned into a
        Response object using
        `make_response <http://flask.pocoo.org/docs/1.0/api/#flask.Flask.make_response>`.
    """
    request_json = request.get_json()
    if request.args and ('adventice' in request.args) and ('culture' in request.args) :
        a = request.args.get('adventice')
        c = request.args.get('culture')
        return f'Cest du args'
    elif request_json and ('adventice' in request_json) and ('culture' in request_json) :
        a = request_json['adventice']
        c = request_json['culture']
        """ requête SQL pour récupérer les descriptions"""
        #sql_query = "SELECT description, description_euralis, name FROM DESTRUCTION_METHOD WHERE id = (SELECT id_destruction_method FROM IS_DESTROYED_BYWHERE id_adventice = (SELECT id FROM ADVENTICE WHERE name = "+a+")AND id_culture = (SELECT id FROM CULTURE WHERE name = "+c+"));"
        sql_query = "SELECT * FROM ADVENTICE"
        # The SQLAlchemy engine will help manage interactions, including automatically
        # managing a pool of connections to your database
        db = sqlalchemy.create_engine(sqlalchemy.engine.url.URL(drivername="mysql+pymysql",username=db_user,password=db_pass,database=db_name,query={"unix_socket": "/cloudsql/{}".format('euralis-eisti:europe-west1:info-adventice')},),)

        print( db )
        #desc_euralis = "euralis"
        #desc_infloweb = "infloweb"
        #reponse = desc_infloweb + "Issu de Infloweb, URL =... \n Euralis vous recommande : "+desc_euralis
        return reponse
    else:
        return f'Pas de culture ou adventice'
