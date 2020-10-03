%FEATURE = 'tiny image';
FEATURE = 'bag of sift';
%FEATURE = 'placeholder';

CLASSIFIER = 'nearest neighbor';
%CLASSIFIER = 'support vector machine';
%CLASSIFIER = 'placeholder';

data_path = '...\proj3\data\'; 

categories = {'Kitchen', 'Store', 'Bedroom', 'LivingRoom', 'Office', ...
       'Industrial', 'Suburb', 'InsideCity', 'TallBuilding', 'Street', ...
       'Highway', 'OpenCountry', 'Coast', 'Mountain', 'Forest'};
   
abbr_categories = {'Kit', 'Sto', 'Bed', 'Liv', 'Off', 'Ind', 'Sub', ...
    'Cty', 'Bld', 'St', 'HW', 'OC', 'Cst', 'Mnt', 'For'};
    
num_train_per_cat = 100; 

fprintf('Getting paths and labels for all train and test data\n')
[train_image_paths, test_image_paths, train_labels, test_labels] = ...
    get_image_paths(data_path, categories, num_train_per_cat);
         
fprintf('Using %s representation for images\n', FEATURE)

switch lower(FEATURE)    
    case 'tiny image'
     
        train_image_feats = get_tiny_images(train_image_paths);
        test_image_feats  = get_tiny_images(test_image_paths);
        
    case 'bag of sift'
        
        if exist('vocab.mat', 'file')
            fprintf('calculating train_image_feats\n');
            vocab_size=600;
            vocab=build_vocabulary(train_image_paths, vocab_size);
            save('vocab.mat','vocab');
        end
        train_image_feats = get_bags_of_sifts(train_image_paths);
        test_image_feats  = get_bags_of_sifts(test_image_paths);   
     
    case 'placeholder'
        train_image_feats = [];
        test_image_feats = [];
        
    otherwise
        error('Unknown feature type')
end

fprintf('Using %s classifier to predict test set categories\n', CLASSIFIER)

switch lower(CLASSIFIER)    
    case 'nearest neighbor'
        
        predicted_categories = nearest_neighbor_classify(train_image_feats, train_labels, test_image_feats);
        
    case 'support vector machine'
        
        predicted_categories = svm_classify(train_image_feats, train_labels, test_image_feats);
        
    case 'placeholder'
        
        random_permutation = randperm(length(test_labels));
        predicted_categories = test_labels(random_permutation); 
        
    otherwise
        error('Unknown classifier type')
end
create_results_webpage( train_image_paths, ...
                        test_image_paths, ...
                        train_labels, ...
                        test_labels, ...
                        categories, ...
                        abbr_categories, ...
                        predicted_categories)
