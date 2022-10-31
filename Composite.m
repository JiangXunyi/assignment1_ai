function [results] = Composite(num_pixels_x,num_pixels_y, num_tiles_x, num_tiles_y ,target_path)
% num_pixels_x, num_pixels_y: number of pixels defined by user
% num_tiles_x, num_tiles_y: number of tiles defined by user
%target_path: the targe image path

% First get the proper pixels of the source images
source_pixels_x = Getpixels(num_pixels_x,num_tiles_x);
source_pixels_y = Getpixels(num_pixels_y,num_tiles_y);

% Get the partition of target image
target = imread(target_path);
origin_pixels_x = Getpixels(size(target,2), num_tiles_x);
origin_pixels_y = Getpixels(size(target,1), num_tiles_y);

% Compare the similarity
% Using histogram comparing color
[hist_count_r, hist_bins_r] = imhist()
% for i in 1: all picture
% 在chi_squre 中传入两个矩阵即可比较（hist_bins-> chi_square）
% d = chi_squra(origin_hist_bins, other_pics)
% 有三个distance？如何处理？
% using 最小堆来保留最小的图片



end