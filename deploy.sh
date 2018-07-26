git clone https://github.com/YadiraF/PRNet
cd PRNet/Data/net-data
export AWS_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
mc config host add bucketport http://argo-artifacts-minio.default:9000 $AWS_ACCESS_KEY $AWS_SECRET_KEY
mc cp bucketport/3dfacebucket/256_256_resfcn256_weight.data-00000-of-00001 256_256_resfcn256_weight.data-00000-of-00001
cd ..
cd ..
mkdir inputdir
mkdir outputdir
mv /mnt/vol/input-{{inputs.parameters.TOKEN}}/* inputdir/
cd inputdir
for file in *; do mv "$file" "${file}".jpg; done
cd ..
# python run_basics.py
python demo.py -i inputdir -o outputdir --isDlib True
mv outputdir /mnt/vol/outputdir-{{inputs.parameters.TOKEN}}
#TODO random generator should not generate non number letter charaters
#if statements to see if string already exists
echo IMAGE SUCCESSFULLY COMPLETED