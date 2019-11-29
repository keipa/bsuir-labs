x=-1:0.1:1;
y=x; 
p=[x;y]; 
p=num2cell(p,1); 
t=sin(x.^2)./cos(y.^2); 
t=num2cell(t,1);

[x,y]=meshgrid(x,y); 
z=sin(x.^2)./cos(y.^2); 
surf(x,y,z)

net = feedforwardnet(10, 'traingd');
net.biases{1,1}.learnFcn='learngd';
net.biases{2,1}.learnFcn='learngd';
net.layerWeights{2,1}.learnFcn='learngd';
net.inputWeights{1,1}.learnFcn='learngd';
net.layerWeights{2,1}.learnParam.lr = 0.2;
net.adaptParam.passes=300;
tic, net=train(net,p,t); toc


net = feedforwardnet(10, 'traingd');
net.trainParam.show = 50;
net.trainParam.lr = 0.05; 
net.trainParam.goal = 1e-005;
tic, net=train(net,p,t); toc

net = feedforwardnet(10, 'traingdm');
net.biases{1,1}.learnFcn='learngdm';
net.biases{2,1}.learnFcn='learngdm'; 
net.layerWeights{2,1}.learnFcn='learngdm'; 
net.inputWeights{1,1}.learnFcn='learngdm';
net.layerWeights{2,1}.learnParam.lr=0.2;
net.adaptParam.passes=300;
tic, net=train(net,p,t); toc

net = feedforwardnet(10, 'traingdm');
net.trainParam.epochs=1000;
net.trainParam.goal=1e-5;
net.trainParam.lr=0.05;
net.trainParam.mc =0.9;
net.trainParam.show=50;
tic, net=train(net,p,t); toc

net = feedforwardnet(10, 'trainrp');
net.trainParam.show = 10;
net.trainParam.epochs = 300; 
net.trainParam.goal = 1e-5;
tic, net=train(net,p,t); toc


