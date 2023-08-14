# Containerize_PythonWebApp

# Build Build DockerImage
docker build -t mywebapp1 .

#  & Run Container
docker run -p 5000:5000 --name mywebapp1_container mywebapp1

# Access the Webapp
http://{localhost/your**EC2publicIP}:5000

# Tag the image
docker tag mywebapp1 yourusername/mywebapp1:latest

# Login to Docker Hub
docker login --username your-username --password your-password

# Push the image
docker push yourusername/mywebapp1:latest
