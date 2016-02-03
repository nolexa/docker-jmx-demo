# docker-jmx-demo
## A simple demo getting JMX metrics from a docker container

This demo is a Docker container that starts a simple Java application with pre-configured JMX options. Manipulating the options and running a container and JMX console in different modes demonstrates different cases of JMX monitoring. In all variants, JMX is bound to the port `9010`, so `JConsole` will always be connecting a remote host `hostname:9010`, even when running locally.

### Build an image

Run the `docker build` command in the project's directory.
```bash
docker build -t banging-daemon .
```

### Bridge networking mode

Bridge mode is the default for a Docker container. In this mode only the published container's ports are accessible

#### Local `JConsole`

However, when running `JConsole` on the same machine, RMI options do not need to be advertised. The following lines of the `Dockerfile` may stay disabled.

```dockerfile
#"-Dcom.sun.management.jmxremote.rmi.port=9010", \
#"-Djava.rmi.server.hostname=192.168.0.101", \
```
Run the container publishing the `JMX` remote port `9010`.  

```bash
docker run -it --rm --name hammer -p 9010:9010 banging-daemon
```

#### Remote `JConsole`

When `JConsole` is running on a different machine, RMI options have to be set, as a randomly RMI port is not accessible by the remote machine. It is convenient to set the port `com.sun.management.jmxremote.rmi.port` to the same value as `com.sun.management.jmxremote.port`, which is `9010` in this configuration. Using same port number makes one port mapping configuration less in a Docker container and eventually in a firewall. Parameter `java.rmi.server.hostname` should point at a host where Docker is running.

```dockerfile
"-Dcom.sun.management.jmxremote.rmi.port=9010", \
"-Djava.rmi.server.hostname=192.168.0.101", \
```

### Host networking mode

In the host mode, the container's network is not encapsulated at all. It is accessible alongside the host's network. In this case the RMI options do not need to be configured.

```dockerfile
#"-Dcom.sun.management.jmxremote.rmi.port=9010", \
#"-Djava.rmi.server.hostname=192.168.0.101", \
```

Running `JConsole` locally or remotely does not make any difference.

 The `JMX` remote port does not need to be published:

```bash
docker run -it --rm --net=host --name hammer banging-daemon
```
