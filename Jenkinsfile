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
                        && docker build -t asue1/abctechnologies:v1 . \
                        && echo "$PASSWORD" | docker login -u "$USER" --password-stdin \
                        && docker push asue1/abctechnologies:v1 \
                        && kubectl apply -f project_required_file_v2/deployment.yml --validate=false \
                    '''
                }
                  } 
               }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    kubeconfig(credentialsId: 'kubernetes', serverUrl: 'https://172.31.5.69:6443/') {
    
                       }
                    }
                }
    }
}
}
    
