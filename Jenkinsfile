def ssh_publisher(SERVER_CONFIG) {
    sshPublisher(
            continueOnError: false,
            failOnError: true,
            publishers:[
                    sshPublisherDesc(
                            configName: "${SERVER_CONFIG}",
                            verbose: true,
                            transfers: [
                                    // (5.1) Copy script files
                                    sshTransfer(
                                            sourceFiles: "deploy/script/deploy_server.sh",
                                            removePrefix: "deploy/script",
                                            remoteDirectory: "/data1/build/script"
                                    ),
                                    // (5.2) Copy build files
                                    sshTransfer(
                                            sourceFiles: "build/libs/*.jar",
                                            removePrefix: "build/libs",
                                            remoteDirectory: "/data1/build/lib",
                                            // Absolute path.
                                            execCommand: "sh /data1/build/script/deploy_server.sh"
                                    ),
                                    // (5.3) Health check
//                                    sshTransfer(
//                                            // Absolute path.
//                                            execCommand: "sh /home/build/script/health_check.sh"
//                                    )
                            ]
                    )
            ]
    )
} // (1) 
pipeline {
    environment {
        // (2) Registered in Jenkins 
        SERVER_LIST = "dev1"
    }

    agent any

    stages {

        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }
        stage("Build") {
            // (3) 
            steps {
                sh "mvn clean package"
                // sh 'WORK="/var/lib/jenkins/workspace"'
                // sh "mv $WORK/$JOB_NAME/target/sa-front-4.0.0.war $WORK/$JOB_NAME/target/ROOT.war"

            }
        }
//        stage("Deploy") {
//
//            steps {
//                echo "deploy.."
//                echo "${SERVER_LIST}"
//
//                script {
//                    // (4)
//                    SERVER_LIST.tokenize(',').each {
//                        echo "SERVER: ${it}"
//                        ssh_publisher("${it}")
//                    }
//                }
//            }
//        }
    }
}
