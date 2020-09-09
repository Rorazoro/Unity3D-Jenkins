pipeline {
  agent {
    node {
      label 'Unity-Windows'
    }

  }
  stages {
    stage('Build: StandaloneWindows64') {
      environment {
        BUILD_TARGET = 'StandaloneWindows64'
      }
      steps {
        println powershell(returnStdout: true, script: './CI/build.ps1 $env:UNITY_EXECUTABLE $env:PROJECT_PATH $env:BUILD_TARGET $env:BUILD_NAME')
      }
    }

    stage('Build: StandaloneLinux64') {
      environment {
        BUILD_TARGET = 'StandaloneLinux64'
      }
      steps {
        println powershell(returnStdout: true, script: './CI/build.ps1 $env:UNITY_EXECUTABLE $env:PROJECT_PATH $env:BUILD_TARGET $env:BUILD_NAME')
      }
    }

    stage('Build: WebGL') {
      environment {
        BUILD_TARGET = 'WebGL'
      }
      steps {
        println powershell(returnStdout: true, script: './CI/build.ps1 $env:UNITY_EXECUTABLE $env:PROJECT_PATH $env:BUILD_TARGET $env:BUILD_NAME')
      }
    }

    stage('Generate Commit Log') {
      steps {
        println powershell(returnStdout: true, script: './CI/generatenotes.ps1 $env:ARTIFACTS')
      }
    }

    stage('Archive') {
      steps {
        println powershell(returnStdout: true, script: './CI/archive.ps1 $env:PROJECT_PATH $env:ARTIFACTS')

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