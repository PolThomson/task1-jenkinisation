pipeline {
    agent any
    environment {
	YOUR_NAME = credentials("YOUR_NAME")
    }
    stages {
        stage('Build') {
            steps {
                sh '''
                docker build -t polthomson/task1jenk .
                '''
            }

        }
        stage('Push') {
            steps {
                sh '''
                docker push polthomson/task1jenk
                '''
            }

        }
        stage('Deploy') {
            steps {
                sh '''
                ssh jenkins@pault-deploy <<EOF
                docker network rm task1-net && echo "removed network" || echo network already removed"
                docker network create task1-net
                docker stop nginx && echo "Stopped nginx" || echo "nginx is not running"
                docker rm nginx && echo "removed nginx" || echo "nginx does not exist"
                docker stop task1 && echo "Stopped task1" || echo "task1 is not running"
                docker rm task1 && echo "removed task1" || echo "task1 does not exist"
                docker stop flask-app && echo "Stopped flask-app" || echo "flask-app is not running"
                docker rm flask-app && echo "removed flask-app" || echo "flask-app does not exist"
                docker run -d --name flask-app --network task1-net polthomson/task1jenk
                docker run -d --name nginx --network task1-net -p 80:80 polthomson/task1-nginx
                '''
            }

        }

    }

}

