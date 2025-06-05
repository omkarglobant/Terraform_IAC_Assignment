pipeline {
    agent any  // This specifies that the pipeline can run on any available agent

    tools {
        terraform 'terraform-latest1'
    }

    stages {
        stage('Hello World') {
            steps {
                script {
                    // Print "Hello, World!" to the console
                    echo 'Hello, World!'
                    sh 'whoami'
                    sh 'terraform version'
                    sh 'echo Hello'
                }
            }
        }
    }
}