[alphabet,targets] = prprob;
for i = 1:26
letter{i} =  reshape(alphabet(:, i), 5, 7)';
end;
net = newhop(letter);
[Y,Pf,Af] = sim(net, letter);

noisyZ = alphabet(:,26) + randn(35,1) *0.1;
[Y,Pf,Af] = sim(net,5,[],reshape(noisyZ, 5, 7)');
plotchar(reshape(Y', 1, 35)');

noisyK = alphabet(:,11) + randn(35,1) *0.1;
[Y,Pf,Af] = sim(net,5,[],reshape(noisyK, 5, 7)');
plotchar(reshape(Y', 1, 35)');

noisyD = alphabet(:,4) + randn(35,1) *0.4;
plotchar(noisyD)
