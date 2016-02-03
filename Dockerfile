FROM java:8
MAINTAINER "Alexei Novikov <alexeinov@gmail.com>"
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN javac Hammer.java
CMD ["java", \
"-Dcom.sun.management.jmxremote", \
"-Dcom.sun.management.jmxremote.port=9010", \
# Uncomment this line when running JMX console on a different host
#"-Dcom.sun.management.jmxremote.rmi.port=9010", \
"-Dcom.sun.management.jmxremote.local.only=false", \
"-Dcom.sun.management.jmxremote.authenticate=false", \
"-Dcom.sun.management.jmxremote.ssl=false", \
# Uncomment this line when running JMX console on a different host, use a name of the host where Docker is running
#"-Djava.rmi.server.hostname=192.168.0.101", \
"Hammer"]
EXPOSE 9010
