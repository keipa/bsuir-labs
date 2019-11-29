P = [.2 .5 .1 .8; .3 .7 .2 .6];

net = newc ([0 1; 0 1], 2); % создание соперничающего слоя
net = train (net, P); % обучение соперничающего слоя на векторе Р

Y = sim (net, P)
Yc = vec2ind(Y)
cla reset;

P = [-1.2 -0.5 1.4 2.6 9.5 2.8 7.1 2.6 0.2 2.6 -1.5 8.1 6.2 7.2 3.5 -0.8 3.4 1.6 8.3 5.0 6.7 1.7 -0.1 3.3 4.1 8.8 -2.6 8.3 4.2 8.2;
    3.3 2.6 2.6 2.7 1.6 -1.3 -0.6 -2.2 6.4 7.7 2.8 3.9 -0.2 0.9 2.8 4.6 7.5 3.2 -1.4 3.3 1.0 4.9 4.8 5.4 1.3 1.5 3.7 -1.3 -1.4 1.9
    ]
plot(P(1,:), P(2,:), '*g');
title('Input vectors');
xlabel('P(1,:)');
ylabel('P(2,:)');
hold on;
nclusters = 6;
a1 = -3;
a2 = 10;
b1 = -3;
b2 = 9;
net = newc([a1 a2; b1 b2], nclusters, 0.1, 0.0005);
wo = net.IW{1};
bo = net.b{1};
net.trainParam.epochs=100;
net.trainParam.show=20;
net = train(net,P);
w = net.IW{1};
bn = net.b{1};
plot(w(:,1),w(:,2),'kp');