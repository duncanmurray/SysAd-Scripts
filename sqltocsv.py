import csv
import pymysql

file=open("comments_encore.csv","w");

db=pymysql.connect(host="localhost",user="XXXX",passwd="XXXX",db="XXXX")
query="""select * from comments where comment_on > DATE_SUB(now(), INTERVAL 6 MONTH)"""
output=csv.writer(file, dialect='excel')

cursor=db.cursor()
cursor.execute(query)

output.writerow([i[0] for i in cursor.description])
for row in cursor:
    output.writerow(row)

cursor.close()
db.close()
file.close()
