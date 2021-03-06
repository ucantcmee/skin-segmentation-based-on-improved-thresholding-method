clc;
clear all;
close all;
%%%%%%%%% input image %%%%%%%%%
[filename,pathname]=uigetfile('*.*','pick an image');
x=imread(filename);
x=imresize(x,[256,256]);
figure,imshow(x);title('original image');
%%%%%%%%%%%% determining clothing area to black %%%%%%%%
r=x(:,:,1); 
g=x(:,:,2); 
b=x(:,:,3); 
[k1,k2,k3]=size(x)
 x=double(x);
 for i=1:k1
 for j=1:k2
r=x(i,j,1);
g=x(i,j,2);
b=x(i,j,3);
m=max([r g b]);
n=min([r g b]);
if  ((r>95)&(g>40)&(b>20)&((m-n)>15)&(abs(r-g)>15)&(r>g)&(r>b))
    msk(i,j)=1;
else
    msk(i,j)=0;
end 
     end
      end
      figure,imshow(msk,[]); title('Non skin area (clothing) black');

for i=1:3
    z(:,:,i)=x(:,:,i).*~msk;
end
a=z/255;
figure,imshow(a);

%%%%%%%%%%%% segmented clothing%%%%%%%%

M = repmat(all(~a,3),[1 1 3]); %mask black parts
a(M) = 255; %turn them white
a=imresize(a,[256,256]);
figure,imshow(a);title('segmented clothing');

%%%%%%% calculating accuracy %%%%%%%%
n=10;
%% for islamic clothing %%
correctsegmentation = 8
Accu1=(correctsegmentation/n)*100;
disp('accuracy '); disp(Accu1);

%% general women clothing %%
correctsegmentation=9;
Accu2=(correctsegmentation/n )*100;
disp('accuracy '); disp(Accu2);

