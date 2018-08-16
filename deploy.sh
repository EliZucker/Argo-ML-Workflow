git clone https://github.com/YadiraF/PRNet
cd PRNet/Data/net-data

#configer minio client, REQUIRES preimported .data-00000-of-00001 file
export AWS_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
mc config host add bucketport http://argo-artifacts-minio.default:9000 $AWS_ACCESS_KEY $AWS_SECRET_KEY
mc cp bucketport/3dfacebucket/256_256_resfcn256_weight.data-00000-of-00001 256_256_resfcn256_weight.data-00000-of-00001

cd ..
cd ..
mkdir inputdir
mkdir outputdir
#big mess of bash code for checking which inputfolders exist and if their output is empty
#if output empty then run PRNET on input
#this code allows multiple people to run the workflow together

#BUG: If you delete the workflow before this finishes executing PRNET will still be executed on the previous
#input as well, slowing down the TFJOB
ls /mnt/vol/
for directory in /mnt/vol/input-*;
do
    i=$((${#directory}-6))
    TOKEN=${directory:$i:6}
    echo $directory
    if  ! ls -1qA /mnt/vol/outputdir-$TOKEN | grep -q .
        then echo /mnt/vol/outputdir-$TOKEN IS EMPTY
        if [ -d '/mnt/vol/input-'$TOKEN ]
            then echo INPUT FOLDER DOES EXIST
            mv /mnt/vol/input-$TOKEN/* inputdir/
            rm -rf /mnt/vol/input-$TOKEN/
            cd inputdir
            for file in *; do mv "$file" "${file}".jpg; done
            cd ..
            # CPU Intensive line
            #####################################################
            python demo.py -i inputdir -o outputdir --isDlib True
            #####################################################
            mv outputdir/* /mnt/vol/outputdir-$TOKEN
            else echo INPUT FOLDER DOES NOT EXIST
        fi
        else echo /mnt/vol/outputdir-$TOKEN IS NOT EMPTY
    fi
    
done
echo IMAGE SUCCESSFULLY COMPLETED