// Notify to channel
def notifyTelegram(branch, version, commit, channel) {
  def DURATION = currentBuild.durationString.split(' and ')[0]
  hangoutsNotify message: "CI/CD: *${currentBuild.result}*\nService: Demo\nBranch: ${branch}\n*BuildVersion*: ${version}\nCommit: ${commit}\nDuration: ${DURATION}",
    token: "${channel}", threadByJob: true
}

def notifySlack(branch, version, commit, channel) {
  def DURATION = currentBuild.durationString.split(' and ')[0]
  def blocks = [
    [
      "type": "section",
      "text": [
        "type": "mrkdwn",
        "text": ":rocket: *Demo - #${branch}*"
      ]
    ],
      [
      "type": "divider"
    ],
    [
      "type": "section",
      "text": [
        "type": "mrkdwn",
        "text": "CI/CD: *${currentBuild.result}*\nService: Demo\nBranch: ${branch}\n*BuildVersion*: ${version}\nCommit: ${commit}\nDuration: ${DURATION}"
      ]
    ]
  ]
  slackSend(channel: "#${channel}", blocks: blocks)
}

pipeline{
  agent any

  environment { 
    registry = "tankhuuor/demo" 
    registryCredential = 'dockerhub_id' 
    dockerImage = '' 
  }

  stages {
    stage('Build on Tag') {
      when { tag pattern: "^v(\\d+\\.)?(\\d+\\.)?(\\*|\\d+)\$", comparator: "REGEXP" }
      steps {
        echo "=> Build Tag"
        script {
          env.version = "$TAG_NAME"
        }
        sh "./gradlew -Pversion=${version} build"
      }
    }
    stage('Build') {
      when { branch 'master' }
      steps {
        echo "=> Build Master"
        script {
          env.version = "${GIT_COMMIT.substring(0,7)}"
        }
        sh "./gradlew -Pversion=${version} build"
      }
    }
    stage('Package') {
      steps {
        echo "=> Dockerize tm-demo"
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage = docker.build("$registry:${version}", "--build-arg version=$version .")
            dockerImage.push()
          }
          sh "docker rmi $registry:$version"
        }
      }
    }
  }
  post {
    always {
      echo "=> Clean Workspace after run"
      // cleanWs()
    }
    success {
      echo "==> Build Success"
    }
    failure {
      echo "==> Build Failure"
    }
  }
}
