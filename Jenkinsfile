node("docker") {
    stage("checkout"){
        checkout scm
    }

    stage("buildcontainer"){
        sh "sudo docker build -t ghcr.io/nixblack17/cloudcamp-ci-cd-project/microservice:0.0.1 ."
    }

    stage("login to ghcr"){
        withCredentials([usernamePassword(credentialsId: 'github-container', passwordVariable: 'CR_PAT', usernameVariable: 'USERNAME')]) {

            sh "echo $CR_PAT | sudo docker login ghcr.io -u $USERNAME --password-stdin"
        }
    }  

    stage("push to registry"){
        sh ("sudo docker push ghcr.io/nixblack17/cloudcamp-ci-cd-project/microservice:0.0.1")
    }
}