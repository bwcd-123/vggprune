#!/bin/bash
#JSUB -q AI205009
#JSUB -gpgpu 1
#JSUB -e error/main.%J
#JSUB -o output/main.%J
source /apps/software/anaconda3/etc/profile.d/conda.sh
module load cuda/11.6
conda activate torch39
python main.py  --dir_data ../../datasets/CIFAR10  --batch-size 1000  --epochs 2  --log-interval 10  --save weights/pretrain