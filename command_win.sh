python main.py  --dir_data ../../datasets/CIFAR10  --batch-size 1000  --test-batch-size 1000  --epochs 1  --resume weights/resume/model_best.pth.tar  --log-interval 10  --save weights/pretrain
python vggprune.py  --dir_data ../../datasets/CIFAR10  --model weights/pretrain/checkpoint_VGG16bn_l1_norm.pth.tar  --save weights/prune
python main_finetune.py  --dir_data ../../datasets/CIFAR10  --refine weights/prune/pruned.pth.tar  --batch-size 1000  --test-batch-size 1000  --log-interval 10  --save weights/finetune
python test.py  --dir_data ../../datasets/CIFAR10  --test-batch-size 1000  --baseline weights/pretrain/checkpoint_VGG16bn_l1_norm.pth.tar  --pruned weights/prune/pruned.pth.tar  --finetune weights/finetune/finetune_checkpoint.pth.tar
