P = [0.10 0.31 0.51 0.72 0.93 1.14 1.34 1.55 1.76 1.96 2.17 2.38 2.59 2.79 3.00];
T = [0.1010 0.3365 0.6551 1.1159 1.7632 2.5847 3.4686 4.2115 4.6152 4.6095 4.2887 3.8349 3.4160 3.1388 3.0603];
net = newff([0 3],[4 1],{'tansig' 'purelin'});
gensim(net)

Y = sim(net,P); figure(1), clf
plot(P, T, P, Y, 'o'), grid on

net.trainParam.epochs = 50;
net = train(net, P, T);

Y = sim(net, P);
plot(P, T, P, Y, 'o'), grid on