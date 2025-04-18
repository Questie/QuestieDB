# FROM nickblah/lua:5.1-luarocks
FROM nickblah/lua:5.1-luarocks-ubuntu

RUN apt-get update && apt-get install -y software-properties-common gnupg gcc
# Get the latest version of Git
# RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E363C90F8F1B6217 A1715D88E1DF1F24
RUN add-apt-repository ppa:git-core/ppa -y
RUN apt-get update && apt-get install -y git

# Install OpenSSL for LuaSec
RUN apt-get install -y libssl-dev

RUN luarocks install bit32
RUN luarocks install argparse
RUN luarocks install luafilesystem
RUN luarocks install luasocket
RUN luarocks install luasec

RUN apt-get update && apt-get install -y wget