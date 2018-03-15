FROM openjdk:9-jre

ARG JMETER_VERSION="4.0"
ARG JMETER_PMANAGER_VERSION="0.19"
ARG CMDRUNNER_VERSION="2.0"
ARG JMETER_HOME="/opt/jmeter"
ARG JMETER_PLUGINS_PATH="/opt/jmeter/lib/ext"

RUN wget http://apache.mirror.gtcomm.net//jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz
RUN tar -xvzf apache-jmeter-${JMETER_VERSION}.tgz
RUN rm apache-jmeter-${JMETER_VERSION}.tgz
RUN mv apache-jmeter-${JMETER_VERSION} ${JMETER_HOME}

# Get plugins
RUN wget http://central.maven.org/maven2/kg/apc/jmeter-plugins-manager/${JMETER_PMANAGER_VERSION}/jmeter-plugins-manager-${JMETER_PMANAGER_VERSION}.jar
RUN mv ./jmeter-plugins-manager-${JMETER_PMANAGER_VERSION}.jar ${JMETER_HOME}/lib/ext

RUN wget http://repo1.maven.org/maven2/kg/apc/cmdrunner/${CMDRUNNER_VERSION}/cmdrunner-${CMDRUNNER_VERSION}.jar
RUN mv ./cmdrunner-2.0.jar ${JMETER_HOME}/lib

RUN java -cp ${JMETER_HOME}/lib/ext/jmeter-plugins-manager-${JMETER_PMANAGER_VERSION}.jar org.jmeterplugins.repository.PluginManagerCMDInstaller
RUN ${JMETER_HOME}/bin/PluginsManagerCMD.sh install-all-except 

ENV JMETER_HOME ${JMETER_HOME}
ENV PATH ${JMETER_HOME}/bin:$PATH