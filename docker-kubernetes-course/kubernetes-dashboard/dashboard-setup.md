# Docker Desktop's Kubernetes Dashboard

If you are using Docker Desktop's built-in Kubernetes, setting up the admin dashboard is going to take a little more work.

1. Grab the kubectl script we need to apply from the GitHub repository: https://github.com/kubernetes/dashboard

2. We will need to download the config file locally so we can edit it (make sure you are copying the most current version from the repo).

  If on Mac or using GitBash on Windows enter the following:
```
curl -O https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta1/aio/deploy/recommended.yaml
```
and copy to kubernetes-dashboard.yaml
```
cp recommended.yaml kubernetes-dashboard.yaml
```

3. Run the following command inside the directory where you downloaded the dashboard yaml file a few steps ago:
```
kubectl apply -f kubernetes-dashboard.yaml
```
4. Start the server by running the following command:
```
kubectl proxy
```
3. Get a token
```
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')
```
6. You can now access the dashboard by visiting:
```
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
```
and use your token to sign in
7. You will be presented with a login screen:

8. Click the "SKIP" link next to the SIGN IN button.

9. You should now be redirected to the Kubernetes Dashboard:

Important! The only reason we are bypassing RBAC Authorization to access the Kubernetes Dashboard is because we are running our cluster locally. You would never do this on a public facing server like Digital Ocean and would need to refer to the official docs to get the dashboard setup:
https://github.com/kubernetes/dashboard/wiki/Access-control
