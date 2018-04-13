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
| [demo_data_app](https://github.com/wave-ami/demo_data_app)                |  1  |  3rd  |
| redis                       |  3   |  1st  |



In Sequence:
0. base k8s cluster deployment
1. redis deployment
2. data app node frontend data construct deployment
