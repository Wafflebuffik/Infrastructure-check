FROM ubuntu:22.04
WORKDIR /app
COPY src/requirements.sh /app/
RUN apt-get update \
&& chmod +x requirements.sh
# CMD apt-get upgrade -y && ./requirements.sh
CMD ["/bin/bash", "-c", "apt-get upgrade -y && ./requirements.sh && sleep infinity"]
