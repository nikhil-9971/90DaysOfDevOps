# Day 54 – ConfigMaps & Secrets in Kubernetes

## What are ConfigMaps and Secrets?

### ConfigMaps
ConfigMaps are used to store non-sensitive configuration data in key-value pairs.

Use cases:
- Application configuration (feature flags, URLs)
- Environment-specific values
- NGINX / app config files

---

### Secrets
Secrets are used to store sensitive information such as:
- Passwords
- API keys
- Tokens
- Database credentials

Important:
Secrets are base64-encoded, not encrypted by default.

---

## When to Use Each

| Use Case | ConfigMap | Secret |
|----------|----------|--------|
| Non-sensitive data | Yes | No |
| Sensitive data (passwords, tokens) | No | Yes |
| App configs | Yes | Sometimes (if sensitive) |

---

## Environment Variables vs Volume Mounts

### Environment Variables
- Inject values into container at startup
- Example: env, envFrom
- Static — cannot update after pod starts

Best for:
- Simple key-value configs
- Small settings

Limitation:
- Requires pod restart to reflect changes

---

### Volume Mounts
- Mount ConfigMap/Secret as files inside container
- Each key becomes a file

Best for:
- Large configs (NGINX, app configs)
- Dynamic updates

Key Advantage:
- Auto-updates without restarting pod

---

## Base64: Encoding vs Encryption

- Base64 is encoding, not encryption
- Anyone with cluster access can decode it easily

Example:
echo 'czNjdXJlUEBzc3cwcmQ=' | base64 --decode

Output:
s3cureP@ssw0rd

---

## Why use Secrets then?

Even though not encrypted by default:
- RBAC controls access
- Stored separately from Pod specs
- Mounted as tmpfs (in-memory) on nodes
- Can enable encryption at rest

---

## ConfigMap Updates: Volume vs Env Behavior

### Volume Mounts
- Updates propagate automatically (30–60 seconds)
- No pod restart required

Example:
- Update ConfigMap → file inside container updates automatically

---

### Environment Variables
- Values are injected only at container startup
- Do not update dynamically

Requires:
- Pod restart or redeploy

---

## Key Takeaways

- Use ConfigMaps for non-sensitive data
- Use Secrets for sensitive data
- Prefer volume mounts for dynamic configs
- Env variables are static, volumes are dynamic
- Base64 is not secure by itself

---

## Summary

Understanding ConfigMaps and Secrets is important for:
- Secure application deployment
- Dynamic configuration management
- Real-world Kubernetes setups
