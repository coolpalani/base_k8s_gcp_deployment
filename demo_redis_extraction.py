#!/user/bin/python
# base_k8s_gcp_deployment/demo_redis_extraction.py

""" Demo script to extract a pd.DataFrame() from redis
    - SSH into the python node on the k8s cluster
    - Run this code in a python shell
    - (assumes python node has adequate packages)
"""

import pandas as pd
import redis
import os

# Redis global client pool
def redis_pool_instantiation():
    """ Instantiate a global connection pool to draw redis clients from """
    global redis_client_pool
    redis_client_pool = redis.ConnectionPool(host=os.environ.get('REDIS_MASTER_SERVICE_HOST'), port=6379, db=0)


# Instantiate redis client, and get a pool connection clien
redis_pool_instantiation()
redis_conn = redis.StrictRedis(connection_pool=redis_client_pool)

# Read pd.DataFrame() from redis list
# Set the filtering on the dataframe columns for demonstration purposes
# (From ssh-ing into the redis node, extract a key name and substitute for None below)
key_name = None
column_filtering = []
nested_df = redis_conn.lrange(key_name, 0, 0)
unnested_df = pd.read_msgpack(nested_df[0][0]) if type(nested_df[0]) == list else pd.read_msgpack(nested_df[0])
df = unnested_df[column_filtering]

# Inspect DataFrame
print("\n\nShape of DataFrame: {} \n\t"
      "Columns of DataFrame:  {} \n\t"
      "First 10 values of DataFrame:  \n{}\n\n"
      .format(df.shape, df.columns.tolist(), df[:10]))

# END OF DEMO