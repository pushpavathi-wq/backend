pipeline {
    agent { label 'AGENT-1' }
    environment { 
        PROJECT = 'expense'
        COMPONENT = 'backend' 
        appVersion = ''
        ACC_ID = '491085429222'
        // DEPLOY_TO = "production"
    }
    options {
        disableConcurrentBuilds() 
        timeout(time: 30, unit: 'MINUTES')
    }
    // parameters{
    //    /*  string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
    //     text(name: 'BIOGRAPHY', defaultValue: '', description: 'Enter some information about the person')
    //     booleanParam(name: 'TOGGLE', defaultValue: true, description: 'Toggle this value')
    //     choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')
    //     password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password') */
    // }
    stages {
        stage('Read Version') {
            steps {
               script{
                 def packageJson = readJSON file: "package.json"
                 appVersion = packageJson.version
                 echo "Version is: $appVersion"
               }
            }
        }
        
     
    
        stage('Install Dependencies') {
            steps {
                script {
                    sh """
                        npm install
                    """    
                }

            }
        }

        stage('Docker Build') {
            steps {
                script {
                    withAWS(region: 'us-east-1', credentials: 'aws-creds') {
                        sh """
                        aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com
                        docker build -t  ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com/${project}/${component}:${appVersion} .

                        docker push ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com/${project}/${component}:${appVersion}
                        
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
    }    
    
            
    
    post { 
        always { 
            echo 'I will always say Hello again!'
            deleteDir()
        }
        failure { 
            echo 'I will run when pipeline is failed'
        }
        success { 
            echo 'I will run when pipeline is success'
        }
    }
  
}