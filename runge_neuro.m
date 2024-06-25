function f = runge_neuro(t, Y, etta1, epsilon1)

%% params
Fi_ion_1=0.8;% eV potential barrier for ion hopes
Fi_ion_2=0.8;
q=1.6e-19; % electron charge
k=1.38e-23; % Boltzman factor
T=300;

A_1= 3.6e3*exp(1-300/T); % coeff for Ohmic current
A_2=2.8e3*exp(1-300/T);
A_3=1.3e3*exp(1-300/T); % coeff for Ohmic current
A_4=4.2e3*exp(1-300/T);
B_1 = 6.5e-5; % coeff for Pool-Frenkel current
B_2 = 2e-4 ;
B_3 = 4.5e-5;
B_4 = 1.7e-4;
Vset_1 = -0.5;
Vreset_1 = 0.1;
Vset_2 = -0.5;
Vreset_2 = 0.2;
% Vset_1 = 0.75;
% Vreset_1 = 2;
% Vset_2 = 0.7;
% Vreset_2 = 2.5;

al=0.42;
be=1.16;

%%

if Y(1)>=0
    j_1_lin=A_1*Y(1);
    j_1_nonlin= B_1 * Y(1)* exp(-38.6+1.7 * sqrt(Y(1)));
    j_2_lin=A_2*Y(1);
    j_2_nonlin=  B_2 * Y(1)* exp(-38.6+0.2 * sqrt(Y(1)));
    
else
    j_1_lin=A_3*abs(Y(1));
    j_1_nonlin=  B_3 * abs(Y(1))* exp(-38.6+1.3 * sqrt(abs(Y(1))));
    j_2_lin=A_4*abs(Y(1));
    j_2_nonlin=  B_4 * abs(Y(1))* exp(-38.6+0.12*sqrt(abs(Y(1))));
end

J_1=0.582*(Y(3)*j_1_lin+(1-Y(3))*j_1_nonlin)*1*10^(-6);
J_2=0.821*(Y(4)*j_2_lin+(1-Y(4))*j_2_nonlin)*8.4*10^(-6);
J=J_1 + J_2;


f(1) = J-Y(2);
if Y(1)<0
    f(2) = epsilon1*(al*Y(1)-Y(2)-etta1);
else
    f(2) = epsilon1*(be*Y(1)-Y(2)-etta1);
end

if Y(1)>Vset_1
    f(3) =  1e8*(exp(q*(-Fi_ion_1-0.2*Y(1))/(k*T)))*(1-(2*Y(3)-1)^(20));
elseif Y(1)<Vreset_1
    f(3) =  (-1e8)*(exp(q*(-Fi_ion_1+0.09*Y(1))/(k*T)))*(1-(2*Y(3)-1)^(20));
else
    f(3)=0;
end

if Y(1)>Vset_2
    f(4) = 1e8*(exp(q*(-Fi_ion_2-0.07*Y(1))/(k*T)))*(1-(2*Y(4)-1)^(20));
elseif Y(1)<Vreset_2
    f(4) =  (-1e8)*(exp(q*(-Fi_ion_2+0.19*Y(1))/(k*T)))*(1-(2*Y(4)-1)^(20));
else
    f(4)=0;
end

f = f';
end