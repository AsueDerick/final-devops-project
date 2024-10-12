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
                withCredentials([usernamePassword(credentialsId: 'docker_hub', passwordVariable: 'password', usernameVariable: 'user')]) {
                  sh ''' 
                    ssh -o StrictHostKeyChecking=no ubuntu@172.31.5.69 \
                        && sudo apt-get update -y \
                        && sudo apt-get install -y docker.io \
                        && sudo usermod -aG docker ubuntu \
                        && docker build -t asue1/ABCTechnologies:v1 /workspace/pipeline/Dockerfile \
                        && echo "$pass" | docker login -u "$user" --password-stdin \
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
