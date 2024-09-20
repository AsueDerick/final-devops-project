pipeline {
    tools {
        maven 'maven'
    }
    agent any
    environment {
        SSH_CREDENTIALS_ID = 'engineer'  // Set your SSH credentials ID
        REMOTE_USER = 'ubuntu'
        REMOTE_HOST = '54.252.14.191'
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
                    scp 
                    sshagent(credentials: [SSH_CREDENTIALS_ID]) {
                        // Run SSH command
                        sh """
                        cp -o StrictHostKeyChecking=no -r install_tools.sh ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}
                        ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} << EOF
                        echo "Connected to Ubuntu Server!" 
                        chmod +x install_tools.sh
                        ./install_tools.sh
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

