# Argo-Workflow-Test
An Argo Workflow that takes in a photo, scans it for faces and produces a 3D obj rendering for each face detected. Our project uses **Ageitgey's** [face_recognition](https://github.com/ageitgey/face_recognition) to detect individual faces within a photo, **YadiaraF's** [PRNet](https://github.com/YadiraF/PRNet) to create a 3D Face Reconstruction, and various other bash commands inside of Ubuntu and Debian containers for most of the other pods. This project uses various new Argo Workflow features such as *conditional deployments, parallelism, custom resources, and loops*. Our project also utilizes kubeflow and tensorflow in order to run PRNet. PRNet uses CUDA which requires access to a GPU (We use the NVIDIA Tesla P100). In order to run our workflow at high performance we used a GKE cluster.

## Getting Started

### Prerequisites
In order to run our project you must have the following installed.

+ Argo
```
argo version
argo: v2.1.1
  BuildDate: 2018-05-29T20:38:37Z
  GitCommit: ac241c95c13f08e868cd6f5ee32c9ce273e239ff
  GitTreeState: clean
  GitTag: v2.1.1
  GoVersion: go1.9.3
  Compiler: gc
  Platform: darwin/amd64
```

+ Kubectl
```
kubectl version
Client Version: version.Info{Major:"1", Minor:"11", GitVersion:"v1.11.0", GitCommit:"91e7b4fd31fcd3d5f436da26c980becec37ceefe", GitTreeState:"clean", BuildDate:"2018-06-27T22:29:25Z", GoVersion:"go1.10.3", Compiler:"gc", Platform:"darwin/amd64"}
Server Version: version.Info{Major:"1", Minor:"10+", GitVersion:"v1.10.5-gke.3", GitCommit:"6265b9797fc8680c8395abeab12c1e3bad14069a", GitTreeState:"clean", BuildDate:"2018-07-19T23:02:51Z", GoVersion:"go1.9.3b4", Compiler:"gc", Platform:"linux/amd64"}
```

+ Kubeflow (reauires ks)
further instructions for deploying kubeflow [here](KUBEFLOW.md)

### Deploy Our Project
```
git clone https://github.com/EliZucker/Argo-Workflow-Test
cd Argo-Workflow-Test
argo submit demo.yaml -p img-url="yourimagehere.jpg"
```