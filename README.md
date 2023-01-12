# Terraform Implementation for BankApi.

This will create all the neccesaty infrastructure for running the BankApi app on AWS, including:
* VPC (and all associated resources such as subnets, security groups, etc)
* EKS Cluster
* Load Balancer and Ingress Controller
* Auto Scaling Groups

The [EKS Blueprint](https://github.com/aws-ia/terraform-aws-eks-blueprints) was used to bootstrap the cluster with basic operators such as:
* ArgoCD
* NGINX Ingress Controller
* cert-manager
* cluster-autoscaler

ArgoCD will handle the Continous Deployment by deplying the [application charts](https://github.com/pimliprentiss/bankapi-argo-registry).

---
Deploying

Configure your AWS credentials by adding them to the credentials file on the .aws folder on your home directory.
The credentials file should look like this
```
aws_access_key_id = $ACCESS_KEY 
aws_secret_access_key = $SECRET_ACCESS_KEY
```
Replace variables with your actual credentials.

You also need to configure awscli tool. See the [Official Docs](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

---
Running Terraform commands

Test your environment by running 
```
terraform plan
```

Deploy your environment by running 
```
terraform apply
```

When the cluster is no longer needed you can tear it down by runnin
```
terraform destroy
```
