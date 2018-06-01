# kerio-vpn-client
Kerio VPN Client docker container

# How to use this image
This image connects to Kerio VPN Server and mounts Samba shares.

## Sharing connection

### With host

You can use flag `--net=host`

### With another containers

Use flag `--net=container:kerio-container` for the containers where you want to use the connection.

## Examples of configuration
This will mount all points to ${PWD}/mountpoint.
It is important to use the propagation flag shared.

    sudo docker run -it -v ${PWD}/mountpoint:/mnt:shared -d kerio-vpn-client server.domain.com username password domain.com mount.domain.com

## Configuration

    sudo docker run -it -v ${PWD}/mountpoint:/mnt:shared -d kerio-vpn-client <server> <username> <password> <domain> <mountpoint-1> [mountpoint-2] [mountpoint-x..]

## Known Issues

You can't use named volumes. Named volumes don't have option for propagation.

