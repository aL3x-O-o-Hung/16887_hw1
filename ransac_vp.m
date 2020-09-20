function vp=ransac_vp(lines,iterations,threshold_inliers)
loc=[(lines(:,1)+lines(:,2))/2,(lines(:,3)+lines(:,4))/2];
dir=[lines(:,2)-lines(:,1),lines(:,4)-lines(:,3)];
vp=0;
best_votes=zeros(size(loc,1),1);
while iterations>0
    ind1=randi([1,size(loc,1)],1,1);
    ind2=randi([1,size(loc,1)],1,1);
    while ind2==ind1
        ind2=randi([1,size(loc,1)],1,1);
    end
    [a1,b1,c1]=get_line_para(lines(ind1,1),lines(ind1,2),lines(ind1,3),lines(ind1,4));
    [a2,b2,c2]=get_line_para(lines(ind2,1),lines(ind2,2),lines(ind2,3),lines(ind2,4));
    l1=[a1,b1,c1];
    l2=[a2,b2,c2];
    vp_temp=cross(l1,l2);
    if  vp_temp(3)==0
        iterations=iterations-1;
        continue
    end
    votes=get_votes(lines,vp_temp,threshold_inliers,0.5);
    if sum(votes)>sum(best_votes)
        best_votes=votes;
        vp=vp_temp;
    end
    
    iterations=iterations-1;

end
