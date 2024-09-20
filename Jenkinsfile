pipeline {
    tools {
        maven 'maven'
    }
    agent any
    environment {
        SSH_CREDENTIALS_ID = 'engineer'  // Set your SSH credentials ID
        REMOTE_USER = 'ubuntu'
        REMOTE_HOST = '54.252.14.191'
    }
    stages {
        stage('clone repo') {
            steps {
                git branch: 'main', url: 'https://github.com/AsueDerick/final-devops-project.git'
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

         
        stage('SSH to Ubuntu Server') {
            steps {
                script {
                    // Use sshagent with the credentials ID to initiate the SSH session
                    sshagent(credentials: [SSH_CREDENTIALS_ID]) {
                        // Run SSH command
                        sh """
                        ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} << EOF
                        echo "Connected to Ubuntu Server!" >> text.txt
                        # You can run any remote command here, e.g., deploy your app, restart services, etc.
                        exit
                        EOF
                        """
                    }
                }
            }
        }
    
}

    }

