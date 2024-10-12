pipeline {
    agent any
    tools {
        maven 'maven'
    }
    stages {
        stage('compile') {
            agent { label 'slave01'}
            steps {
                sh 'mvn compile'
            }
        }
        stage('Test') {
            agent { label 'slave01'}
            steps {
                sh 'mvn test'
            }
        }
        stage('Deploy') {
            steps {
                sh 'mvn package'
            }
        }
        stage('copy') {
            steps {
                ansiblePlaybook credentialsId: 'ubuntu', disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: '/var/lib/jenkins/workspace/pipeline/copy.yaml', vaultTmpPath: ''
            }
        }
        stage('ssh-connect') {
            steps {
               script {
                   sshagent(['ubuntu']) {
                withCredentials([usernamePassword(credentialsId: 'docker_hub', passwordVariable: 'PASSWORD', usernameVariable: 'USER')]) {
                  sh ''' 
                    ssh -o StrictHostKeyChecking=no ubuntu@172.31.5.69 \
                        echo "$password" | sudo -S apt-get update \
                        && echo "$password" | sudo -S apt-get install -y docker.io \
                        && echo "$password" | sudo -S usermod -aG docker ubuntu
                        && docker build -t asue1/ABCTechnologies:v1 /workspace/pipeline/Dockerfile \
                        && echo "$PASSWORD" | docker login -u "$USER" --password-stdin \
                        && docker push asue1/ABCTechnologies:v1 \
                        && docker run -d -p 8080:8080 asue1/ABCTechnologies:v1 \
                        && kubectl apply -f /workspace/pipeline/project_required_file_v2/deployment.yml \
                    '''
                }
                  } 
               }
            }
        }
    }
}
