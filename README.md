# Containerize_PythonWebApp

#Build Build DockerImage
docker build -t mywebapp1 .

#Create & Run Container
docker run -p 5000:5000 --name mywebapp1_container mywebapp1

#Access the Webapp
http://{localhost/yourEC2publicIP}:5000
