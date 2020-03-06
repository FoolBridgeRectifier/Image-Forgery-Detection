img = imread("books-8.jpg");
 
%limiting size to 250 to reduce processing time
size=250;
img=imresize(img,[size,size]);
 
s=15;
d=10;
imggray=rgb2gray(img);
imgx=zeros([size,size]);
imgy=zeros([size,size]);
ii=size;
jj=size;
disp("1");
% creating strength matrices in x and y direction
for i = 1:size
    jj=size;
    for j=1:size
        xp=0;
        xn=0;
        yp=0;
        yn=0;
        flagxp=1;
        flagxn=1;
        flagyp=1;
        flagyn=1;
        while(flagxp ||flagyp ||flagxn ||flagyn )
            if(xp+i<size&&flagxp)
                a1=abs(abs(img(xp+i,j,1)-img(xp+i+1,j,1))-abs(img(xp+i,j,2)-img(xp+i+1,j,2)))<s;
                a2=abs(abs(img(xp+i,j,1)-img(xp+i+1,j,1))-abs(img(xp+i,j,3)-img(xp+i+1,j,3)))<s;
                a3=abs(abs(img(xp+i,j,3)-img(xp+i+1,j,3))-abs(img(xp+i,j,2)-img(xp+i+1,j,2)))<s;
                b1=abs(img(xp+i,j,1)-img(xp+i+1,j,1))>d;
                b2=abs(img(xp+i,j,2)-img(xp+i+1,j,2))>d;
                b3=abs(img(xp+i,j,3)-img(xp+i+1,j,3))>d;
                if(a1&&a2&&a3&&b1&&b2&&b3&&flagxp==1)
                    flagxp=2;
                    xp=xp+1;
                elseif(a1&&a2&&a3&&flagxp==2)
                    xp=xp+1;
                else
                    flagxp=0;
                end
            else
                flagxp=0;
            end
            
            if(yp+j<size&&flagyp)
                a1=abs(abs(img(i,yp+j,1)-img(i,yp+j+1,1))-abs(img(i,yp+j,2)-img(i,yp+j+1,2)))<s;
                a2=abs(abs(img(i,yp+j,1)-img(i,yp+j+1,1))-abs(img(i,yp+j,3)-img(i,yp+j+1,3)))<s;
                a3=abs(abs(img(i,yp+j,3)-img(i,yp+j+1,3))-abs(img(i,yp+j,2)-img(i,yp+j+1,2)))<s;
                b1=abs(img(i,yp+j,1)-img(i,yp+j+1,1))>d;
                b2=abs(img(i,yp+j,2)-img(i,yp+j+1,2))>d;
                b3=abs(img(i,yp+j,3)-img(i,yp+j+1,3))>d;
                if(a1&&a2&&a3&&b1&&b2&&b3&&flagyp==1)
                    flagyp=2;
                    yp=yp+1;
                elseif(a1&&a2&&a3&&flagyp==2)
                    yp=yp+1;
                else
                    flagyp=0;
                end
            else
                flagyp=0;
            end
            
          
            if(xn+ii>1&&flagxn)
                a1=abs(abs(img(xn+ii,j,1)-img(xn+ii-1,j,1))-abs(img(xn+ii,j,2)-img(xn+ii-1,j,2)))<s;
                a2=abs(abs(img(xn+ii,j,1)-img(xn+ii-1,j,1))-abs(img(xn+ii,j,3)-img(xn+ii-1,j,3)))<s;
                a3=abs(abs(img(xn+ii,j,3)-img(xn+ii-1,j,3))-abs(img(xn+ii,j,2)-img(xn+ii-1,j,2)))<s;
                b1=abs(img(xn+ii,j,1)-img(xn+ii-1,j,1))>d;
                b2=abs(img(xn+ii,j,2)-img(xn+ii-1,j,2))>d;
                b3=abs(img(xn+ii,j,3)-img(xn+ii-1,j,3))>d;
                if(a1&&a2&&a3&&b1&&b2&&b3&&flagxn==1)
                    flagxn=2;
                    xn=xn-1;
                elseif(a1&&a2&&a3&&flagxn==2)
                    xn=xn-1;
                else
                    flagxn=0;
                end
            else
                flagxn=0;
            end
            
            if(yn+jj>1&&flagyn)
                a1=abs(abs(img(i,yn+jj,1)-img(i,yn+jj-1,1))-abs(img(i,yn+jj,2)-img(i,yn+jj-1,2)))<s;
                a2=abs(abs(img(i,yn+jj,1)-img(i,yn+jj-1,1))-abs(img(i,yn+jj,3)-img(i,yn+jj-1,3)))<s;
                a3=abs(abs(img(i,yn+jj,3)-img(i,yn+jj-1,3))-abs(img(i,yn+jj,2)-img(i,yn+jj-1,2)))<s;
                b1=abs(img(i,yn+jj,1)-img(i,yn+jj-1,1))>d;
                b2=abs(img(i,yn+jj,2)-img(i,yn+jj-1,2))>d;
                b3=abs(img(i,yn+jj,3)-img(i,yn+jj-1,3))>d;
                if(a1&&a2&&a3&&b1&&b2&&b3&&flagyn==1)
                    flagyn=2;
                    yn=yn-1;
                elseif(a1&&a2&&a3&&flagyn==2)
                    yn=yn-1;
                else
                    flagyn=0;
                end
            else
                flagyn=0;
            end
            
            
        end
        imgy(i,j)=imgy(i,j)+yp;
        imgx(i,j)=imgx(i,j)+yp;
        imgx(ii,j)=imgx(ii,j)+xn;
        imgy(i,jj)=imgy(i,jj)+yn;
        jj=jj-1;
    end
    ii=ii-1;
end
imga=zeros([size,size]);
%calculating angle of shadows
disp("2");
for i=1:size
    for j=1:size
        if(abs(imgy(i,j))~=0)
            imga(i,j)=180*atan(abs(imgx(i,j))/abs(imgy(i,j)))/pi;
            if(imgy(i,j)>0)
                imga(i,j)=imga(i,j)+0.001;
            end
        elseif(abs(imgx(i,j))>0)
            imga(i,j)=90;
        end
    end
end
% calculating number of shadows facing the same direction
imgcn=zeros([size,size]);
disp("3");
for i=1:size
    for j=i:size
        disp(i)
        disp(j)
        if(imga(i,j)>0)
            for x=1:size
                for y=1:size
                    if(abs(img(i,j)-img(x,y))<10&&imgx(i,j)*imgx(x,y)>0&&imgy(i,j)*imgy(x,y)>0)
                        imgcn(x,y)=imgcn(x,y)+1;
                        imgcn(i,j)=imgcn(i,j)+1;
                    end
                end
            end
        end
    end
end
%Higlighting the ponts of interest
disp("4");
imgcp=img;
for i=1:size
    for j=1:size
        disp(i)
        disp(j)
        if(imgcn(i,j)==min(imgcn(imgcn > 0)))
            imgcp(i,j,:)=[255 0 0];
            for w=i-5:i+5
                for h=j-5:j+5
                    if(w>0&&w<size&&h>0&&h<size)
                        imgcp(w,h,:)=[255 0 0];
                    end
                end
            end
        end
    end
end
%outputing the results
subplot(1,6,1);
imshow(img);
subplot(1,6,2);
imshow(imgx,[]);
subplot(1,6,3);
imshow(imgy,[]);
subplot(1,6,4);
imshow(imga,[]);
subplot(1,6,5);
imshow(imgcn,[]);
subplot(1,6,6);
imshow(imgcp);
 
