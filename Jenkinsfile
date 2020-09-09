pipeline {
  agent {
    node {
      label 'Unity-Windows'
    }

  }
  stages {
    stage('Gather Parameters') {
      timeout(time: 60, unit: 'SECONDS') {
        script {
          def INPUT_PARAMS = input message: 'Please Provide Parameters', parameters: [
            booleanParam(name: 'BUILD_WINDOWS', defaultValue: true, description: 'If true, we will run StandaloneWindows64 build.'),
            booleanParam(name: 'BUILD_LINUX', defaultValue: true, description: 'If true, we will run StandaloneLinux64 build.'),
            booleanParam(name: 'BUILD_WEB', defaultValue: true, description: 'If true, we will run WebGL build.')
          ]
          env.BUILD_WINDOWS = INPUT_PARAMS.BUILD_WINDOWS
          env.BUILD_LINUX = INPUT_PARAMS.BUILD_LINUX
          env.BUILD_WEB = INPUT_PARAMS.BUILD_WEB
        }
      }
    }

    stage('Build: StandaloneWindows64') {
      when {
        expression { env.BUILD_WINDOWS == true }
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
        expression { env.BUILD_LINUX == true }
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
        expression { env.BUILD_WEB == true }
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

  }
  environment {
    UNITY_EXECUTABLE = "D:/Program Files/Unity Editors/2020.1.4f1/Editor/Unity.exe"
    PROJECT_PATH = "${WORKSPACE}"
    BUILD_NAME = "Unity3D-Jenkins"
    ARTIFACTS = "${PROJECT_PATH}/_artifacts"
  }
}