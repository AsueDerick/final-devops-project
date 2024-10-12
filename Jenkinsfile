pipeline {
    agent any
    stages {
        stage('compile') {
            agent { label 'slave01'}
            steps {
                ssh 'compile'
            }
        }
        stage('Test') {
            agent { label 'slave01'}
            steps {
                ssh 'test'
            }
        }
        stage('Deploy') {
            steps {
                ssh 'package'
            }
        }
    }
}
