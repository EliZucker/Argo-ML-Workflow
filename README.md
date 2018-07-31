# Argo-Workflow-Test
An Argo Workflow that takes in a photo, scans it for faces and produces a 3D obj rendering for each face detected. Our project uses **Ageitgey's** [face_recognition](https://github.com/ageitgey/face_recognition) to detect individual faces within a photo, **YadiaraF's** [PRNet](https://github.com/YadiraF/PRNet) to create a 3D Face Reconstruction, and various other bash commands inside of Ubuntu and Debian containers for most of the other pods. This project uses various new Argo Workflow features such as *conditional deployments, parallelism, custom resources, and loops*. Our project also utilizes kubeflow and tensorflow in order to run PRNet. PRNet uses CUDA which requires access to a GPU (We use the NVIDIA Tesla P100). In order to run our workflow at high performance we used a GKE cluster.

## Getting Started

```
git clone https://github.com/EliZucker/Argo-Workflow-Test
cd Argo-Workflow-Test
argo submit demo.yaml -p img-url="yourimagehere.jpg"
```