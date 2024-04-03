FROM nickblah/lua:5.1-luarocks

RUN apt-get update && apt-get install -y git gcc
RUN luarocks install bit32
RUN luarocks install argparse
RUN luarocks install luafilesystem

RUN apt-get update && apt-get install -y python3 python3-pip wget && \
    pip3 install git+https://github.com/SirAnthony/slpp && \
    pip3 install luaparser && \
    pip3 install requests