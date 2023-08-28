# Deploying Nginx Web Server on Digital Ocean kubernetes cluster
This is a test repository that spins up a Digital Ocean kubernetes cluster via terraform, create DNS entries, load balancer, and deploy nginx server.



## Installation
Create a digital ocean account and generate an API token. After that, add it as a variable value for digitalocean_token on variables.tf or staging.tfvars

Once that is set, run the following commands.

```bash
make init
```

Edit the terraform/staging.tfvars file as necessary.

To create your infrastructure, run the following:

```bash
make plan
make apply
```

To destroy the infrastructure, run the following:
```bash
make destroy
```