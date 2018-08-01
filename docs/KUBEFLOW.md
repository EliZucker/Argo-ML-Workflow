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
```

## Creating your own TFJob/TFService

#### This part of the tutorial is simply documentation for creating your own tensorflow application since websites like [kubeflow.org](http://kubeflow.org/docs/started/getting-started) are often hard to follow or outdated as of June, 31, 2018.

+ TFJobs

TFJobs are a Kubeflow custom resource for training tensorflow jobs on kubeflow

To create a TF Job:
```bash
ks generate tf-job-simple $JOBNAME --name=$JOBNAME
```

This will create a pre-built tf-job within a .jsonnet component inside of kubeflow_ks_app/components

Next enter the directory and open the $JOBNAME.jsonnet in your favorite text editor

```bash
cd kubeflow_ks_app/components
code $JOBENAME.jsonnet
```

```diff
-local image = "gcr.io/kubeflow/tf-benchmarks-cpu:v20171202-bdab599-dirty-284af3";

+++ image can be replaced with any image running tensorflow
+local image = "tensorflow/tensorflow:latest-gpu";

- args: [
-    "python",
-    "tf_cnn_benchmarks.py",
-    "--batch_size=32",
-    "--model=resnet50",
-    "--variable_update=parameter_server",
-    "--flush_stdout=true",
-    "--num_gpus=1",
-    "--local_parameter_device=cpu",
-    "--device=cpu",
-    "--data_format=NHWC",
-],
+command: [sh, -c],
+    args: ["
+ ===your code here===
+    "],

- workingDir: "/opt/tf-benchmarks/scripts/tf_cnn_benchmarks",
```

Depending on your knowledge of Tensorflow architecture you can deploy multiple master's workers and PS's if you are new to Tensorflow simply delete everything under PS

```diff
- Ps: {
-    template: {
-        spec: {
-        containers: [
-            {
-            args: [
-                "python",
-                "tf_cnn_benchmarks.py",
-                "--batch_size=32",
-                "--model=resnet50",
-                "--variable_update=parameter_server",
-                "--flush_stdout=true",
-                "--num_gpus=1",
-                "--local_parameter_device=cpu",
-                "--device=cpu",
-                "--data_format=NHWC",
-            ],
-            image: image,
-            name: "tensorflow",
-            workingDir: "/opt/tf-benchmarks/scripts/tf_cnn_benchmarks",
-            },
-        ],
-        restartPolicy: "OnFailure",
-        },
-    },
-    tfReplicaType: "PS",
-},
```
+ TFService

TFServices are a Kubeflow deployment for running pretrained Tensorflow services.

To deploy a TF Service:
```bash
ks generate tf-serving-simple $JOBNAME --name=$JOBNAME
```
