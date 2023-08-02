pipeline {
    agent any

    stages {
        stage('Remove Old Archives') {
            steps {
                sh "(cd /home/criativittawebst/analytics.criativittawebstudio.com.br; sudo rm -rf *)"
            }
        }
        stage('Clone Repositorie') {
            steps {
                sh "(cd /home/criativittawebst/analytics.criativittawebstudio.com.br; sudo git clone https://github.com/vitrcosta/analytics-report-api.git)"
                sh "(cd /home/criativittawebst/analytics.criativittawebstudio.com.br/analytics-report-api; sudo mv * ..)"
                sh "(cd /home/criativittawebst/analytics.criativittawebstudio.com.br; sudo rm -rf analytics-report-api)"
            }
        }
        stage('Stop Docker Cotnainer and Remove') {
            steps {
                sh "sudo docker kill analytics_container"
                sh "sudo docker rm analytics_container"
            }
        }
        stage('Remove Docker Image') {
            steps {
                sh "sudo docker image rm analytics_api"
            }
        }
        stage('Build Docker Image') {
            steps {
                sh "(cd /home/criativittawebst/analytics.criativittawebstudio.com.br; sudo docker build -t analytics_api --network host .)"
            }
        }
        stage ('Run Container') {
            steps {
                sh "sudo docker run --name analytics_container --network host -d analytics_api"
            }
        }
    }
}
