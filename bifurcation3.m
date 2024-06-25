arr_epsilon1 = [0.0005:0.00005:0.03];
arr_epsilon2 = [0.03:-0.00005:0.0005];
arr_epsilon1 = cat(2, arr_epsilon1, arr_epsilon2);
arr_AU = zeros(length(arr_epsilon1),1);

etta1=0.1;

t_end = 10000;
dt = 1;
n = fix(t_end / dt);
u2 = dt / 2;
u6 = dt / 6;

%%
Y=[-0.5 0 rand rand];
arr_Y = zeros(length(arr_epsilon1),4, n);


for i = 1:length(arr_epsilon1)
    
    epsilon1 = arr_epsilon1(1,i);
    
    for j = 1: n
        w1 = runge_neuro(0, Y,               etta1, epsilon1);
        w2 = runge_neuro(0, Y + u2 .* w1', etta1, epsilon1);
        w3 = runge_neuro(0, Y + u2 .* w2', etta1, epsilon1);
        w4 = runge_neuro(0, Y + dt .* w3',   etta1, epsilon1);
        Y = Y + u6 .* (w1' + 2 .* w2' + 2 .* w3' + w4');
        
        arr_Y(i,:, j)= Y;
    end
    Uout1 = arr_Y(i,1,:);
    arr_AU(i,1) = max(Uout1)- min(Uout1);
    
end
scatter(arr_epsilon1(1:length(arr_epsilon2)), arr_AU(1:length(arr_epsilon2)), 'b');
hold on
scatter(arr_epsilon1(length(arr_epsilon2)+1:end), arr_AU(length(arr_epsilon2)+1:end), 'r');