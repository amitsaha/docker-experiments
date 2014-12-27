import redis

r = redis.StrictRedis(host='127.0.0.1', port=49154, db = 0)
r.set('foo', 'bar')
print r.get('foo')
