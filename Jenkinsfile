pipeline {
    agent any 
    tools {
        maven "maven"
    }
    stages {
        stage('') {
            steps {
                git branch: 'main', url: 'https://github.com/AsueDerick/final-devops-project.git'
            }
        }
        stage('') { 
            steps {
                sh "mvn compile" 
            }
        }
        stage('') { 
            steps {
                sh 'mvn test' 
            }
        }
        stage('') { 
            steps {
                sh 'mvn package'
            }
        }
    }
}
