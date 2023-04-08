# EC2 Instance

### Configure an EC2 instance along with required security group

- Accessible on ports:
  - `22` - ssh
  - `8080` - http

### Inputs

- `ssh_connection_key_name`

### Outputs:

- `instance_id`
- `instance_sg_id`
- `instance_ip_addr`
- `instance_url`
