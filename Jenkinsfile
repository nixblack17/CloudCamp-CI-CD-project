node("docker") {
    stage("init"){
        sh """
            # Add Docker's official GPG key:
            sudo apt-get update
            sudo apt-get install ca-certificates curl
            sudo install -m 0755 -d /etc/apt/keyrings
            sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
            sudo chmod a+r /etc/apt/keyrings/docker.asc

            # Add the repository to Apt sources:
            echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
            $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
            sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
            sudo apt-get update
        """
    }
    stage("checkout"){
        checkout scm
    }

    stage("buildcontainer"){
        sh "docker build -t ghcr.io/nixblack17/CloudCamp-CI-CD-project/microService:0.0.1"
    }

    stage("login to ghcr"){
        withCredentials([usernamePassword(credentialsId: 'github-container', passwordVariable: 'CR_PAT', usernameVariable: 'USERNAME')]) {

            sh "echo $CR_PAT | docker login ghcr.io -u $USERNAME --password-stdin"
        }
    }  

    stage("push to registry"){
        sh ("docker push ghcr.io/nixblack17/CloudCamp-CI-CD-project/microService:0.0.1")
    }
}