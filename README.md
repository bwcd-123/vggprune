# vggprune任务

创建vgg11网络并使用CIFAR10数据集进行训练。训练结束后，对模型进行基于L1范数的滤波器剪枝。



## Windows环境下实验

对vgg网络进行加载权重的预训练：

```shell
python main.py  --dir_data ../../datasets/CIFAR10  --batch-size 1000  --test-batch-size 1000  --epochs 1  --resume weights/resume/model_best.pth.tar  --log-interval 10  --save weights/pretrain
```

如果不加载权重，从头训练的话，删除`--resume weights/resume/model_best.pth.tar`这个参数即可。

对训练好的模型进行剪枝：

```shell
python vggprune.py  --dir_data ../../datasets/CIFAR10  --model weights/pretrain/checkpoint_VGG16bn_l1_norm.pth.tar  --save weights/prune
```

对剪枝后的模型进行微调：

```shell
python main_finetune.py  --dir_data ../../datasets/CIFAR10  --refine weights/prune/pruned.pth.tar  --batch-size 1000  --test-batch-size 1000  --log-interval 10  --save weights/finetune
```

对三种状态的模型（预训练结束、剪枝后、微调后）进行评估，并计算模型参数以及FLOPS：

```shell
python test.py  --dir_data ../../datasets/CIFAR10  --test-batch-size 1000  --baseline weights/pretrain/checkpoint_VGG16bn_l1_norm.pth.tar  --pruned weights/prune/pruned.pth.tar  --finetune weights/finetune/finetune_checkpoint.pth.tar
```



## 在西电超算环境下实验

预训练模型：

```shell
jsub < main.sh
```

模型剪枝：

```shell
jsub < prune.sh
```

剪枝后模型微调：

```shell
jsub < main_finetune.sh
```

测试：

```shell
jsub < test.sh
```



## 实验结果

| model     | Accuracy | params    | FLOPs       | size of weights(windows) |
| --------- | -------- | --------- | ----------- | ------------------------ |
| pre-train | 91.8%    | 9228362.0 | 153375744.0 | 72144KB                  |
| prune     | 68.8%    | 3325514.0 | 101427712.0 | 13020KB                  |
| finetune  | 91.1%    | 3325514.0 | 101427712.0 | 26020KB                  |



## 相关链接

1. [基于L1范数的滤波器剪枝PRUNING]: https://blog.csdn.net/w584212179/article/details/79802499	"prune"

2. [VGG网络详解]: https://blog.csdn.net/DreamBro/article/details/121068023	"VGG"



## 备注

`weights/resume/model_best.pth.tar`为VGG11的预训练权重
