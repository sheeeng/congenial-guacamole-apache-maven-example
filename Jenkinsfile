#!/usr/bin/env groovy

node {
    def mvnHome

    echo "getClass().getName(): " + getClass().getName()

    // https://github.com/jenkinsci/pipeline-plugin/blob/master/TUTORIAL.md#build-parameters
    sh "echo Yo1, parameterOption is ${params.parameterOption}"
    sh 'echo Yo2, parameterOption is ' + params.parameterOption
    if (params.parameterOption) {
      // do something
      echo 'The parameterOption is defined.'
    } else {
        echo "The parameterOption is not defined."
    }

    stage('Preparation') {
        // Get some code from a Git repository.
        checkout([
        $class: 'GitSCM',
        branches: [[name: '*/master']],
        doGenerateSubmoduleConfigurations: false,
        extensions: [],
        submoduleCfg: [],
        userRemoteConfigs: [[
            credentialsId: 'fd8ecd69-7ee9-481e-9061-69cc669c29bc',
            url: 'https://github.com/sheeeng/congenial-guacamole-apache-maven-example.git']]
        ])
        // Get the Maven tool.
        // ** NOTE: This 'M3' Maven tool must be configured
        // **       in the global configuration.
        mvnHome = tool 'M3'
        if (isUnix()) {
            sh "hostname"
            sh "ip addr | grep inet"
            sh "id"
            sh "java -version && which java"
            sh "'${mvnHome}/bin/mvn' -version"
        }
    }

    stage('Build') {
        echo "Run the maven build."
        if (isUnix()) {
            sh "'${mvnHome}/bin/mvn' clean install \
                --batch-mode \
                --debug \
                --define skipTests \
                --threads 1C \
                --update-snapshots"
        } else {
            bat(/"${mvnHome}\bin\mvn" clean install \
                --batch-mode \
                --debug \
                --define skipTests \
                --threads 1C \
                --update-snapshots /)
        }
    }

    stage('Results') {
        echo "Create and publish reporting statistics."
        if (isUnix()) {
            sh "'${mvnHome}/bin/mvn' clean install \
                org.codehaus.mojo:findbugs-maven-plugin:check pmd:pmd pmd:cpd \
                --batch-mode \
                --debug \
                --define skipTests \
                --define maven.findbugs.failOnError=false \
                --define findbugs.failOnError=false \
                --update-snapshots"
        } else {
            bat(/"${mvnHome}\bin\mvn" clean install \
                org.codehaus.mojo:findbugs-maven-plugin:check pmd:pmd pmd:cpd \
                --batch-mode \
                --debug \
                --define skipTests \
                --define maven.findbugs.failOnError=false \
                --define findbugs.failOnError=false \
                --update-snapshots /)
        }
    }

    stage('Deploy') {
        echo "Build packages and deploy them to Nexus."
        withMavenEnv(["JAVA_OPTS=-XX:MaxPermSize=1024m",
        "MAVEN_OPTS=-d64 -server \
        -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC \
        -XX:MaxPermSize=1024M -Xmx8G -Djava.awt.headless=true"]) {
            // Run the maven build.
            if (isUnix()) {
                sh "'${mvnHome}/bin/mvn' clean source:jar deploy \
                versions:use-latest-versions \
                --batch-mode \
                --debug \
                --define includes=com.nullaxiomgroup.app:* \
                --define revision=42.3-SNAPSHOT \
                --update-snapshots"
            } else {
                bat(/"${mvnHome}\bin\mvn" clean source:jar deploy \
                versions:use-latest-versions \
                --batch-mode \
                --debug \
                --define includes=com.nullaxiomgroup.app:* \
                --define revision=42.3-SNAPSHOT \
                --update-snapshots /)
            }
        }
    }
}

// This method is based on withMavenEnv function from the below link.
// https://github.com/jenkinsci/jenkins/blob/335fb4bc78253910632ca31a11f0f262676f9a1b/Jenkinsfile
//
// This method sets up the Maven and JDK tools, puts them in the environment along
// with whatever other arbitrary environment variables we passed in, and runs the
// body we passed in within that environment.
void withMavenEnv(List envVars = [], def body) {
    // The names here are currently hardcoded for my test environment. This needs
    // to be made more flexible.
    // Using the "tool" Workflow call automatically installs those tools on the
    // node.
    String mvntool = tool name: "M3", type: 'hudson.tasks.Maven$MavenInstallation'
    String jdktool = tool name: "JDK8", type: 'hudson.model.JDK'

    // Set JAVA_HOME, MAVEN_HOME and special PATH variables for the tools we're
    // using.
    List mvnEnv = [
        "PATH+MVN=${mvntool}/bin",
        "PATH+JDK=${jdktool}/bin",
        "JAVA_HOME=${jdktool}",
        "MAVEN_HOME=${mvntool}"
    ]

    // Add any additional environment variables.
    mvnEnv.addAll(envVars)

    // Invoke the body closure we're passed within the environment we've created.
    withEnv(mvnEnv) {
        body.call()
    }
}
