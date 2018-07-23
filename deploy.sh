#!/bin/bash

git clone https://github.com/YadiraF/PRNet
cd PRNet/Data/net-data
curl -o 256_256_resfcn256_weight.data-00000-of-00001 https://github.com/EliZucker/Argo-Workflow-Test/blob/master/256_256_resfcn256_weight.data-00000-of-00001?raw=true -L
cd ..
cd ..
mkdir inputdir
mkdir outputdir
cd inputdir
curl -o muka.jpg https://github.com/EliZucker/Argo-Workflow-Test/blob/master/muka.jpg
cd ..
python run_basics.py
python demo.py -i inputdir -o outputdir --isDlib True