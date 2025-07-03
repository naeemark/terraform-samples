# Terraform Samples

Commonly used use cases to deploy the required infrastructure quickly.

---

- [Directories](#directories)
- [Developer Setup](#developer-setup)
- [Configuration](#configuration)
- [Pre-reqs](#pre-reqs)
- [Contribute](#contribution)

---

## Direcotories

- [1-ec2](./1-ec2/)
- [2-ec2-docker](./2-ec2-docker/)
- [3-rds](./3-rds/)
- [4-ec2-docker-rds](./4-ec2-docker-rds/)

### Developer Setup

To setup the project locally you need to clone this repo, from `main` branch or some latest `TAG`

cd to the required sample subdirectory

```bash
# initialize the project
$ terraform init

# to Validate
$ terraform validate

# to plan
$ terraform plan

# Apply the changes to aws cloud
$ terraform apply

# Cleanup
$ terraform destroy
```

### Configuration

- Terraform should be installed
- ⚠️ AWS Credentials should be setup as defualt profile of local machine

### Pre-reqs

- terrafom (used `Terraform v1.4.3-dev`)
- aws credentials
- VS Code

## Contribution

- Forks are always appreciated
