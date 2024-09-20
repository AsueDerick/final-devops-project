pipeline {
    tools {
        maven 'maven'
    }
    agent any
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

         stage('application installation') {
            steps {
                script {
                    sh '''
                    cd
                    ssh -i ~/.ssh/id_ed25519.pub ubuntu@172.31.12.10
                    sudo apt update -y
                    sudo apt-get install docker.io -y
                    sudo usermod -aG docker ubuntu
                    sudo service docker start
                    sudo apt-get install ansible -y

                    sudo apt-get update -y
                    cd
                    sudo curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
                    sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

                    sudo usermod -aG minikube ubuntu

                    minikube start 
                    '''
                }
            }
        }

    }
}
