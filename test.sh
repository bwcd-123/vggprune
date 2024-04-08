#!/bin/bash
#JSUB -q AI205009
#JSUB -gpgpu 1
#JSUB -e error/test.%J
#JSUB -o output/test.%J
source /apps/software/anaconda3/etc/profile.d/conda.sh
module load cuda/11.6
conda activate torch39
python main.py  --dir_data ../../datasets/CIFAR10  --batch-size 100  --epochs 2  --save weights/pretrain
python vggprune.py  --dir_data ../../datasets/CIFAR10  --model weights/pretrain/checkpoint_VGG16bn_l1_norm.pth.tar  --save weights/prune