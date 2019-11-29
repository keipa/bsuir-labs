%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3.1 %%%%%%%%%%%%%%%%%%%%%%%%%%
net1 = newff([-1 1;-1 1],[5,1],{'tansig','purelin'},'traingd');
gensim(net1)
net1.biases{1,1}.learnFcn='learngd';
net1.biases{2,1}.learnFcn='learngd';
net1.layerWeights{2,1}.learnFcn='learngd';
net1.inputWeights{1,1}.learnFcn='learngd';
net1.layerWeights{2,1}.learnParam.lr = 0.2;
x=-1:0.1:1;
y=x;
p=[x;y];
p=num2cell(p,1);
t=sin(x.^2)./cos(y.^2);
t=num2cell(t,1);
net1.adaptParam.passes=300;
tic, [net1, a, e]=adapt(net1, p, t); toc
a=sim(net1, p)
mse(e)
[x,y]=meshgrid(x,y);
z=sin(x.^2)./cos(y.^2);
surf(x,y,z)
a=cat(1,a{:});
[a]=meshgrid(a);
surf(x,y,a)