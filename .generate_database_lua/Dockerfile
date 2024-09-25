FROM nickblah/lua:5.1-luarocks

RUN apt-get update && apt-get install -y git gcc
# Install OpenSSL for LuaSec
RUN apt-get install -y libssl-dev

RUN luarocks install bit32
RUN luarocks install argparse
RUN luarocks install luafilesystem
RUN luarocks install luasocket
RUN luarocks install luasec

RUN apt-get update && apt-get install -y wget