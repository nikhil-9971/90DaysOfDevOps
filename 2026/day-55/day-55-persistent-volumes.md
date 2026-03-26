# Day 55 – Kubernetes Persistent Volumes

## 📦 Why Containers Need Persistent Storage

Containers are ephemeral by design. This means:
- When a container crashes or is deleted, its data is lost
- Data written inside the container filesystem does not persist

Problems without persistent storage:
- Database data gets deleted on restart
- Logs are lost
- Application state is not maintained

Solution: Persistent Storage
- Data lives outside the container
- Survives Pod restarts, rescheduling, and deletion

---

## 💾 What are PVs and PVCs?

### Persistent Volume (PV)
- A cluster-level resource
- Represents actual storage (disk, NFS, cloud storage, etc.)
- Created by admin or dynamically provisioned

Think: Actual storage (hard disk)

---

### Persistent Volume Claim (PVC)
- A request for storage by a user
- Defines storage size and access mode

Think: Request for storage

---

### Relationship Between PV and PVC

1. User creates PVC
2. Kubernetes finds matching PV
3. PV gets bound to PVC
4. Pod uses PVC to access storage

Flow:
Pod → PVC → PV → Storage

---

## ⚙️ Static vs Dynamic Provisioning

### Static Provisioning
- Admin manually creates PV
- PVC binds to existing PV

Pros:
- Full control over storage
- Simple for learning

Cons:
- Manual effort
- Not scalable

---

### Dynamic Provisioning
- No need to create PV manually
- PVC automatically creates PV using StorageClass

Pros:
- Fully automated
- Scalable
- Used in production

Cons:
- Requires StorageClass setup

---

## 🔐 Access Modes

Access modes define how a volume can be mounted

- ReadWriteOnce (RWO): Mounted as read-write by a single node
- ReadOnlyMany (ROX): Mounted as read-only by many nodes
- ReadWriteMany (RWX): Mounted as read-write by multiple nodes

---

## ♻️ Reclaim Policies

Defines what happens to PV after PVC is deleted

- Retain: Keeps data, manual cleanup required
- Delete: Deletes storage automatically
- Recycle (deprecated): Clears data and makes PV reusable

---

## 🧠 Key Takeaways

- Containers are temporary → need persistent storage
- PV = actual storage, PVC = request
- Static = manual, Dynamic = automatic
- Access modes control usage
- Reclaim policy controls data lifecycle

---

## 🚀 Final Thought

Persistent Volumes make Kubernetes stateful workloads possible:
- Databases
- File storage systems
- Stateful applications

Without PVs, Kubernetes would only be useful for stateless apps.
