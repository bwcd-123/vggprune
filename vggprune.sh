#!/bin/bash
#JSUB -q AI205009
#JSUB -gpgpu 1
#JSUB -e error/vggprune.%J
#JSUB -o output/vggprune.%J
source /apps/software/anaconda3/etc/profile.d/conda.sh
module load cuda/11.6
conda activate torch39
python vggprune.py  --dir_data ../../datasets/CIFAR10  --model weights/pretrain/checkpoint_VGG16bn_l1_norm.pth.tar  --save weights/prune