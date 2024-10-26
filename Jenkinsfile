pipeline {
    agent any
    environment {
        KUBECONFIG = credentials('kubernetes') 
    }
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
                ansiblePlaybook credentialsId: 'slave01', disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: '/var/lib/jenkins/workspace/pipeline/copy.yaml', vaultTmpPath: ''
            }
        }
        stage('ssh-connect') {
            steps {
               script {
                   sshagent(credentials: ['slave01'], ignoreMissing: true) {
                withCredentials([usernamePassword(credentialsId: 'docker_hub', passwordVariable: 'PASSWORD', usernameVariable: 'USER')]) {
                  sh ''' 
                    ssh -o StrictHostKeyChecking=no ubuntu@172.31.9.85 \
                        && sudo docker build -t asue1/abctechnologies:v1 . \
                        && echo "$PASSWORD" | docker login -u "$USER" --password-stdin \
                        && sudo docker push asue1/abctechnologies:v1 
                    '''
                }
                  } 
               }
            }
        }
        stage('Deploy to Kubernetes') {
    steps {
        script {
            kubeconfig(credentialsId: 'kubernetes', serverUrl: 'https://172.31.9.85:6443/') {
                sh '''
                kubectl apply -f project_required_file_v2/deployment.yml --namespace=default --validate=false
                '''
            }
        }
    }
}
}
}
