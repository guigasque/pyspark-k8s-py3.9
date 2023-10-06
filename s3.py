import os
import time
import pyspark
from datetime import datetime

AWS_ANALYTICS_S3_ACCESS_KEY = os.getenv("AWS_ACCESS_KEY_ID")
AWS_ANALYTICS_S3_SECRET_KEY = os.getenv("AWS_SECRET_ACCESS_KEY")

conf = (
    pyspark.SparkConf()
    .set("spark.hadoop.fs.s3a.access.key", AWS_ANALYTICS_S3_ACCESS_KEY)
    .set("spark.hadoop.fs.s3a.secret.key", AWS_ANALYTICS_S3_SECRET_KEY)
    .setAppName('pyspark_aws')
        )

sc=pyspark.SparkContext(conf=conf)
spark=pyspark.sql.SparkSession(sc)

start = time.time()
df = spark.read.format("parquet").load("s3a://{bucket_name}/mock_data_delta_table/")
end = time.time()
print(f'Read Data: The process finished at {datetime.fromtimestamp(end)}')
time_delta = end - start
print(f'Read Data: The process lasted {time_delta} seconds')


start = time.time()
print(df.count())
end = time.time()
print(f'Count: The process finished at {datetime.fromtimestamp(end)}')
time_delta = end - start
print(f'Count: The process lasted {time_delta} seconds')

spark.stop()