# ecs-implementation
Crate simple streamline to deploy Rest Api. I deploy this application on ECS with Fargate so the container will run serverless and pay as u go. Moreover, i will also challange my self to implement autoscaling inside ECS cluster 

Notes : The main goals for this project are to explore the use of AWS ECS with Terraform for configuring persistent infrastructure. Additionally, it is better to streamline the process of deploying applications to the infrastructure."

### Requirement
- aws-cli
- docker
- docker compose

### Prerequisite
- Clone this repo
- Configure your aws-cli account
- Configure your docker account

### How to run
#### Push image to repository
- Build image
```bash
docker build -t flask-app:1.0 ./app
```
- Manually link image to repository 
```bash
docker tag flask-app:1.0 362632570762.dkr.ecr.ap-southeast-1.amazonaws.com/learn-ecs
```
- Login to aws repo
```bash
aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 362632570762.dkr.ecr.ap-southeast-1.amazonaws.com
```
- Push image
```bash
docker push 362632570762.dkr.ecr.ap-southeast-1.amazonaws.com/learn-ecs
```
