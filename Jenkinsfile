pipeline {
    agent any
    tools {
        maven 'maven'
    }
    stages {
        stage('compile') {
            agent { label 'slave01'}
            steps {
                sh 'mvn compile'
            }
        }
        stage('Test') {
            agent { label 'slave01'}
            steps {
                sh 'mvn test'
            }
        }
        stage('Deploy') {
            steps {
                sh 'mvn package'
            }
        }
        stage('copy') {
            steps {
                ansiblePlaybook credentialsId: 'ubuntu', disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: 'copy.yaml', vaultTmpPath: ''
            }
        }
    }
}
