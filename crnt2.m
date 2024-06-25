function J_2 = crnt2(U)

% Pt(20nm) / Ru(40nm) / ZrO2(12%Y2O3, 20nm) / Pt(40nm) / Ti

global T t w_2

% % param
% w_2=0;
Fi_ion_2=0.8;
q=1.6e-19; % electron charge
k=1.38e-23; % Boltzman factor
T=300;
t=0.001;
A_2=2.8e3*exp(1-300/T);
A_4=-4.2e3*exp(1-300/T);
B_2 = 2e4 ;
B_4 = 1.7e4;

if U>=0
   
    j_2_lin = A_2 * U;
    j_2_nonlin = 1e-6 +  B_2 * exp(0.2*sqrt(U));
    w_2 = w_2 - 1e13*t*0.01*(exp(q*(-Fi_ion_2+0.2*U)/(k*T)));
      if w_2<0.001
        w_2=0;
      end
else
  
    j_2_lin = A_4 * abs(U);
    j_2_nonlin = 1e-6 + B_4 * exp(0.13*sqrt(abs(U)));
  w_2 = w_2 + 1e13*t*0.01*(exp(q*(-Fi_ion_2-0.2*abs(U))/(k*T)));
    if w_2>0.99
       w_2=1;
     end
    
end



J_2 = (w_2*j_2_lin+(1-w_2)*j_2_nonlin)*8.4*10^(-7);

end