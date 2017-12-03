from cassandra.cluster import Cluster
from datetime import datetime
import random
import uuid

cluster = Cluster(['127.0.0.1'])
session = cluster.connect('lab')

def make_date():
    year = random.randint(2017, 2017)
    month = random.randint(10, 12)
    day = random.randint(1, 30)
    hour = random.randint(0, 23)
    minute = random.randint(0, 59)
    sec = random.randint(0, 59)

    date = datetime(year, month, day, hour, minute, sec)
    return date.isoformat()


insertCql = session.prepare("INSERT INTO lab.time_bucket (tx_hour, tx_ts, record_id) VALUES(?,?,?)")

for i in range(0, 779035):
    ts = make_date()
    dt = ts[:13]
    record_id = str(uuid.uuid4())
    session.execute(insertCql, [dt,ts,record_id])


print("Finished")
