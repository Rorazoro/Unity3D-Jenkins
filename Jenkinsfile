pipeline {
  agent {
    node {
      label 'Unity-Windows'
    }

  }
  parameters {
    booleanParam(name: 'BUILD_WINDOWS', defaultValue: true, description: 'If true, we will run StandaloneWindows64 build.')
    booleanParam(name: 'BUILD_LINUX', defaultValue: false, description: 'If true, we will run StandaloneLinux64 build.')
    booleanParam(name: 'BUILD_WEB', defaultValue: false, description: 'If true, we will run WebGL build.')
  }
  stages {
    // stage('Gather Parameters') {
    //   steps {
    //     timeout(time: 60, unit: 'SECONDS') {
    //       script {
    //         def INPUT_PARAMS = input message: 'Please Provide Parameters', parameters: [
              
    //         ]
    //         env.BUILD_WINDOWS = INPUT_PARAMS.BUILD_WINDOWS
    //         env.BUILD_LINUX = INPUT_PARAMS.BUILD_LINUX
    //         env.BUILD_WEB = INPUT_PARAMS.BUILD_WEB
    //       }
    //     }
    //   }
    // }

    stage('Build: StandaloneWindows64') {
      when {
        expression { return params.BUILD_WINDOWS ==~ /(?i)(Y|YES|T|TRUE|ON|RUN)/ }
      }
      environment {
        BUILD_TARGET = 'StandaloneWindows64'
      }
      steps {
        println powershell(returnStdout: true, script: './CI/build.ps1 $env:UNITY_EXECUTABLE $env:PROJECT_PATH $env:BUILD_TARGET $env:BUILD_NAME')
      }
    }

    stage('Build: StandaloneLinux64') {
      when {
        expression { return params.BUILD_LINUX ==~ /(?i)(Y|YES|T|TRUE|ON|RUN)/ }
      }
      environment {
        BUILD_TARGET = 'StandaloneLinux64'
      }
      steps {
        println powershell(returnStdout: true, script: './CI/build.ps1 $env:UNITY_EXECUTABLE $env:PROJECT_PATH $env:BUILD_TARGET $env:BUILD_NAME')
      }
    }

    stage('Build: WebGL') {
      when {
        expression { return params.BUILD_WEB ==~ /(?i)(Y|YES|T|TRUE|ON|RUN)/ }
      }
      environment {
        BUILD_TARGET = 'WebGL'
      }
      steps {
        println powershell(returnStdout: true, script: './CI/build.ps1 $env:UNITY_EXECUTABLE $env:PROJECT_PATH $env:BUILD_TARGET $env:BUILD_NAME')
      }
    }

    stage('Archive Builds') {
      steps {
        println powershell(returnStdout: true, script: './CI/archive.ps1 $env:PROJECT_PATH $env:ARTIFACTS')

        script {
          if (env.BRANCH_NAME == 'master') {
            println powershell(returnStdout: true, script: './CI/generatenotes.ps1 $env:ARTIFACTS')
            println powershell(returnStdout: true, script: '''
              Move-Item -Path 'CI/release_get.sh' -Destination $env:ARTIFACTS
              Move-Item -Path 'CI/release_create.sh' -Destination $env:ARTIFACTS
              Move-Item -Path 'CI/release_delete.sh' -Destination $env:ARTIFACTS
              Move-Item -Path 'CI/release_upload.sh' -Destination $env:ARTIFACTS
            ''')
          }
        }
        
        dir("${ARTIFACTS}") {
          archiveArtifacts artifacts: '**'
        }
      }
    }

    stage('Deploy?') {
      when {
        expression { env.BRANCH_NAME == "master"}
      }
      steps {
        script {
          try {
            timeout(time: 15, unit: 'MINUTES') {
              script {
                env.DEPLOY = input( message: 'Should we deploy?', parameters: [
                  booleanParam(name: 'DEPLOY', defaultValue: false, description: 'If true, we will deploy.')
                ])
              }
            }
          }
          catch(err) { // timeout reached or input Aborted
              def user = err.getCauses()[0].getUser()
                  if('SYSTEM' == user.toString()) { // SYSTEM means timeout
                      echo ("Input timeout expired, default action will be used: DEPLOY = false")
                  } else {
                      echo "Input aborted by: [${user}]"
                      error("Pipeline aborted by: [${user}]")
                  }
          }
        }
      }
    }

    stage('Gather Deployment Parameters') {
      when {
        expression { return env.DEPLOY ==~ /(?i)(Y|YES|T|TRUE|ON|RUN)/ }
      }
      steps {
        script {
          try {
            timeout(time: 15, unit: 'MINUTES') {
              script {
                env.VERSION = powershell(returnStdout: true, script: 'if (git tag -l) { git describe --tags --abbrev=0 }')

                def INPUT_PARAMS = input( message: 'Enter Deployment Parameters', parameters: [
                  string(name: 'RELEASE_VERSION', defaultValue: env.VERSION, description: 'Version of tag for release'),
                  string(name: 'RELEASE_NAME', defaultValue: env.BUILD_TAG, description: 'Name for release'),
                  text(name: 'RELEASE_BODY', defaultValue: new file("$ARTIFACTS/commitlog.txt").text, description: 'Message body for release'),
                  booleanParam(name: 'RELEASE_PRE', defaultValue: true, description: 'Prerelease flag for release')
                ])
                env.RELEASE_VERSION = INPUT_PARAMS.RELEASE_VERSION
                env.RELEASE_NAME = INPUT_PARAMS.RELEASE_NAME
                env.RELEASE_BODY = INPUT_PARAMS.RELEASE_BODY
                env.RELEASE_PRE = INPUT_PARAMS.RELEASE_PRE
              }
            }
          }
          catch(err) { // timeout reached or input Aborted
              def user = err.getCauses()[0].getUser()
                  if('SYSTEM' == user.toString()) { // SYSTEM means timeout
                      echo ("Input timeout expired, default parameters will be used.")
                  } else {
                      echo "Input aborted by: [${user}]"
                      error("Pipeline aborted by: [${user}]")
                  }
          }
        }
      }
    }

    stage('Deploy Build') {
      when {
        expression { return env.DEPLOY ==~ /(?i)(Y|YES|T|TRUE|ON|RUN)/ }
      }
      steps {
        build(job: 'Github_Release', propagate: false, wait: false, parameters: [
          string(name: 'OWNER', value: 'rorazoro'),
          string(name: 'REPO', value: env.GIT_URL.replaceFirst(/^.*\/([^\/]+?).git$/, '$1')),
          string(name: 'PROJECT_NAME', value: env.JOB_NAME),
          string(name: 'RELEASE_VERSION', value: env.RELEASE_VERSION),
          string(name: 'RELEASE_BRANCH', value: env.BRANCH_NAME),
          string(name: 'RELEASE_NAME', value: env.RELEASE_NAME),
          text(name: 'RELEASE_BODY', value: env.RELEASE_BODY),
          booleanParam(name: 'RELEASE_PRE', value: env.RELEASE_PRE)
        ])
      }
    }
  }
  post {
    always {
      cleanWs()
    }
  }
  environment {
    UNITY_EXECUTABLE = "D:/Program Files/Unity Editors/2020.1.5f1/Editor/Unity.exe"
    PROJECT_PATH = "${WORKSPACE}"
    BUILD_NAME = "Unity3D-Jenkins"
    ARTIFACTS = "${PROJECT_PATH}/_artifacts"
  }
}

