function boxsum = ComputeBoxSum(ii_im, x, y, w, h)
%           x <- w ->
%   __________________
%   |inter  | up      |
% y |_______|_________|
%   |       |         |
% h |left   | boxsum  |
%   |_______|_________|
%
% We compute the sum of the box with :
% boxsum = area_of_the_whole_box + inter - up - left
left = 0;
up = 0;
inter = 0;
if y ~= 1
    up = ii_im(y-1,x+w-1);
end
if x ~= 1
    left = ii_im(y+h-1, x-1);
end
if x ~= 1 && y ~= 1
    inter = ii_im(y-1, x-1);
end
boxsum = ii_im(y+h-1, x+w-1) + inter - up - left;
