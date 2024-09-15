pipeline {
    agent {
        label 'slave01'
    }
    tools {
        maven 'maven'
    }
    stages {
        stage('clone repo') {
            steps {
                git branch: 'main', url: 'https://github.com/AsueDerick/final-devops-project.git'
            }
        }

        stage('Increment Version') {
            steps {
                script {
                    echo 'Incrementing app version...'

                    // Parse the version and increment it using Maven versions plugin
                    sh '''#!/bin/bash
                mvn build-helper:parse-version versions:set \
                    -DnewVersion=${parsedVersion.majorVersion}.${parsedVersion.minorVersion}.${parsedVersion.nextIncrementalVersion}-SNAPSHOT \
                    versions:commit
            '''

                    // Read the updated version from the pom.xml
                    def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                    def version = matcher[0][1]
                    env.IMAGE_NAME = "${version}-${BUILD_NUMBER}"

                    // Revert the version changes after the build
                    sh 'mvn versions:revert'
                }
            }
        }

        stage('build') {
            steps {
                sh 'mvn compile'
            }
        }
        stage('test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('package') {
            steps {
                sh 'mvn package'
            }
        }
    }
}
