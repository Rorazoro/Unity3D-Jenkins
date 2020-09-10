pipeline {
  agent {
    node {
      label 'Unity-Windows'
    }

  }
  parameters {
    booleanParam(name: 'BUILD_WINDOWS', defaultValue: true, description: 'If true, we will run StandaloneWindows64 build.')
    booleanParam(name: 'BUILD_LINUX', defaultValue: false, description: 'If true, we will run StandaloneLinux64 build.')
    booleanParam(name: 'BUILD_WEB', defaultValue: true, description: 'If true, we will run WebGL build.')
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

    stage('Archive') {
      steps {
        println powershell(returnStdout: true, script: './CI/archive.ps1 $env:PROJECT_PATH $env:ARTIFACTS')
        println powershell(returnStdout: true, script: './CI/generatenotes.ps1 $env:ARTIFACTS')

        println powershell(returnStdout: true, script: '''
          Move-Item -Path 'CI/release_get.sh' -Destination $env:ARTIFACTS
          Move-Item -Path 'CI/release_create.sh' -Destination $env:ARTIFACTS
          Move-Item -Path 'CI/release_delete.sh' -Destination $env:ARTIFACTS
          Move-Item -Path 'CI/release_upload.sh' -Destination $env:ARTIFACTS
        ''')

        dir("${ARTIFACTS}") {
          archiveArtifacts artifacts: '**'
        }
      }
    }

    stage('Gather Deployment Parameters') {
      steps {
        timeout(time: 60, unit: 'SECONDS') {
          script {
            def INPUT_PARAMS = input message: 'Please Provide Parameters', parameters: [
              choice(name: 'DEPLOY', choices: 'no\nyes', description: 'Choose "yes" if you want to deploy this build')
            ]
            env.DEPLOY = INPUT_PARAMS.DEPLOY
          }
        }
      }
    }

    stage('Deploy Build') {
      steps {
        script {
          env.COMMITLOG = readFile(file: 'commitlog.txt')
          env.VERSION = sh 'git describe --tags --abbrev=0'
        }

        build(job: '/RELEASE-Unity3D-Jenkins', parameters: [
          string(name: 'RELEASE_VERSION', defaultValue: env.VERSION, description: 'Version of tag for release'),
          string(name: 'RELEASE_BRANCH', defaultValue: env.BRANCH_NAME, description: 'Branch for release'),
          string(name: 'RELEASE_NAME', defaultValue: '${VERSION}-${BUILD_NUMBER}', description: 'Name for release'),
          text(name: 'RELEASE_BODY', defaultValue: env.COMMITLOG, description: 'Message body for release'),
          booleanParam(name: 'RELEASE_PRE', defaultValue: true, description: 'Prerelease flag for release')
        ])
      }
    }
  }
  environment {
    UNITY_EXECUTABLE = "D:/Program Files/Unity Editors/2020.1.4f1/Editor/Unity.exe"
    PROJECT_PATH = "${WORKSPACE}"
    BUILD_NAME = "Unity3D-Jenkins"
    ARTIFACTS = "${PROJECT_PATH}/_artifacts"
  }
}