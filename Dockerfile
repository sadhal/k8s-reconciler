
FROM flant/shell-operator:latest

RUN  apt-get update && \
    apt-get install -y git  

ADD hooks /hooks
