from base import smash_base

@smash_base
def parallel(df, **kwargs):
    return {'data':  df.to_json(orient='records')}




