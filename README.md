# base_k8s_gcp_deployment
### Basic Kubernetes Cluster Deployment (with sample apps)


   - Deployment scripts k8s cluster launch on gcp
   - k8s deployments for each node
   - json configs for various deployment scopes


> Assumes Google Cloud account and glcoud command line tool is already configured

__Usage:__
1. Clone repo
2. Launch kubernetes cluster and specify number of nodes in cluster (defaults to 3 node cluster)
    ` $ deploy_k8s.sh 5`    (specifies a 5 node cluster)
    ` $ deploy_apps.sh `    (deploys apps that are specified in app_configs.json)



***

| Application                 | Pods |  Seq  |
| --------------------------- |:----:| -----:|
| [demo_data_app](https://github.com/wave-ami/django1_k8s_gcp)                |  1  |  3rd  |
| k8s cluster                 |  3   |  1st  |
| redis                       |  3   |  2nd  |



In Sequence:
1. base k8s cluster deployment
2. redis deployment
3. data app node frontend data construct deployment
