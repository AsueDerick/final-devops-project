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
                ansiblePlaybook credentialsId: 'slave01', disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: '/var/lib/jenkins/workspace/pipeline/copy.yaml', vaultTmpPath: ''
            }
        }
        stage('ssh-connect') {
            steps {
               script {
                   sshagent(credentials: ['slave01'], ignoreMissing: true) {
                sh ''' 
                ssh -n -o StrictHostKeyChecking=no ubuntu@172.31.9.85 '
                cd /home/ubuntu && \
                docker build -t asue1/abctechnologies:v1 . && \
                docker push asue1/abctechnologies:v1
               '
              '''
              }
            }

            }
        }
        stage('Deploy to Kubernetes') {
    steps {
        script {
            kubeconfig(credentialsId: 'kubernetes', serverUrl: 'https://172.31.9.85:6443/') {
                sh '''
                kubectl apply -f project_required_file_v2/deployment.yml --namespace=jenkins --validate=false
                '''
            }
        }
    }
}
}
}
