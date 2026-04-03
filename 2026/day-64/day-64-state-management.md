# Day 64 - Terraform State Management

## 📊 Diagram: Local State vs Remote State

```
Local State:
Developer Machine
└── terraform.tfstate (stored locally)

Remote State:
Developer Machine
    |
    v
S3 Bucket (State Storage)
    |
    v
DynamoDB (State Locking)
```


---

## 🔄 Steps for Terraform Import

### Step 1: Define Resource
```hcl
resource "aws_s3_bucket" "nikhil_bucket" {
  bucket = "terraweek-import-test-nikhil"
}
```

### Step 2: Initialize Terraform
```bash
terraform init
```

### Step 3: Import Resource
```bash
terraform import aws_s3_bucket.nikhil_bucket terraweek-import-test-nikhil
```

### Step 4: Verify
```bash
terraform plan
```

### ✅ Result:
- Resource successfully added to Terraform state
- No infrastructure changes required

---

## ⚠️ State Drift Explanation

### What is State Drift?
State drift occurs when real infrastructure differs from Terraform state due to manual changes.

### 🧪 Real Example:
- EC2 tag in Terraform:
```hcl
Name = "TerraformInstance"
```

- Manually changed in AWS Console:
```
Name = "ManuallyChanged"
```

### 🔍 Terraform Plan Output:
```
~ Name: "ManuallyChanged" -> "TerraformInstance"
```

### ✅ Fix:
```bash
terraform apply
```

---

## 🧠 When to Use Terraform State Commands

### 🔹 terraform state mv
Use when:
- Renaming a resource
- Refactoring code

Example:
```bash
terraform state mv aws_s3_bucket.old_name aws_s3_bucket.new_name
```

---

### 🔹 terraform state rm
Use when:
- Remove resource from Terraform control
- Keep resource in AWS

Example:
```bash
terraform state rm aws_s3_bucket.logs_bucket
```

---

### 🔹 terraform import
Use when:
- Bringing existing AWS resource under Terraform

Example:
```bash
terraform import aws_s3_bucket.bucket_name my-bucket
```

---

### 🔹 terraform force-unlock
Use when:
- State is locked due to failure

Example:
```bash
terraform force-unlock <LOCK_ID>
```

---

### 🔹 terraform refresh
Use when:
- Sync state with real infrastructure

Example:
```bash
terraform refresh
```

---

## 🚀 Summary

- Remote state ensures collaboration and safety
- State locking prevents conflicts
- Drift detection is critical in production
- Always use Terraform as single source of truth
