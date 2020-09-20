addpath 'code/hedauvp/'
myDir='images/';
myDir2='extracredits/';
myDir3=strcat(myDir,myDir2);
myFiles=dir(fullfile(myDir3,'*.jpg'));
for ii=1:size(myFiles,1)
    name=strcat(myDir2,myFiles(ii).name(1:end-4));
%name='input/P1020871';
    im=imread(strcat(myDir,name,'.jpg'));
    im=im(11:end-10,11:end-10,:);
    [vp linemem p All_lines]=getVPHedauRaw(im);
    vp=[vp(1),vp(2);vp(3),vp(4);vp(5),vp(6)];
    im=rgb2gray(im);
    for i=1:3
        min_x=floor(min(vp(i,1),0)-50);
        min_y=floor(min(vp(i,2),0)-50);
        max_x=ceil(max(vp(i,1),size(im,2))+50);
        max_y=ceil(max(vp(i,2),size(im,1))+50);
        figure(i),hold off, image([min_x,max_x],[min_y,max_y],ones(max_x-min_x,max_y-min_y,3))
        figure(i),hold on,imshow(im)
        if i==1
            color='r';
        elseif i==2
            color='g';
        else
            color='b';
        end
        for j=1:size(All_lines,1)
            if linemem(j)==i
                figure(i),hold on, plot(All_lines(j, [1 2])', All_lines(j, [3 4])',color)
            end
        end
        figure(i),hold on, scatter(vp(i,1),vp(i,2),400,'x',color)
        %saveas(figure(i),strcat('res/',name,'_',num2str(i),'.png'))
        print(figure(i),strcat('res/',name,'_',num2str(i),'_.png'),'-dpng','-r300');
    end
    min_x=floor(min(min(vp(:,1)),0)-50);
    min_y=floor(min(min(vp(:,2)),0)-50);
    max_x=ceil(max(max(vp(:,1)),size(im,2))+50);
    max_y=ceil(max(max(vp(:,2)),size(im,1))+50);
    figure(4),hold off, image([min_x,max_x],[min_y,max_y],ones(max_x-min_x,max_y-min_y,3))
    figure(4),hold on,imshow(im)
    color=['r','g','b','y'];
    for j=1:size(All_lines,1)
        figure(4),hold on, plot(All_lines(j, [1 2])', All_lines(j, [3 4])',color(linemem(j)))
    end
    for i=1:3
        figure(4),hold on, scatter(vp(i,1),vp(i,2),400,'x',color(i))
    end
    %saveas(figure(i),strcat('res/',name,'_',num2str(i),'.png'))
    print(figure(4),strcat('res/',name,'_',num2str(4),'_.png'),'-dpng','-r300');
    figure(5),hold off, imshow(im)
    for j=1:size(All_lines,1)
        figure(5),hold on, plot(All_lines(j, [1 2])', All_lines(j, [3 4])',color(linemem(j)))
    end
    print(figure(5),strcat('res/',name,'_',num2str(5),'_.png'),'-dpng','-r300');
    
    
end