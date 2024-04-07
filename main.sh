#!/bin/bash
#JSUB -q AI205009
#JSUB -gpgpu 1
#JSUB -e error/error.%J
#JSUB -o output/output.%J
source /apps/software/anaconda3/etc/profile.d/conda.sh
module load cuda/11.6
conda activate torch39
python main.py  --dir_data ../../datasets/CIFAR10  --batch-size 100  --epochs 2  --save weights/pretrain