//RELEASE PIPELINE CODE
// pipeline {
//     agent {
//         node {
//           label 'master'
//         }
//     }
//     parameters {
//         string(name: 'RELEASE_VERSION', defaultValue: "v0.1.0", description: 'Version of tag for release')
//         string(name: 'RELEASE_BRANCH', defaultValue: 'master', description: 'Branch for release')
//         string(name: 'RELEASE_NAME', defaultValue: 'v0.1.0', description: 'Name for release')
//         text(name: 'RELEASE_BODY', defaultValue: '', description: 'Message body for release')
//         booleanParam(name: 'RELEASE_PRE', defaultValue: true, description: 'Prerelease flag for release')
//     }
//     environment {
//         API_TOKEN = credentials('GithubAccessKey')
//         OWNER = 'rorazoro'
//         REPO = 'Unity3D-Jenkins'
//     }
    
//     stages {
//         stage('Copy Artifacts') {
//             steps {
//                 echo 'Copy Artifacts'
//                 script {
//                     step ([$class: 'CopyArtifact',
//                         projectName: '/BUILD-Unity3D-Jenkins/master',
//                         filter: "*",
//                         target: "${env.WORKSPACE}"]);
//                 }
//                 sh 'ls -all'
//             }
//         }
//         stage('Get Release') {
//             steps {
//                 script {
//                     def response = sh(returnStdout: true, script: "./release_get.sh ${params.RELEASE_VERSION}")
//                     def jsonObj = readJSON(text: response)
                    
//                     env.DELETE_RELEASE = false
//                     if (jsonObj.message != "Not Found") {
//                         env.RELEASE_ID = jsonObj.id
//                         env.DELETE_RELEASE = true
//                     }
//                 }
//             }
//         }
//         stage('Delete Release') {
//             when {
//                 expression { return env.DELETE_RELEASE ==~ /(?i)(Y|YES|T|TRUE|ON|RUN)/ }
//             }
//             steps {
//                 script {
//                     def response = sh(returnStdout: true, script: "./release_delete.sh ${env.RELEASE_ID}")
//                 }
//             }
//         }
//         stage('Create Release') {
//             steps {
//                 script {
//                     def response = sh(returnStdout: true, script: "./release_create.sh '${params.RELEASE_VERSION}' '${params.RELEASE_BRANCH}' '${params.RELEASE_NAME}' '${params.RELEASE_BODY}' ${params.RELEASE_PRE}")
//                     def jsonObj = readJSON(text: response)
//                     env.RELEASE_ID = jsonObj.id
//                 }
//             }
//         }
//         stage('Upload Release') {
//             steps {
//                 script {
//                     def assets = findFiles(glob: '*.zip')
//                     assets.each { file ->
//                         sh(returnStdout: true, script: "./release_upload.sh ${env.RELEASE_ID} '${file.path}'")
//                     }
//                 }
//             }
//         }
//     }
// }