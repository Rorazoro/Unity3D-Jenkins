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
        println "$env:UNITY_LICENSE_CONTENT"
      }
    }
    stage('Build: StandaloneWindows64') {
      when {
        expression { return params.BUILD_WINDOWS ==~ /(?i)(Y|YES|T|TRUE|ON|RUN)/ }
      }
      environment {
        BUILD_TARGET = 'StandaloneWindows64'
      }
      steps {
        println powershell(returnStdout: true, script: './CI/docker_build.ps1 $env:BUILD_NAME $env:UNITY_LICENSE_CONTENT $env:BUILD_TARGET $env:IMAGE_NAME')
      }
    }
  }
  // post {
  //   always {
  //     cleanWs()
  //   }
  // }
  environment {
    IMAGE_NAME = 'gableroux/unity3d:2020.1.5f1'
    UNITY_LICENSE_CONTENT = credentials('UnityLicense')
    PROJECT_PATH = "${WORKSPACE}"
    BUILD_NAME = "Unity3D-Jenkins"
    ARTIFACTS = "${PROJECT_PATH}/_artifacts"
  }
}