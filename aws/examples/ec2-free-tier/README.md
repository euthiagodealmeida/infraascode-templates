# Simple Web Server Example

This example demonstrates how to create a beautiful web server using the EC2 module.

## 🌟 What it creates

- ✅ EC2 instance running Amazon Linux 2
- ✅ Apache web server with a stunning HTML page
- ✅ Security group allowing HTTP, HTTPS, and SSH
- ✅ Public IP address for web access
- ✅ Dynamic instance metadata display

## 🚀 Quick Start

1. **Copy the example configuration:**
   ```bash
   cp opentofu.tfvars.example opentofu.tfvars
   ```

2. **Edit `opentofu.tfvars` with your values:**
   ```hcl
   key_name = "your-actual-key-pair"
   instance_name = "my-awesome-server"
   ```

3. **Deploy your infrastructure:**
   ```bash
   tofu init
   tofu plan
   tofu apply
   ```

4. **Test your web server:**
   ```bash
   # Get the URL from output
   tofu output web_server_url
   
   # Open in browser or test with curl
   curl $(tofu output -raw web_server_url)
   ```

## 📊 Outputs

After deployment, you'll get these useful outputs:

- `web_server_url`: Direct HTTP link to your web server (IP-based)
- `web_server_dns_url`: HTTP link using DNS name
- `ssh_connection`: Ready-to-use SSH command
- `instance_id`: EC2 instance identifier
- `public_ip`: Public IP address
- `private_ip`: Private IP address  
- `public_dns`: Public DNS name
- `security_group_id`: Security group identifier
- `availability_zone`: AZ where instance is running
- `instance_details`: Complete summary object with all key information

## 🎨 Features

The web page includes:
- **Modern Design**: Beautiful gradient background with glassmorphism effects
- **Live Metadata**: Displays real AWS instance information
- **Responsive Layout**: Works on desktop and mobile
- **Server Information**: Shows uptime, instance details, and more

## 💰 Cost

This example uses AWS Free Tier eligible resources:
- 1x t3.micro instance
- 20GB gp3 EBS volume
- Standard data transfer

**Estimated cost:** $0/month (within Free Tier limits)

## 🔧 Customization

You can customize the deployment by modifying variables:

```hcl
# Use a different instance type
instance_type = "t3.small"

# Deploy in a different region
aws_region = "sa-east-1"

# Add custom tags
tags = {
  Environment = "production"
  Team        = "devops"
  Cost-Center = "engineering"
}
```

## 🧪 Testing

After deployment:

1. **Web Access**: Visit the URL from `web_server_url` output
2. **SSH Access**: Use the command from `ssh_connection` output
3. **Health Check**: The page should load with instance metadata

## 🧹 Clean Up

```bash
tofu destroy
```

## 📁 File Structure

```
simple-web-server/
├── main.tf                    # Main configuration
├── variables.tf              # Input variables
├── outputs.tf               # Output values
├── user-data.sh             # Bootstrap script
├── opentofu.tfvars.example # Example configuration
└── README.md               # This file
```

## 🔗 Integration

This example demonstrates how to use the EC2 module as a building block. The module path `source = "../ec2"` points to the EC2 module at the AWS level, making it easy to integrate with other AWS modules in the future.

```
aws/
├── ec2/                        # EC2 module
├── examples/
│   └── ec2-simple-web-server/  # This example
└── [future-modules]/          # VPC, RDS, etc.
```
