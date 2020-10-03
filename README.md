# Scene-Recognition-with-Bag-of-Words（基于词袋模型的场景识别）


##### 1 实验目的

使用了两种特征提取算法（Tiny images feature和Bag of sift）及两种分类算法（k-Nearest Neighbor和SVM）进行场景识别。

- Tiny + Nearest Neighbor
- Tiny + SVM
- Bags of SIFT + Nearest Neighbor
- Bags of SIFT+SVM

##### 2 代码结构与功能

- 主函数：project3.m
- Tiny images feature 特征提取：get_tiny_images.m
- Bag of SIFT特征提取：
  - build_vocabulary.m 实现词袋中标准词汇的选择
  - get_bags_of_sifts.m 实现词袋模型的构建

- k-Nearest Neighbor分类器：nearest_neighbor_classify.m
- SVM分类器：svm_classify.m
- 获取图片路径：get_image_paths.m
- 将结果呈现成webpage形式：create_results_webpage.m

##### 3 运行方法

1. 将train文件夹内每个场景的图片数据分别解压并保存到train文件夹，test文件夹同理
2. 将train和test文件夹都放到data文件夹中
3. 所有代码放到matlab/bin中
4. 修改project3.m中图片路径data_path为data文件夹的位置
5. 运行project3.m文件即可
6. 通过修改project3.m中以下代码，以选择不同的特征提取方法和分类器方法

```
%FEATURE = 'tiny image';
FEATURE = 'bag of sift';
%FEATURE = 'placeholder';

CLASSIFIER = 'nearest neighbor';
%CLASSIFIER = 'support vector machine';
%CLASSIFIER = 'placeholder';
```



##### 4 实验原理&运行效果

详见project3-report.pdf文件

 ![image](https://github.com/cheerryy/Scene-Recognition-with-Bag-of-Words/blob/main/1.png)

 ![image](https://github.com/cheerryy/Scene-Recognition-with-Bag-of-Words/blob/main/2.png)
