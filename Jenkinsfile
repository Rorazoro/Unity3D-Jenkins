pipeline {
  agent {
    docker { 
      image 'gableroux/unity3d:2020.1.5f'
      args '''
        -v "$(pwd):/root/project"
      '''
    }
  }
  parameters {
    booleanParam(name: 'BUILD_WINDOWS', defaultValue: true, description: 'If true, we will run StandaloneWindows64 build.')
    booleanParam(name: 'BUILD_LINUX', defaultValue: true, description: 'If true, we will run StandaloneLinux64 build.')
    booleanParam(name: 'BUILD_WEB', defaultValue: true, description: 'If true, we will run WebGL build.')
  }
  stages {
    sh ('ls -all')
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