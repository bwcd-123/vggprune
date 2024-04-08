#!/bin/bash
#JSUB -q AI205009
#JSUB -gpgpu 1
#JSUB -e error/test.%J
#JSUB -o output/test.%J
source /apps/software/anaconda3/etc/profile.d/conda.sh
module load cuda/11.6
conda activate torch39
python main.py  --dir_data ../datasets/CIFAR10  --batch-size 10000  --test-batch-size 10000  --log-interval 1  --save weights/pretrain
python vggprune.py  --dir_data ../datasets/CIFAR10  --model weights/pretrain/checkpoint_VGG16bn_l1_norm.pth.tar  --save weights/prune
python main_finetune.py  --dir_data ../datasets/CIFAR10  --refine weights/prune/pruned.pth.tar  --batch-size 10000  --test-batch-size 10000  --log-interval 1  --save weights/finetune
python test.py  --dir_data ../datasets/CIFAR10  --test-batch-size 10000  --baseline weights/pretrain/checkpoint_VGG16bn_l1_norm.pth.tar  --pruned weights/prune/pruned.pth.tar  --finetune weights/finetune/finetune_checkpoint.pth.tar