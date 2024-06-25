function J_1 = crnt1(U)

% Pt(20nm) / Ta(40nm) / ZrO2(12%Y2O3, 20nm) / Pt(40nm) / Ti

global T t w_1

% % param
% w_1=0;
Fi_ion_1=0.9;% eV potential barrier for ion hopes
q=1.6e-19; % electron charge
k=1.38e-23; % Boltzman factor
T=300;
t=0.001;
A_1 = 3.6e3*exp(1-300/T); % coeff for Ohmic current
A_3 = -1.3e3*exp(1-300/T); % coeff for Ohmic current
B_1 = 6.5e5; % coeff for Pool-Frenkel current
B_3 = 4.5e5;

if U>=0
   
    j_1_lin = A_1 * U;
    j_1_nonlin =1e-6 +  B_1 * exp(1.7*sqrt(U));
    w_1 = w_1 - 1e13*t*0.01*(exp(q*(-Fi_ion_1+0.2*U)/(k*T)));
      if w_1<0.001
        w_1=0;
      end
else
  
    j_1_lin = A_3 * abs(U);
    j_1_nonlin = 1e-6 + B_3 * exp(1.3*sqrt(abs(U)));
  w_1 = w_1 + 1e13*t*0.01*(exp(q*(-Fi_ion_1-0.2*abs(U))/(k*T)));
    if w_1>0.99
       w_1=1;
     end
   
end



J_1 =(w_1*j_1_lin+(1-w_1)*j_1_nonlin)*1*10^(-7);


end