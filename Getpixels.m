function [tile_pixels_x] = Getpixels(num_pixels_x, num_tiles_x)
tile_pixels_x = zeros(3);
if mod(num_pixels_x, num_tiles_x) == 0
    % 若能整除
    tile_pixels_x = num_pixels_x/num_tiles_x;
 
else 
    % 若不能整除，则将余数分配给两边的图片
    tile_pixels_x(2) = floor(num_pixels_x/num_tiles_x);
    remain = mod(num_pixels_x, num_tiles_x);
    if mod(remain,2) ==0
        tile_pixels_x(1) =  tile_pixels_x(2) + remain/2;
        tile_pixels_x(3) = tile_pixels_x(2) + remain/2;
    else
        tile_pixels_x(1) = tile_pixels_x(2) + floor(remain/2);
        tile_pixels_x(3) = tile_pixels_x(2) + floor(remain/2) + 1;
    end
end
end