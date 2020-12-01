FROM arm32v7/alpine
LABEL MAINTAINER="Adán Antón  <adanton@gmail.com>" \
    Description="Simple and lightweight Samba docker container, based on Alpine Linux." \
    Version="1.0"
# For armv7
# upgrade base system and install samba and supervisord
RUN apk --no-cache add samba supervisor bash

# create a dir for the config and the share
RUN mkdir /config /shared

# copy config files from project folder to get a default config going for samba and supervisord
COPY *.conf /config/
# add a non-root user and group called "user" with no password, no home dir, no shell, and gid/uid set to 1000
#RUN addgroup -g 1000 user && adduser -D -H -G user -s /bin/false -u 1000 user

# create a samba user matching our user from above with a very simple password ("pass")
#RUN echo -e "pass\npass" | smbpasswd -a -s -c /config/smb.conf user

# volume mappings
VOLUME /shared

# exposes samba's default ports (135 for End Point Mapper [DCE/RPC Locator Service],
# 137, 138 for nmbd and 139, 445 for smbd)
EXPOSE 135/tcp 137/udp 138/udp 139/tcp 445/tcp

ENTRYPOINT ["supervisord", "-c", "/config/supervisord.conf"]
