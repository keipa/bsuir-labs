P = rands(2, 1000); % определение множества векторов для кластеризации
plot(P(1,:), P(2,:), '*g') % изображение множества векторов
net = newsom ([0 1; 0 1], [5 6]);
plotsom(net. iw{ 1,1}, net.layers{1}.distances); % визуализация SOM

net.trainParam.epochs = 100; % установка количества эпох
net = train(net, P) % обучение сети

plotsom(net.iw{ 1,1}, net.layers{1}.distances)
p = [0.3; 0.5]; % определение нового вектора
a = 0; % начальная установка переменной a
a = sim(net, p)
a