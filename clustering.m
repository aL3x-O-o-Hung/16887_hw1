function cluster=clustering(lines,k)
lines=normalize_angle(lines);
ii=1;
for i=0:pi/k:pi-0.01
    centers(ii)=i;
    ii=ii+1;
end
while(1)
    temp_centers=centers;
    cluster={[]};
    cluster_angle={[]};
    for i=2:k
        cluster{i,:}=[];
        cluster_angle{i,:}=[];
    end
    for i=1:size(lines,1)
        minn=10;
        min_index=-1;
        for j=1:k
            dist=angle_distance(lines(i,5),centers(j));
            if dist<minn
                minn=dist;
                min_index=j;
            end
        end
        cluster{min_index,1}(end+1)=i;
        cluster_angle{min_index,1}(end+1)=lines(i,5);
    end
    summ=0;
    for i=1:k
        centers(i)=angle_average(cluster_angle{i,1});
        summ=summ+angle_distance(centers(i),temp_centers(i));
    end
    centers
    if summ<pi/180
        break
    end
    
end
end
