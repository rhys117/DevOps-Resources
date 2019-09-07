# Updating containers to run latest image
- has been an issue historically

Containers would not update if tag was the same (eg was using :latest) and have needed to use specific version tags eg :v2

Using Kubernetes 1.15 there is a command that resolves this problem
```
kubectl rollout restart -f client-deployment.yaml
```

If using previous Kubernetes version
```
kubectl set image <object_type>/<object name> <container_name>=<new image>

eg.
kubectl set image deployment/client-deployment client=rhys117/multi-client:v2
```
# View all running resources
```
kubectl get <resource_type>/all
```

# Apply config
```
kubectl apply -f <config file or dir containing configs>
```

# Delete running resources
```
kubectl delete <resource_type> <name>
```

# View persistent storage
View persistent volumes
```
kubectl get pv
```
View persistent claims
```
kubectl get pvc
```

# Create secret
(from literal is for use instead of file)
```
kubectl create secret generic <secret_name> --from-literal key=value
```

# Viewing secrets
```
kubectl -n kube-system get secret
kubectl -n kube-system describe secret deployment-controller-token-xkksf
```

# Delete pod
Force delete pod with no grace period
```
kubectl delete pod <PODNAME> --grace-period=0 --force --namespace <NAMESPACE>
```

# Creating a Secret via CL
Create a secret from literal (as opposed from file). Can be pased into pods as env.
```
kubectl create secret generic <secret name> --from-literal key=<value>
```
