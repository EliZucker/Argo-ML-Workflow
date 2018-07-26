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
for directory in /mnt/vol/outputdir-*;
do
    echo $directory
    if   ! ls -1qA $directory | grep -q .
        then  echo $directory IS EMPTY
        i=$((${#directory}-6))
        TOKEN=${directory:$i:6}
        if [ -d '/mnt/vol/input-'$TOKEN ]
            then echo input not deleted
            mv /mnt/vol/input-$TOKEN/* inputdir/
            cd inputdir
            for file in *; do mv "$file" "${file}".jpg; done
            cd ..
            # python run_basics.py
            python demo.py -i inputdir -o outputdir --isDlib True
            mv outputdir/* /mnt/vol/outputdir-$TOKEN
        fi
        echo input does not exist
    fi

    #TODO random generator should not generate non number letter charaters
    #if statements to see if string already exists
    
done
echo IMAGE SUCCESSFULLY COMPLETED