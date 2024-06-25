function dy1 = FHNmod1(t1,y1)

global etta1 epsilon1 al be T t TT fs tt

dy1 = zeros(4,1);    % вектор колонка с нулевыми элементами

% % Parametts;
Fi_ion_1=1;% eV potential barrier for ion hopes
Fi_ion_2=1;
q=1.6e-19; % electron charge
k=1.38e-23; % Boltzman factor
T=300;
t=0.01;
A_1= 3.6e3*exp(1-300/T); % coeff for Ohmic current
A_2= 2.8e3*exp(1-300/T);
A_3=-1.3e3*exp(1-300/T); % coeff for Ohmic current
A_4=-4.2e3*exp(1-300/T);
B_1 = 6.5e5; % coeff for Pool-Frenkel current
B_2 = 2e4 ;
B_3 = 4.5e5;
B_4 = 1.7e4;
Vset_1 = -0.75;%0.75;
Vreset_1 = 2;%2;
Vset_2 = -1;%0.7;
Vreset_2 = 0.5;%2.5;

% %

if y1(1)>=0
    
    j_1_lin = A_1 * y1(1);
    j_1_nonlin = 1e-6 + B_1 * exp(1.7 * sqrt(y1(1)));
    
    j_2_lin=A_2*y1(1);
    j_2_nonlin= 1e-6 + B_2 * exp(0.2 * sqrt(y1(1)));
    
else
    
    j_1_lin=A_3*abs(y1(1));
    j_1_nonlin= 1e-6 + B_3 * exp(1.3 * sqrt(abs(y1(1))));
    
    j_2_lin=A_4*abs(y1(1));
    j_2_nonlin= 1e-6 + B_4 * exp(0.12*sqrt(abs(y1(1))));
    
end


    J_1 = 0.582*(y1(3)*j_1_lin+(1-y1(3))*j_1_nonlin)*1*10^(-7);
    J_2 = 0.821*(y1(4)*j_2_lin+(1-y1(4))*j_2_nonlin)*8.4*10^(-7);
    J=J_1 + J_2;


    
    
    dy1(1) = J-y1(2);

if y1(1)<0
    dy1(2) = epsilon1*(al*y1(1)-y1(2)-etta1);
else
    dy1(2) = epsilon1*(be*y1(1)-y1(2)-etta1);
end

if y1(1)>Vset_1
    dy1(3) =   1e13 * t * 0.01 * (exp(q*(-Fi_ion_1-0.2*y1(1))/(k*T)))*(1-(2*y1(3)-1)^(20));
elseif y1(1)<Vreset_1
    dy1(3) = (-1e13) * t * 0.01 * (exp(q*(-Fi_ion_1+0.09*y1(1))/(k*T)))*(1-(2*y1(3)-1)^(20));
else
    dy1(3)=0;
end

if y1(1)>Vset_2
    dy1(4) =  1e13 * t * 0.01 * (exp(q*(-Fi_ion_2-0.07*y1(1))/(k*T)))*(1-(2*y1(4)-1)^(20));
elseif y1(1)<Vreset_2
    dy1(4) = (-1e13) * t * 0.01 * (exp(q*(-Fi_ion_2+0.19*y1(1))/(k*T)))*(1-(2*y1(4)-1)^(20));
else
    dy1(4)=0;
end

end



