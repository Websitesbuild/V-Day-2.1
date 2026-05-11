pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "v-day-app:latest"
        DOCKERHUB_REPO = "your-dockerhub-username/v-day-app"
    }

    stages {

        stage('Repo Clone') {
            steps {
                git url: 'https://github.com/Websitesbuild/V-Day-2.1.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker tag ${DOCKER_IMAGE} ${DOCKERHUB_REPO}:latest
                        docker push ${DOCKERHUB_REPO}:latest
                    """
                }
            }
        }

        stage('Run Container') {
            steps {
                sh """
                    docker stop v-day-container || true
                    docker rm v-day-container || true
                    docker run -d -p 7001:80 --name v-day-container ${DOCKER_IMAGE}
                """
            }
        }

    }
}
