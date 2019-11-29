P = [.1 .8 .1 .9; .2 .9 .1 .8]; % дл€ обучени€ сло€;
angels=0 : 0.5 +pi/99 : 0.5*pi;
p=[sin(angels); cos(angels)];
plot(P(1, 1:10:end), P(2, 1:10:end), '-r')
hold on
net=newsom([0 1 ;0 1], [10]);
net.trainparam.epochs=2000;
net.trainparam.show=100;
[net,tr]=train(net,P);
plotsom(net.iw{1,1}, net.layers{1}.distances)
figure(2)
a=sim(net,P) % Ц моделирование на обучающем

% множестве и построение
% столбцовой диаграммы.
a=sim(net,[1;0])