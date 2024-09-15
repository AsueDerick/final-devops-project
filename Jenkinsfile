pipeline {
    agent {
        label 'slave01' // Use the appropriate label for your Jenkins agent
    }
    
    tools {
        maven "maven" // Specify the Maven version to use
    }
    
    environment {
        IMAGE_NAME = '' // Initialize the environment variable for the image name
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/AsueDerick/final-devops-project.git'
            }
        }
        
        stage('Increment Version') {
            steps {
                script {
                    echo 'Incrementing application version...'
                    sh 'mvn versions:set' // Auto-increment version based on POM configuration
                    def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                    def version = matcher[0][1]
                    env.IMAGE_NAME = "$version-$BUILD_NUMBER"
                    echo "Updated version: $env.IMAGE_NAME"
                }
            }
        }

        stage('Build') { 
            steps {
                sh 'mvn compile'
            }
        }

        stage('Test') { 
            steps {
                sh 'mvn test'
            }
        }

        stage('Package') { 
            steps {
                sh 'mvn package'
            }
        }
    }

    post {
        always {
            echo "Build completed. Final artifact version: $env.IMAGE_NAME"
        }
    }
}
