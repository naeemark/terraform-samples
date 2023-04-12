# EC-2 with Docker and Database on RDS [3-tier]

### Configure an EC2 and RDS

- ec2 instance along with required security group running a sample docker container in it
- has multiple docker containers to show frontend and backend
- database instance along with required security group and initial provisioning script

### Dependency

- Mysql Client is required for the execution of [init_script](./scripts/fino_cars.sql)

- Accessible on ports:
  - `22` - ssh
  - `80` - http
  - `8080` - http
  - `3306` - mysql

### Inputs

- **_Database configurations_**
- **_ec2-configuration_**

### Outputs:

- `instance_id`
- `instance_sg_id`
- `instance_ip_addr`
- `instance_url`
- `db_endpoint` - _Not Accessible publically_
- `mfe_url`
- `swagger-ui`
