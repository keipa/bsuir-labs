# resource server config

RESOURCE_PORT = 9090

SERVER_NAME = 'localserver'

server_key = 'serversecretkey'



# AS config

AS_PORT = 9091

ticket_expire_time = 48 * 60 * 60



# TGS config

TGS_PORT = 9092

TGS_NAME = 'localtgs'

tgs_key = 'tgssecretkey'


# client config

localhost = 'localhost'

SERVER_ADDR = (localhost, RESOURCE_PORT)

AS_ADDR = (localhost, AS_PORT)

TGS_ADDR = (localhost, TGS_PORT)

HOST = ''