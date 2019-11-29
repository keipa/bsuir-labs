c = 8; %Число кластеров
n = 6; %Число векторов в кластере
d = .5; %Среднее отклонение от центра кластера

x = [-10 10; -5 5];
[r,q] = size(x);
minv = min(x')';
maxv = max(x')';
v = rand(r,c).*((maxv-minv)*ones(1,c)+minv*ones(1,c));
t = c*n; % число точек
v = [v v v v v v];
v = v+randn(r,t)*d; % координаты точек
P = v;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot (P(1, :), P(2, :), '+r')
hold on; 
plot (network1.IW{1}(: , 1), network1.IW{1}(: , 2) ,'ob')

data2 = [1.7; 8.7];
a = sim(network1, data2)