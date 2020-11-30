# Simplest samba server

Still in development !!!

The simplest samba server without complex configuration

There are no permissions, only a folder is shared with full access for any user.
Of course it is not a good idea for a network open to the public, but it is convenient to easily configure a shared folder in a home environment.

## Command line
It is only necessary to open the necessary ports and indicate the folder that I want to share (for example /home/myuser/shared):

```
docker run -dti --name samba /
	-p 137:137 -p 138:138 -p 139:139 -p 445:445 /
	-v /home/myuser/shared:/shared adanton/samba
```

## Docker compose
Change only '/home/myuser/shared' for your own shared folder:

```
  samba:
    image: adanton/samba
    container_name: samba
    restart: unless-stopped
    volumes:
      - /home/myuser/shared:/shared
    ports:
      - "137:137"
      - "138:138"
      - "139:139"
      - "445:445"
```

NOTE: Full read and write permissions must be assigned to the shared folder:
``` 
chmod 777 /home/myuser/shared 
```
