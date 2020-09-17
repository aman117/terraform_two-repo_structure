Credentials should be added to Jenkins pod as ENV variables (through secret)
	Inside Jenkins master, when it starts, it should do a sed replacement:
		sed -i "s|JENKINS_READ_PASS|${READ_PASSWORD}|g;s|JENKINS_BUILD_PASS|${BUILD_PASSWORD}|g" /var/jenkins_home/init.groovy.d/basic-security.groovy

		You need to have a script that does above sed replacements when Jenkins starts

Overwrite ENTRYPOINT to your own script:
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]
to
ENTRYPOINT ["/sbin/tini", "--", "/bin/configure-and-run-jenkins"]


/bin/configure-and-run-jenkins:

#!/bin/sh

DESTINATION_DIR=/var/jenkins_home

# Insert dynamic value in the config

sed -i "s,GITHUB_USER,${GITHUB_USER},g; \
        s,GITHUB_PASS,${GITHUB_PASS},g;" \
    ${DESTINATION_DIR}/credentials.xml

sed -i "s,JENKINS_BUILD_USER,${JENKINS_BUILD_USER},g; \
        s,JENKINS_BUILD_PASS,${JENKINS_BUILD_PASS},g; \
        s,JENKINS_READ_USER,${JENKINS_READ_USER},g; \
        s,JENKINS_READ_PASS,${JENKINS_READ_PASS},g;" \
    ${DESTINATION_DIR}/init.groovy.d/basic-security.groovy

# Run jenkins
/usr/local/bin/jenkins.sh
