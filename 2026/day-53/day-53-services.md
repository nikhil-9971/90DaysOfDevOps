# 📘 Day 53 – Kubernetes Services

## 🔹 1. What Problem Services Solve

In Kubernetes, Pods are ephemeral:
- Pods can be created and destroyed anytime
- Their IP addresses keep changing

👉 Problem:
How do applications reliably communicate with Pods?

### ✅ Solution: Services

A Service provides:
- A stable IP (ClusterIP)
- A fixed DNS name
- Load balancing across Pods

---

## 🔗 Relationship: Pods, Deployments, Services

Deployment → manages Pods  
Service → exposes Pods  

- Deployment ensures desired number of Pods
- Service provides stable access to those Pods

---

## 🔹 2. Service Manifests

### ✅ ClusterIP Service

apiVersion: v1  
kind: Service  
metadata:  
  name: web-app-clusterip  
spec:  
  type: ClusterIP  
  selector:  
    app: web-app  
  ports:  
    - port: 80  
      targetPort: 80  

---

### ✅ NodePort Service

apiVersion: v1  
kind: Service  
metadata:  
  name: web-app-nodeport  
spec:  
  type: NodePort  
  selector:  
    app: web-app  
  ports:  
    - port: 80  
      targetPort: 80  
      nodePort: 30080  

---

### ✅ LoadBalancer Service

apiVersion: v1  
kind: Service  
metadata:  
  name: web-app-loadbalancer  
spec:  
  type: LoadBalancer  
  selector:  
    app: web-app  
  ports:  
    - port: 80  
      targetPort: 80  

---

## 🔹 3. Difference: ClusterIP vs NodePort vs LoadBalancer

| Feature | ClusterIP | NodePort | LoadBalancer |
|--------|----------|----------|--------------|
| Access | Internal | External (Node IP) | External (Public IP) |
| Use case | Microservices | Testing | Production |
| Port | Internal | 30000–32767 | Cloud-managed |

---

## 🔹 4. Kubernetes DNS

Format:
<service-name>.<namespace>.svc.cluster.local

Example:
web-app-clusterip.default.svc.cluster.local

Usage:
- Same namespace → http://web-app-clusterip
- Different namespace → full DNS name

---

## 🔹 5. Endpoints

Endpoints = actual Pod IPs behind a Service

Check:
kubectl get endpoints web-app-clusterip

Example:
web-app-clusterip   10.244.0.5:80,10.244.0.6:80

---

## 🔧 Inspect Endpoints

kubectl get endpoints  
kubectl describe service web-app-clusterip  

---

## 🚀 Summary

- Pods are dynamic → Services provide stability  
- DNS enables service discovery  
- Endpoints show real Pod IPs  
- ClusterIP → internal  
- NodePort → external (node level)  
- LoadBalancer → external (cloud)  
