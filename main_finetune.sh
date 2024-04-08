#!/bin/bash
#JSUB -q AI205009
#JSUB -gpgpu 1
#JSUB -e error/main_finetune.%J
#JSUB -o output/main_finetune.%J
source /apps/software/anaconda3/etc/profile.d/conda.sh
module load cuda/11.6
conda activate torch39
python main_finetune.py  --dir_data ../datasets/CIFAR10  --refine weights/prune/pruned.pth.tar  --batch-size 1000  --test-batch-size 1000  --log-interval 10  --save weights/finetune
