

The output.tf file in Terraform is used to define and display the key results of your infrastructure deployment,
such as IP addresses, resource IDs, or URLs, after the resources are created. 
It helps users and automation tools easily access important values without manually digging through the state file or cloud console. For example,
if you provision an EC2 instance, you can use output.
tf to automatically print its public IP address to the terminal. 
This is especially useful in CI/CD pipelines, team collaboration,
and debugging, as it provides a clean, structured way to expose essential information from your Terraform 
Here’s a simple example of an `output.tf` file in Terraform that displays the public IP address of an EC2 instance after it's created:

```hcl
output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}
```

### 🔍 What It Does:
- **`output`** is the keyword to declare an output variable.
- **`instance_public_ip`** is the name of the output.
- **`description`** helps document what this output is for.
- **`value`** pulls the actual data from the resource—in this case, the public IP of the EC2 instance named `app_server`.

After running `terraform apply`, Terraform will print this IP in the terminal, making it easy to copy, use, or pass to other tools.

Terraform **input variables** are a powerful way to make your infrastructure code flexible, reusable, and environment-agnostic. Instead of hardcoding values directly into your `.tf` files, you define variables that can be passed in during execution or loaded from external files.

---

## 🧠 What Are Input Variables?

Input variables allow you to:
- Parameterize your Terraform configuration
- Reuse modules across environments (dev, staging, prod)
- Avoid duplication and hardcoding
- Make your code easier to maintain and collaborate on

---

## 🛠️ How to Declare Input Variables

You define them using the `variable` block in a `.tf` file (often `variables.tf`):

```hcl
variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}
```

### 🔑 Key Attributes:
- `description`: Optional, but helpful for documentation
- `type`: Enforces the kind of value (e.g., `string`, `number`, `bool`, `list`, `map`, `object`)
- `default`: Optional; if omitted, the variable must be provided during execution

---

## 📥 How to Provide Values

You can pass values in several ways:
- **Command line**: `terraform apply -var="region=us-east-1"`
- **Variable file** (`.tfvars`):  
  ```hcl
  region = "us-east-1"
  ```
  Then run: `terraform apply -var-file="dev.tfvars"`
- **Environment variables**:  
  `TF_VAR_region=us-east-1`

---

## 🧪 Example Use in Configuration

```hcl
provider "aws" {
  region = var.region
}
```

Here, `var.region` references the input variable named `region`.

---

## 🧩 Advanced Types

You can use complex types like:

```hcl
variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    Owner       = "team-a"
  }
}
```

Or even objects:

```hcl
variable "server_config" {
  type = object({
    instance_type = string
    ami_id        = string
  })
}
```

---

Want help writing a full `variables.tf` and `.tfvars` setup for a real-world project like EC2 or S3? I can whip one up for you in seconds.

Want to add multiple outputs like instance ID, private IP, or DNS name? I can help you expand this file.
