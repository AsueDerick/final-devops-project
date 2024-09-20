pipeline {
    tools {
        maven 'maven'
    }
    agent any
    environment {
        SSH_CREDENTIALS_ID = 'engineer'  
        REMOTE_USER = 'ubuntu'
        REMOTE_HOST = '3.25.137.144'
        REMOTE_DIR = '/home/ubuntu'
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
                    sshagent(credentials: [SSH_CREDENTIALS_ID]) {
                        // Run SSH command
                        sh """
                        scp -o StrictHostKeyChecking=no install_tools.sh ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}
                        """
                        sh """
                       ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} "cd ${REMOTE_DIR} && echo 'Connected to Ubuntu Server!' && chmod +x install_tools.sh && ./install_tools.sh"
                        """
                    }
                }
            }
        }
    
}

    }

