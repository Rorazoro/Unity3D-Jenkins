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
        powershell './CI/build.ps1'
      }
    }

    stage('Build: StandaloneLinux64') {
      environment {
        BUILD_TARGET = 'StandaloneLinux64'
      }
      steps {
        powershell './CI/build.ps1'
      }
    }

    stage('Build: WebGL') {
      environment {
        BUILD_TARGET = 'WebGL'
      }
      steps {
        powershell './CI/build.ps1'
      }
    }

    stage('Generate Commit Log') {
      steps {
        powershell './CI/generatenotes.ps1'
      }
    }

    stage('Archive') {
      steps {
        powershell './CI/archive.ps1'

        powershell '''
          Move-Item -Path 'CI/release_get.sh' -Destination $ARTIFACTS
          Move-Item -Path 'CI/release_create.sh' -Destination $ARTIFACTS
          Move-Item -Path 'CI/release_delete.sh' -Destination $ARTIFACTS
          Move-Item -Path 'CI/release_upload.sh' -Destination $ARTIFACTS
        '''

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