# Deploying Kubeflow

Guide for those looking to run Kubeflow on their Kuberenetes Cluster

## Before you start
Make sure you are running kuberentes on a machine which has a powerful enough GPU. 
_**Note: (All testing was done on a GKE with a single Tesla P100 GPU)**_

### Install ksonnet command line utility
```bash
brew install ksonnet/tap/ks
```

### Install Kubeflow
Kubeflow is required in order to deploy the custom resources that use Tensorflow: TFJobs.

To install Kubeflow run the following command:
```bash
export KUBEFLOW_VERSION=0.2.2
curl https://raw.githubusercontent.com/kubeflow/kubeflow/v$KUBEFLOW_VERSION/scripts/deploy.sh | bash
```
This command will automatically deploy a bash script which will set up a ksonnet directory called ksonnet_ks_app with all the necessary built-in packages and deploy them. To disable ks from deploying to your cluster use command `export KUBEFLOW_DEPLOY=false`

If you would like to delete an old instance of kubeflow, or delete it all together use the following commands inside the kubeflow_ks_app directory:
```bash
#If you deployed without setting KUBEFLOW_DEPLOY=false Kubeflow will automatically deploy to the default namespace
ks delete $NAMESPACE
cd ..
rm -rf kubeflow_ks_app kubeflow_repo
