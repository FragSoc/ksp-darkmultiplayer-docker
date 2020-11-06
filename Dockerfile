FROM mono

ARG UID=999
ARG DARK_MULTIPLAYER_VERSION="v0.3.6.0"

ENV INSTALL_LOC="/server"
ENV CONFIG_LOC="/config"
ENV DOWNLOAD_LOC="/tmp/server.zip"

RUN apt-get update
RUN apt-get install -y --no-install-recommends unzip
RUN useradd -s /bin/false -r -u $UID darkmultiplayer
RUN curl "https://d-mp.org/builds/release/$DARK_MULTIPLAYER_VERSION/DMPServer.zip" --output $DOWNLOAD_LOC
RUN unzip $DOWNLOAD_LOC -d /tmp
RUN mv /tmp/DMPServer $INSTALL_LOC
RUN ln -s $CONFIG_LOC $INSTALL_LOC/Config 
RUN mkdir -p $CONFIG_LOC
RUN chown -R darkmultiplayer:darkmultiplayer $INSTALL_LOC $CONFIG_LOC

USER darkmultiplayer
VOLUME $CONFIG_LOC
WORKDIR $INSTALL_LOC
ENTRYPOINT ["mono", "DMPServer.exe"]
