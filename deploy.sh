#!/bin/bash
apt-get update -y
apt-get install -y git vim sudo wget man gawk libgoogle-glog-dev libboost-all-dev python-numpy python-matplotlib cmake build-essential
echo "INSTALLING PIP"
mkdir -p ~/pip/
wget -O ~/pip/install.py https://bootstrap.pypa.io/get-pip.py
python ~/pip/install.py
rm -r ~/pip
pip install visvis imageio dlib
git clone https://github.com/YadiraF/PRNet
pip install -U scikit-image
cd PRNet/Data/net-data
#import minio
curl -SO https://dl.minio.io/client/mc/release/linux-amd64/mc
chmod +x mc
mv mc /usr/local/bin/mc
export AWS_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
mc config host add bucketport http://argo-artifacts-minio.default:9000 $AWS_ACCESS_KEY $AWS_SECRET_KEY
mc cp bucketport/3dfacebucket/256_256_resfcn256_weight.data-00000-of-00001 256_256_resfcn256_weight.data-00000-of-00001
cd ..
cd ..
mkdir inputdir
mkdir outputdir
cd inputdir
curl -o zach.jpg http://www.hairfunk.net/wp-content/uploads/2018/03/zac-efron-hairstyles-in-2018-zac-efron-hairstyles-48-fprznkv-14.jpg
curl -o obama.jpg https://freebeacon.com/wp-content/uploads/2017/03/obama-face-1.jpg
curl -o sarah.jpg https://s.newsweek.com/sites/www.newsweek.com/files/styles/lg/public/2011/05/01/1337256000000.cached_11.jpg
cd ..
python run_basics.py
python demo.py -i inputdir -o outputdir --isDlib True
mc cp -r /notebooks/PRNet/outputdir bucketport/3dfacebucket/

