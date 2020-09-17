pipeline {
  agent {
    node {
      label 'Docker'
    }
  }
  parameters {
    booleanParam(name: 'BUILD_WINDOWS', defaultValue: true, description: 'If true, we will run StandaloneWindows64 build.')
    booleanParam(name: 'BUILD_LINUX', defaultValue: true, description: 'If true, we will run StandaloneLinux64 build.')
    booleanParam(name: 'BUILD_WEB', defaultValue: true, description: 'If true, we will run WebGL build.')
  }
  stages {
    stage('Docker Test') {
      steps {
        powershell ('''
          docker run -it --rm \
          -v "$(pwd):/root/project" \
          gableroux/unity3d:$UNITY_VERSION \
        ''')
      }
    }
  }
  // post {
  //   always {
  //     cleanWs()
  //   }
  // }
  environment {
    UNITY_VERSION = '2020.1.5f1'
    PROJECT_PATH = "${WORKSPACE}"
    BUILD_NAME = "Unity3D-Jenkins"
    ARTIFACTS = "${PROJECT_PATH}/_artifacts"
  }
}