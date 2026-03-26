# Day 56 – StatefulSets in Kubernetes

## What are StatefulSets?

StatefulSets are used to manage stateful applications in Kubernetes.
They provide stable identities, ordered deployment, and persistent storage for each Pod.

Unlike Deployments, Pods in a StatefulSet are not identical. Each Pod has:
- A stable name (e.g., app-0, app-1)
- A stable network identity
- Its own persistent storage

---

## When to Use StatefulSets vs Deployments

Use StatefulSets when your application requires:
- Stable network identity
- Persistent storage per Pod
- Ordered startup and shutdown
- Data consistency between restarts

Common use cases:
- Databases (MySQL, PostgreSQL, MongoDB)
- Distributed systems (Kafka, Zookeeper)
- Applications requiring leader election

Use Deployments when:
- Pods are stateless
- Any Pod can handle any request
- No need for stable identity or storage

---

## StatefulSets vs Deployments

| Feature | Deployment | StatefulSet |
|--------|-----------|-------------|
| Pod Identity | Random | Stable (fixed names) |
| Pod Ordering | No guarantee | Ordered (sequential) |
| Storage | Shared or none | Dedicated per Pod |
| Scaling | Parallel | Sequential |
| Network Identity | Dynamic | Stable DNS |
| Use Case | Stateless apps | Stateful apps |

---

## Headless Services

A Headless Service is used with StatefulSets to provide stable network identities.

It is created by setting:
clusterIP: None

This allows direct access to individual Pods instead of load balancing.

Example DNS:
- app-0.service-name
- app-1.service-name

Each Pod gets its own DNS entry.

---

## Stable DNS

StatefulSets assign predictable DNS names to Pods.

Format:
<pod-name>.<service-name>.<namespace>.svc.cluster.local

Example:
mysql-0.mysql.default.svc.cluster.local

This allows applications to communicate reliably with specific Pods.

---

## volumeClaimTemplates

StatefulSets automatically create PersistentVolumeClaims for each Pod.

Each Pod gets its own storage:
- app-0 → pvc-app-0
- app-1 → pvc-app-1

Example snippet:
volumeClaimTemplates:
- metadata:
    name: data
  spec:
    accessModes: ["ReadWriteOnce"]
    resources:
      requests:
        storage: 1Gi

Key points:
- Storage is not shared between Pods
- Data persists even if Pod is recreated
- Each Pod keeps its own data

---

## Key Takeaways

- StatefulSets are for stateful applications requiring stable identity and storage
- Deployments are for stateless, scalable applications
- Headless Services provide direct Pod access
- Stable DNS enables predictable communication
- volumeClaimTemplates ensure persistent storage per Pod

---

## Summary

StatefulSets are essential for running databases and distributed systems in Kubernetes.
They ensure consistency, persistence, and reliable networking, which are critical for stateful workloads.
