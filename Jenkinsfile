pipeline {
    agent {
        label 'slave01'
    } 
    tools {
        maven "maven"
    }
    stages {
        stage('clone repo') {
            steps {
                git branch: 'main', url: 'https://github.com/AsueDerick/final-devops-project.git'
            }
        }
        stage('build') { 
            steps {
                sh "mvn compile" 
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
