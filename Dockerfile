FROM python:3.9-slim-buster
# Set environment variables
ENV SPARK_VERSION=3.4.0
ENV HADOOP_VERSION=3.3.4
ENV PYSPARK_PYTHON=python
ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin
ENV HADOOP_HOME=/opt/hadoop
ENV PATH=$PATH:/opt/spark/bin

# Install dependencies and utilities
RUN apt-get update -y && apt-get install -y \
    wget \
    openjdk-11-jdk \
    && apt-get clean

# Download Apache Spark
RUN wget -q https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz && \
    tar xzf spark-${SPARK_VERSION}-bin-hadoop3.tgz && \
    mv spark-${SPARK_VERSION}-bin-hadoop3 /opt/spark && \
    rm spark-${SPARK_VERSION}-bin-hadoop3.tgz

# Create a symbolic link to make Spark directory consistent
RUN ln -s /opt/spark-${SPARK_VERSION}-bin-hadoop3 ${SPARK_HOME}

# Add Spark binaries to the PATH
ENV PATH="${SPARK_HOME}/bin:${PATH}"

COPY ./analytics/spark-defaults.conf $SPARK_HOME/conf/spark-defaults.conf
COPY ./analytics/spark-submit.py /root/spark-submit.py
RUN spark-submit --packages \
    org.apache.hadoop:hadoop-aws:${HADOOP_VERSION} \
    /root/spark-submit.py && \
    mv /root/.ivy2/jars/* $SPARK_HOME/jars/ && \
    rm -rf /root/.ivy2
RUN chmod 644 $SPARK_HOME/jars/*
RUN pip install pyspark==${SPARK_VERSION}
