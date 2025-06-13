pipeline {
    agent any

    tools {
        maven '3.9.9'
        jdk '21'
    }

    options {
        timeout(time: 30, unit: 'MINUTES')
        buildDiscarder(logRotator(numToKeepStr: "5", artifactNumToKeepStr: "5"))
    }

    triggers {
        pollSCM('0 4 * * *')
    }

    environment {
        REPORT_DIR = 'target/karate-reports'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/IvanPercuklieski/SKIT-Seminarska.git', branch: 'master'
            }
        }

        stage('Run All Karate Tests') {
            steps {
                catchError(buildResult: 'UNSTABLE', stageResult: 'UNSTABLE') {
                    bat 'mvn test -Dtest=com.petstore.AllTests -Dkarate.options=classpath:karate/tests/'
                }
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: '**/target/karate-reports/*.xml'
                    publishHTML([
                            allowMissing         : false,
                            alwaysLinkToLastBuild: false,
                            keepAll              : true,
                            reportDir            : 'target/karate-reports/',
                            reportFiles          : 'karate-summary.html',
                            reportName           : 'Petstore Karate Report',
                            reportTitles         : ''])
                }
            }
        }

    }
    post {
        always {
            echo 'All Karate tests have completed. Check the report.'
        }
    }
}
