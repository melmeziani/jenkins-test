// comment
pipeline {
 agent any
 stages {
        stage('Checkout-git'){
               steps{
		git poll: true, url: 'git@github.com:melmeziani/jenkins-test.git'
               }
        }
        stage('CreateVirtualEnv') {
            steps {
				sh '''
					bash -c "virtualenv entorno_virtual && source entorno_virtual/bin/activate"
				'''

            }
        }
        stage('InstallRequirements') {
            steps {
            	sh '''
            		bash -c "source ${WORKSPACE}/entorno_virtual/bin/activate && ${WORKSPACE}/entorno_virtual/bin/python ${WORKSPACE}/entorno_virtual/bin/pip install -r req.txt"
                '''
            }
        }   
        stage('TestApp') {
            steps {
            	sh '''
            		bash -c "source ${WORKSPACE}/entorno_virtual/bin/activate &&  cd src && ${WORKSPACE}/entorno_virtual/bin/python ${WORKSPACE}/entorno_virtual/bin/pytest && cd .."
                '''
            }
        }  
        stage('RunApp') {
            steps {
            	sh '''
            		bash -c "source entorno_virtual/bin/activate ; ${WORKSPACE}/entorno_virtual/bin/python src/main.py &"
                '''
            }
        } 
        stage('BuildDocker') {
            steps {
            	sh '''
            		docker build -t app:latest .
                '''
            }
        } 
    stage('PushDockerImage') {
            steps {
            	sh '''
            		docker tag app:latest melmeziani/app:latest
					docker push melmeziani/app:latest
					docker rmi app:latest
                '''
            }
        } 
  }
}
