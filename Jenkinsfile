pipeline {
    tools {
        maven 'maven'
    }
    agent any
    environment {
        SSH_CREDENTIALS_ID = 'engineer'  
        REMOTE_USER = 'ubuntu'
        REMOTE_HOST = '13.239.43.26'
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
                        scp -o StrictHostKeyChecking=no Dockerfile ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}
                        scp -r -o StrictHostKeyChecking=no project_required_file_v2/* ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}
                        scp -r -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/project_4/target/*-1.0.0.war ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}
                        """
                        sh """
                       ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} "cd ${REMOTE_DIR} \
                       && echo 'Connected to Ubuntu Server!' \
                       && chmod +x install_tools.sh \
                       && ./install_tools.sh" \
                       && withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                            sh "echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin"
                          }
                        """
                    }
                }
            }
        }
    
}

    }

