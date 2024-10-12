pipeline {
    agent any
    stages {
        stage('compile') {
            agent { label 'slave01'}
            steps {
                sh 'compile'
            }
        }
        stage('Test') {
            agent { label 'slave01'}
            steps {
                sh 'test'
            }
        }
        stage('Deploy') {
            steps {
                sh 'package'
            }
        }
    }
}
