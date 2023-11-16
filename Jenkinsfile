pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh '''
                docker build -t polthomson/task1jenk .
                docker build -t polthomson/task1-nginx nginx
                '''
            }

        }
        stage('Push') {
            steps {
                sh '''
                docker push polthomson/task1jenk
                docker push polthomson/task1-nginx
                '''
            }

        }
        stage('Deploy') {
            steps {
                sh '''
                ssh jenkins@pault-deploy <<EOF
                docker network rm task1-net && echo "removed network" || echo "Network already removed"
                docker network create task1-net
                docker stop nginx && echo "Stopped nginx" || echo "nginx is not running"
                docker rm nginx && echo "removed nginx" || echo "nginx does not exist"
                docker stop flask-app && echo "Stopped flask-app" || echo "flask-app is not running"
                docker rm flask-app && echo "removed flask-app" || echo "flask-app does not exist"
                docker run -d --name flask-app --network task1-net polthomson/task1je
                docker run -d --name nginx --network task1-net -p 80:80 polthomson/task1-nginx
                '''
            }

        }

    }

}

