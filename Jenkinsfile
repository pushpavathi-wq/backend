pipeline{
    agent any
    // agent {
    //     label 'agent-1'
    // }
    environment{
        appVersion = ''
        project = 'expense'
        environment = 'backend'
        ACC_ID = 491085429222

    }
    options{
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()

    }
    parameters{
        booleanParam(name: 'deploy', defaultValue: false, description: 'Toggle this value')
    }
    stages{
        stage('checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/GArunkumar999/backend.git'
            }
        }
        stage('read version'){
            steps{
                script{
                    def packageJson = readJSON file: 'package.json'
                    appVersion = packageJson.version
                    echo "Version is: $appVersion"

                }
               
            }
        }
        stage('install dependencies'){
            steps{
                script{
                    sh """
                    npm install
                    """
                }
            }
        }
        // stage('Run Sonarqube') {
        //     environment {
        //         scannerHome = tool 'sonar-scanner-7.1';
        //     }
        //     steps {
        //       withSonarQubeEnv('sonar-scanner-7.1') {
        //         sh "${scannerHome}/bin/sonar-scanner"
        //         // This is generic command works for any language
        //       }
        //     }
        // }
        // stage("Quality Gate") {
        //     steps {
        //       timeout(time: 1, unit: 'HOURS') {
        //         waitForQualityGate abortPipeline: true
        //       }
        //     }
        // } 
        // stage('build image'){
        //     steps{
        //         script{
        //             withAWS(region: 'us-east-1', credentials: 'aws-creds'){
        //             sh """
        //             aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com
        //             docker build -t ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com/${project}/${environment}:${appVersion} .
        //             docker push ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com/${project}/${environment}:${appVersion}

        //             """
        //             }
                  
        //         }
        //     }
        // }
        // stage('Trigger Deploy'){
        //     when { 
        //         expression { params.deploy }
        //     }
        //     steps{
        //         build job: 'backend-cd', parameters: [string(name: 'version', value: "${appVersion}")], wait: true
        //     }
        // }
    }
    post{
        always{
            echo "say hello always"
            deleteDir()
        }
        success{
            echo "say hello in success"
        }
        failure{
            echo "say hello in failure"
        }
       
    }
}