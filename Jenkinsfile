pipeline {
    agent any

    tools {
        terraform 'terraform-12'
    }

    stages {

        stage('Checkout') {
            steps {
                // Checkout the current repository
                checkout scm
            }
        }

        stage('Set AWS Credentials') {
            steps {
                // Use AWS credentials
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    script {
                        // Export AWS credentials as environment variables
                        env.AWS_ACCESS_KEY_ID = "${AWS_ACCESS_KEY_ID}"
                        env.AWS_SECRET_ACCESS_KEY = "${AWS_SECRET_ACCESS_KEY}"
                    }
                }
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    echo "Listing files"
                    sh 'ls -lart'
                    sh 'terraform version'
                    // Initialize Terraform
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    // Create a Terraform plan using the variable file
                    sh 'terraform plan -var-file="dev.tfvars" -out=tfplan'
                }
            }
        }

        stage('User Approval for Terraform Apply') {
            steps {
                script {
                    // Prompt for user input before applying the Terraform plan
                    def userInput = input(
                        id: 'UserInput', // Unique ID for the input step
                        message: 'Do you want to apply the Terraform plan?',
                        parameters: [
                            [$class: 'BooleanParameterDefinition', name: 'Proceed', defaultValue: true, description: 'Check to proceed with Terraform apply']
                        ]
                    )
                    // Check the user input
                    if (!userInput) {
                        error('User chose not to proceed with Terraform apply.')
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Apply the Terraform plan using the variable file
                    // Use -auto-approve to skip interactive approval
                    sh 'terraform apply -var-file="dev.tfvars" -auto-approve tfplan'
                }
            }
        }
    }

    post {
        success {
            echo 'Terraform deployment completed successfully!'
        }
        failure {
            echo 'Terraform deployment failed.'
        }
    }
}