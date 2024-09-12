pipeline {
    agent any 
    tools {
        maven "maven"
    }
    stages {
        stage('Neris') {
            steps {
                git branch: 'main', url: 'https://github.com/AsueDerick/final-devops-project.git'
            }
        }
        stage('Meng') { 
            steps {
                sh "mvn compile" 
            }
        }
        stage('Golda') { 
            steps {
                sh 'mvn test' 
            }
        }
        stage('Nini') { 
            steps {
                sh 'mvn package'
            }
        }
    }
}
