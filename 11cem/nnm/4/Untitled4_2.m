a = 0;
b = 10;
for i = 1:100
P(i) = (b-a).*rand(1,1) + a;
T(i) = log(P(i))*sin(P(i));
end;

net = newff([0 10],[20,1],{'tansig','purelin'},'trainbr');
net.performFcn = 'sse';
net.trainParam.goal = 0.01;
net.trainParam.epochs = 1000;
[net,tr] = train(net, P, T);

for i = 1:100
P(i) = (b-a).*rand(1,1) + a;
T(i) = log(P(i))*sin(P(i));
end;

y = sim(net, P);
[m,b,r] = postreg(y(1,:),T(1,:));

test = 7
sim(net, test)
