# Build and start Docker image

```
sudo systemctl start docker
sudo docker build -t example-docker-app .
sudo docker run --rm -p 3838:3838 example-docker-app
```
