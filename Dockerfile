FROM openjdk:9-jre

ARG JMETER_VERSION="5.4.1"
ARG JMETER_PMANAGER_VERSION="1.6"
ARG CMDRUNNER_VERSION="2.2"
ARG JMETER_HOME="/opt/jmeter"
ARG JMETER_PLUGINS_PATH="/opt/jmeter/lib/ext"

RUN wget http://apache.mirror.gtcomm.net//jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz \
  && tar -xvzf apache-jmeter-${JMETER_VERSION}.tgz \
  && rm apache-jmeter-${JMETER_VERSION}.tgz \
  && mv apache-jmeter-${JMETER_VERSION} ${JMETER_HOME}

# Uncomment some JVM Options
RUN sed -i '/RUN_IN_DOCKER/s/^#//g' /opt/jmeter/bin/jmeter \
  && sed -i '/VERBOSE_GC="-Xlog:gc/s/^#//g' /opt/jmeter/bin/jmeter

# Install plugins
RUN wget http://central.maven.org/maven2/kg/apc/jmeter-plugins-manager/${JMETER_PMANAGER_VERSION}/jmeter-plugins-manager-${JMETER_PMANAGER_VERSION}.jar \
  && mv ./jmeter-plugins-manager-${JMETER_PMANAGER_VERSION}.jar ${JMETER_HOME}/lib/ext \
  && wget http://repo1.maven.org/maven2/kg/apc/cmdrunner/${CMDRUNNER_VERSION}/cmdrunner-${CMDRUNNER_VERSION}.jar \
  && mv ./cmdrunner-${CMDRUNNER_VERSION}.jar ${JMETER_HOME}/lib \
  && java -cp ${JMETER_HOME}/lib/ext/jmeter-plugins-manager-${JMETER_PMANAGER_VERSION}.jar org.jmeterplugins.repository.PluginManagerCMDInstaller \
  && ${JMETER_HOME}/bin/PluginsManagerCMD.sh install-all-except 

# Install Git
RUN apt-get update && apt-get install -y git

ENV JMETER_HOME ${JMETER_HOME}
ENV PATH ${JMETER_HOME}/bin:$PATH
