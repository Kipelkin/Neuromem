clear clc;
global etta1 epsilon1 al be w_1 w_2
etta1=0.5;
epsilon1 = 0.0009;
al=0.78;
be=1.86;
 w_1=rand;
 w_2=rand;

% интервал времени для решения задачи в микросекундах
t0=0;
tf=3000;
% значение искомых величин в момент времени 0
y0=[-0.5 0 0.001 0.001];
[T1,Y1]=ode45('FHNmod1',(t0:0.02:tf),y0);


 k = 8;
 Uout1 = Y1(:,1);
 Uout2 = Y1(:,2)*k;
 Uout3 = Y1(:,3);
 Uout4 = Y1(:,4);

 len = length(t0:0.02:tf);
 J_1 = zeros(1, len);
 J_2 = zeros(1, len);
% 
% 
   for i = 1:len
          J_1(i) = (crnt1(Uout1(i)));
          J_2(i) = 2*(crnt1(Uout2(i)));
   end


% dJ_1 = diff(J_1);
% dJ_2 = diff(J_2);
% 
% figure;
% subplot(2,1,1);
% plot(dJ_1);
% title('Производная J_1');
% subplot(2,1,2);
% plot(dJ_2);
% title('Производная J_2');


figure('NumberTitle', 'off', 'Name', '')
hold on;
plot(T1,Uout1, 'g-','LineWidth',5)
plot  (T1,Uout2, 'b-','LineWidth',5)
 xlabel('Time (ms)');
 ylabel('Voltage (V)');
 hold off;
 
%  figure('NumberTitle', 'off', 'Name', '')
% hold on;
%  plot(T1,Uout3, 'r-','LineWidth',5)
%  plot(T1,Uout4, 'y-','LineWidth',5)
%  xlabel('Time (ms)');
%  ylabel('X');
%  %legend('u','t')
%  hold off;
 
 
 figure('NumberTitle', 'off', 'Name', '')
 hold on;
 plot(Y1(:,1),Y1(:,2), 'k-','LineWidth',3)
 xlabel('V');
 ylabel('u');
 hold off;

% figure('NumberTitle', 'off', 'Name', '')
%  hold on;
%  semilogy(Uout1,J_1, 'g-')
%  xlabel('Voltage (V)');
%  ylabel('Current (A)');
% legend('memristor')
%  hold off;
%  
%  figure('NumberTitle', 'off', 'Name', '')
%  hold on;
%  semilogy(Uout2,J_2, 'r-')
%  xlabel('Voltage (V)');
%  ylabel('Current (A)');
% legend('memristor')
%  hold off;
%  
  
%  figure('NumberTitle', 'off', 'Name', '')
%  hold on;
%  semilogy(T1,J_2, 'r-')
%  xlabel('Time (ms)');
%  ylabel('Current (A)');
% legend('memristor')
%  hold off;
 
 figure('NumberTitle', 'off', 'Name', '')
 hold on;
 semilogy(T1,J_1, 'b-')
 semilogy(T1,J_2, 'r-')
 xlabel('Time (ms)');
 ylabel('Current (A)');
% legend('memristor')
 hold off;