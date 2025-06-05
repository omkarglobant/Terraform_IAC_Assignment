pipeline {
    agent any  // This specifies that the pipeline can run on any available agent

    stages {
        stage('Hello World') {
            steps {
                script {
                    // Print "Hello, World!" to the console
                    echo 'Hello, World!'
                    sh 'terraform --version'
                }
            }
        }
    }
}