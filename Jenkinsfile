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
        bat 'CI/build.bat'
      }
    }

    stage('Archive') {
      steps {
        bat 'CI/archive.bat'
      }
    }

  }
  environment {
    UNITY_EXECUTABLE = 'D:/Program Files/Unity Editors/2020.1.4f1/Editor/Unity.exe'
    PROJECT_PATH = '${WORKSPACE}'
    BUILD_NAME = 'Unity3D-Jenkins'
    ARTIFACTS = '${PROJECT_PATH}/_artifacts'
    ZIP = 'D:/Program Files/7-Zip/7z.exe'
  }
}