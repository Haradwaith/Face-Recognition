function all_ftypes = EnumAllFeatures(W, H)
all_ftypes = zeros(50000,5);
index = 1;

for w = 1:W-2
    % Height is splitted in 2 parts.
    for h = 1:floor(H/2)-2        
        for x = 2:W-w
            % y starts in 2 and it stops where h can no longer be splitted
            % in two            
            for y = 2:H-2*h
                all_ftypes(index,:) = [1,x,y,w,h];
                index=index+1;
            end
        end        
    end
end


% Width splits in 2 parts.
for w = 1:floor(W/2)-2
    for h = 1:H-2
        % x starts in 2 and it stops where w can no longer be splitted
        % in two
        for x = 2:W-2*w
            for y = 2:H-h
                all_ftypes(index,:) = [2,x,y,w,h];
                index=index+1;
            end
        end        
    end
end


% Width splits in 2 parts.
for w = 1:floor(W/3)-2
    % Height is constant.
    for h = 1:H-2
        % x starts in 2 and it stops where w can no longer be splitted
        % in two
        for x = 2:W-3*w
            % Same for y but only where h fits.
            for y = 2:H-h
                all_ftypes(index,:) = [3,x,y,w,h];
                index=index+1;
            end
        end        
    end
end

for w = 1:floor(W/2)-2
    % Height is constant.
    for h = 1:floor(H/2)-2
        % x starts in 2 and it stops where w can no longer be splitted
        % in two
        for x = 2:W-2*w
            % Same for y.
            for y = 2:H-2*h
                all_ftypes(index,:) = [4,x,y,w,h];
                index=index+1;
            end
        end        
    end
end

% Remove one to the index as it will have +1 at the last instance.
all_ftypes = all_ftypes(1:index-1,:);
end