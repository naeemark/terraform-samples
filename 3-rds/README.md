# Setup Database on RDS

### Configure a database instance along with required security group and initial provisioning script

### Dependency

- Mysql Client is required for the execution of [init_script](./scripts/fino_cars.sql)

- Accessible on ports:
  - `3306` - mysql

### Inputs

- _database configurations_

### Outputs:

- `db_endpoint`
- `instance_sg_id`
