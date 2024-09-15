pipeline {
    agent {
        label 'slave01'
    } 
    tools {
        maven "maven"
    }
    stages {
        stage('clone repo') {
            steps {
                git branch: 'main', url: 'https://github.com/AsueDerick/final-devops-project.git'
            }
        }
        
        stage ("increment build"){
            steps{
                script{
                    
                    echo "Increment build"
                    sh "mvn build-helper:parse-version versions:set \
                    -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} versions:commit"

                    def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                    def version = matcher[0][1]
                    env.IMAGE_NAME = "$version-$BUILD_NUMBER"
                 }
            }
 }

        stage('build') { 
            steps {
                sh "mvn compile" 
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
            post {
       success {
            script {
                    // Run a shell command
                    sh '''
                    sudo apt-get update
                    chmod +x install.sh
                    ./install.sh
                    '''
                }
        }
    }
}
        
        
    }
}
