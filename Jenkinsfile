pipeline {
    agent any 
    tools {
        maven "maven"
    }
    stages {
        stage('clone repo') {
            steps {
                git branch: 'main', url: 'https://github.com/AsueDerick/final-devops-project.git'
            }
        }
        stage('compile') { 
            steps {
                sh "mvn compile" 
            }
        }
        stage('Test') { 
            steps {
                sh 'mvn test' 
            }
        }
        stage('Deploy') { 
            steps {
                sh 'mvn package'
            }
        }
    }
}
