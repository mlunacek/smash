from base import smash_base

@smash_base
def horizon(df, **kwargs):

    return {'data':  df.to_json()}




