function randcomb=quasirandom

mode=[1 2]; % 1 if visual, 2 if tactile
lat=[-1 1]; % 1 if right, -1 if left
orient=[0 90 180 270];
side=[-1 1]; % -1 if palm, 1 if back
comb=CombVec(mode,lat,orient,side);
randcomb=[comb(:,randperm(size(comb,2)))];

while 1
    
    for i=3:length(randcomb(1,:))
        if randcomb(1,i)==randcomb(1,i-1) && randcomb(1,i)==randcomb(1,i-2)
            signal(i)=1;
        else
            signal(i)=0;
        end
    end
    
    if nnz(signal)>0
        randcomb=comb(:,randperm(size(comb,2)));
    else
        break
    end
    
end

