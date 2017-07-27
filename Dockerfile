# FROM ubuntu:16.04
FROM ubuntu:16.04

EXPOSE 8000:8000

WORKDIR /Development

RUN apt-get update && apt-get install -y wget xz-utils git python2.7 build-essential && \
wget https://nodejs.org/dist/v6.10.2/node-v6.10.2-linux-x64.tar.xz -O node.tar.xz  && \
tar -xvf node.tar.xz && \
cp -R node-v6.10.2-linux-x64/* /usr/local/ && \

  useradd --user-group --create-home --shell /bin/bash shintech && \
  chown -R shintech:shintech /Development

USER shintech
 
RUN git clone git://github.com/c9/core.git $HOME/c9sdk && \
  $HOME/c9sdk/scripts/install-sdk.sh
 
CMD node $HOME/c9sdk/server.js -x -- -p 8000 -a : --listen 0.0.0.0 -w /Development  