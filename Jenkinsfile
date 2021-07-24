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

  stages {
    stage('Build') {
      when { not { branch 'master' } }
      steps {
        echo "=> Build Version"
      }
    }
    stage('Package') {
      steps {
        echo "==> Upload Artifact to S3"
      }
    }
  }
  post {
    always {
      echo "=> Clean Workspace after run"
      cleanWs()
    }
    success {
      echo "==> Build Success"
    }
    failure {
      echo "==> Build Failure"
    }
  }
}
