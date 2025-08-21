A **Terraform module** is like a reusable building block for your infrastructure. It’s a way to organize and encapsulate Terraform configuration so you can **reuse**, **share**, and **scale** your infrastructure code more efficiently.

---

## 🧱 What Is a Terraform Module?

A **module** is simply a **collection of `.tf` files** (Terraform configuration files) grouped together in a directory. Every Terraform project is technically a module — even if it’s just one file.

There are two types:

- **Root Module**: The main directory where you run Terraform commands.
- **Child Module**: A module called from another module (usually the root).

---

## 🎯 Why Use Modules?

Modules help you:

- **Avoid repetition**: Write once, use many times.
- **Improve readability**: Break complex setups into logical parts.
- **Enable collaboration**: Teams can work on isolated modules.
- **Enforce standards**: Use consistent naming, tagging, and security policies.

---

## 📦 Example of a Module

Let’s say you want to create an EC2 instance. You can write a module like this:

### Folder structure:
```
modules/
└── ec2_instance/
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
```

### `main.tf` (inside the module):
```hcl
resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type
}
```

### `variables.tf`:
```hcl
variable "ami" {}
variable "instance_type" {}
```

### `outputs.tf`:
```hcl
output "instance_id" {
  value = aws_instance.example.id
}
```

### Using the module in your root configuration:
```hcl
module "my_ec2" {
  source        = "./modules/ec2_instance"
  ami           = "ami-0abcdef1234567890"
  instance_type = "t2.micro"
}
```

---

## 🌍 Remote Modules

You can also use modules from the [Terraform Registry](https://registry.terraform.io) or GitHub:

```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.5.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"
  ...
}
```

---

## ✅ Best Practices

- Keep modules **small and focused**.
- Use **input variables** and **outputs** to make them flexible.
- Document your modules with a `README.md`.
- Version control your modules for stability.

---

Want help creating your first module or converting a messy config into modular form? I’d love to help you architect it!
