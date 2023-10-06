# pyspark-k8s-py3.9

For several years, I've worked with Databricks, a platform that I wholeheartedly recommend. However, given the current constraints within my current company, I embarked on a journey to explore alternative solutions, and one that emerged as a viable path forward was the utilization of PySpark within a Kubernetes environment.

Up until that point, I hadn't had the opportunity to work extensively with Kubernetes, so I immersed myself in a substantial learning curve.

My initial endeavor involved using a PySpark image specifically tailored for processing data stored in S3, particularly in the Delta format. However, a new challenge presented itself when I needed to integrate PySpark into a containerized environment where services were already running on Kubernetes using the python:3.9-slim-buster image.

This led me down a path of configuring PySpark in a rather customized  manner. After extensive research and effort, I ultimately succeeded in finding a configuration that worked seamlessly for my needs:

> It covers the creation of a PySpark image for processing data in S3, particularly in Delta format, as well as the intricacies of configuring PySpark within an existing Kubernetes environment running services on the python:3.9-slim-buster image. 
