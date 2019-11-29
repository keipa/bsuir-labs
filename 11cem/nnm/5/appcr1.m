[alphabet, targets] = prprob;
i = 10;
ti = alphabet(:, i);
letter{i} = reshape(ti, 5, 7)';
letter{i}

[R,Q] = size(alphabet);
[S2,Q] = size(targets);

S1 = 10;

net = newff (minmax (alphabet), [S1 S2], {'logsig' 'logsig'}, 'traingdx');
net.LW{2,1} = net.LW{2,1}*0.01;
net.b{2} = net.b{2}*0.01;

gensim(net);

P = alphabet;
T = targets;

net.performFcn = 'sse'; % Sum-Squared Error performance function
net.trainParam.goal = 0.1; % Sum-squared error goal.
net.trainParam.show = 20; % Frequency of progress displays (in epochs).
net.trainParam.epochs = 5000; % Maximum number of epochs to train.
net.trainParam.mc = 0.95;
[net,tr] = train(net, P, T);

netn = net;

netn.trainParam.goal = 0.6; % предельна€ среднеквадратическа€ погрешность
netn.trainParam.epochs = 300; % максимальное количество циклов обучени€

T = [targets targets targets targets];
for pass = 1:10
P = [alphabet, alphabet, ...
(alphabet + randn(R,Q)*0.1), (alphabet + randn(R,Q)*0.2)];
[netn,tr] = train(netn,P,T);
end

netn.trainParam.goal = 0.1; % предельна€ среднеквадратична€ погрешность
netn.trainParam.epochs = 500; % максимальное количество циклов обучени€

net.trainParam.show = 5; % частота вывода результатов на экран
[netn, tr] = train(netn, P, T);

noise_range = 0:.05:.5;
max_test = 100;
network1 = [];
network2 = [];
T = targets;
for noiselevel = noise_range
fprintf('”ровень шума %.2f.\n',noiselevel);
errors1 = 0;
errors2 = 0;
for i = 1:max_test
P = alphabet + randn(35,26)*noiselevel;
% “ест дл€ сети 1
A = sim(net,P);
AA = compet(A);
errors1 = errors1+sum(sum(abs(AA-T)))/2;
% “ест дл€ сети 2
An = sim(netn,P);
AAn = compet(An);
errors2 = errors2+sum(sum(abs(AAn-T)))/2;
end
network1 = [network1 errors1/26/100]; % среднее значени€ ошибок (100тпоследовательностей из 26 векторов)
network2 = [network2 errors2/26/100]; % среднее значени€ ошибок (100 последовательностей из 26 векторов)
end

plot(noise_range,network1*100,'--',noise_range,network2*100);
title('ѕроцент ошибочных классификаций');
xlabel('”ровень шума');
ylabel('—еть 1 - - —еть 2 ---');

noisyK = alphabet(:,11) + randn(35,1) *0.2;
plotchar(noisyK);

A2 = sim(net, noisyK);
A2 = compet(A2);
answer = find(compet(A2) == 1)
plotchar(alphabet (:,answer));

noisyD = alphabet(:,4) + randn(35,1) *0.2;
plotchar(noisyD);

A2 = sim(net, noisyD);
A2 = compet(A2);
answer = find(compet(A2) == 1)
plotchar(alphabet (:,answer));
