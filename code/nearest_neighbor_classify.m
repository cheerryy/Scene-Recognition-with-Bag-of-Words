% Starter code prepared by James Hays for CS 143, Brown University

%This function will predict the category for every test image by finding
%the training image with most similar features. Instead of 1 nearest
%neighbor, you can vote based on k nearest neighbors which will increase
%performance (although you need to pick a reasonable value for k).

function predicted_categories = nearest_neighbor_classify(train_image_feats, train_labels, test_image_feats)
% image_feats is an N x d matrix, where d is the dimensionality of the
%  feature representation.
% train_labels is an N x 1 cell array, where each entry is a string
%  indicating the ground truth category for each training image.
% test_image_feats is an M x d matrix, where d is the dimensionality of the
%  feature representation. You can assume M = N unless you've modified the
%  starter code.
% predicted_categories is an M x 1 cell array, where each entry is a string
%  indicating the predicted category for each test image.

%{
Useful functions:
 matching_indices = strcmp(string, cell_array_of_strings)
   This can tell you which indices in train_labels match a particular
   category. Not necessary for simple one nearest neighbor classifier.

 D = vl_alldist2(X,Y) 
    http://www.vlfeat.org/matlab/vl_alldist2.html
    returns the pairwise distance matrix D of the columns of X and Y. 
    D(i,j) = sum (X(:,i) - Y(:,j)).^2
    Note that vl_feat represents points as columns vs this code (and Matlab
    in general) represents points as rows. So you probably want to use the
    transpose operator ' 
   vl_alldist2 supports different distance metrics which can influence
   performance significantly. The default distance, L2, is fine for images.
   CHI2 tends to work well for histograms.
 
  [Y,I] = MIN(X) if you're only doing 1 nearest neighbor, or
  [Y,I] = SORT(X) if you're going to be reasoning about many nearest
  neighbors 

%}
test_num = size(test_image_feats,1);%测试集数量
distances = vl_alldist2(train_image_feats', test_image_feats');%距离计算
labels = unique(train_labels);
labels_num = size(labels, 1);%类别的数目
[~, indices] = sort(distances, 1);
labels_count = zeros(labels_num, test_num);
for i = 1:test_num %计算所有测试集中每个图片距离训练集中最近的几张图片，选取其中label出现次数最多的label作为预测label
    for j = 1:labels_num
        max20_labels = train_labels(indices(1:1, i));%选取距离前20的训练集数据label进行比较
        labels_count(j,i) = sum(strcmp(labels(j), max20_labels));%查看样本前20个最近的样本中类别为labels(j)的个数
    end
end
[~, I] = max(labels_count,[],1);%选取最有可能的label
predicted_categories = labels(I);%将测试样本设置为这个label
end
