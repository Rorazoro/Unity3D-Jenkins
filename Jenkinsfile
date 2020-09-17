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
    // stage('Docker Test') {
    //   steps {
    //     println powershell(returnStdout: true, script: './CI/unitydocker.ps1 $env:UNITY_VERSION $env:PROJECT_PATH')
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
  }
  // post {
  //   always {
  //     cleanWs()
  //   }
  // }
  environment {
    UNITY_VERSION = '2020.1.5f1'
    UNITY_LICENSE_CONTENT = credentials('UnityLicense')
    PROJECT_PATH = "${WORKSPACE}"
    BUILD_NAME = "Unity3D-Jenkins"
    ARTIFACTS = "${PROJECT_PATH}/_artifacts"
  }
}