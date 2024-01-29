# ecs-implementation
I deploy this application on ECS with Fargate so the container will run serverless and pay as u go. Moreover, i will also challange my self to implement autoscaling inside ECS cluster 

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
#### Create ECR (Elastic Container repository)
Run this command to apply infrastructure for ECR only
```bash
 terraform plan -target=module.ecr.aws_ecr_repository.ecr
 terraform apply -target=module.ecr.aws_ecr_repository.ecr
````

 `-target` will specify a resource to be created 
#### Push image to repository
- Build image
```bash
docker build -t simple-shop-rest:1.0 ./app

```
- Get repo url from terraform output (!important)
```bash
REPO_URL=$(terraform output -raw ecr_modul_repo_url); \
```
- Manually link image to repository 
```bash
docker tag simple-shop-rest:1.0 $REPO_URL
```
- Login to aws repo
```bash
aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin $REPO_URL
```

- Push image
```bash
docker push $REPO_URL
```
