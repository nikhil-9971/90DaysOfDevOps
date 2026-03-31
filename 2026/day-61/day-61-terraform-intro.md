# Day 61 -- Terraform Introduction

## 🧠 What is Infrastructure as Code (IaC)?

Infrastructure as Code (IaC) means managing and provisioning
infrastructure using code instead of manual processes. Instead of
clicking in a console, we define resources like servers, networks, and
storage in configuration files. This makes infrastructure consistent,
repeatable, and version-controlled. It also helps teams automate
deployments and reduce human errors.



------------------------------------------------------------------------

## ⚙️ Terraform Commands Explained

### terraform init

Initializes the working directory. It downloads required providers and
sets up backend configuration.

### terraform plan

Shows what Terraform will create, update, or destroy before actually
applying changes.

### terraform apply

Executes the changes required to reach the desired state defined in the
configuration.

### terraform destroy

Deletes all resources managed by Terraform in the current configuration.

### terraform show

Displays the current state or a saved plan in a human-readable format.

### terraform state list

Lists all resources tracked in the Terraform state file.

------------------------------------------------------------------------

## 📂 Terraform State File

The state file stores the current state of infrastructure managed by
Terraform. It keeps track of resource IDs, attributes, and dependencies.
Terraform uses this file to understand what already exists and what
changes are needed. Without the state file, Terraform cannot properly
manage or update infrastructure.

------------------------------------------------------------------------

## 🚀 Summary

-   IaC allows automation and consistency in infrastructure
-   Terraform commands control the lifecycle of resources
-   State file is critical for tracking and managing infrastructure
