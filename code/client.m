 close all; 
 clear all;
 %clc;
 
 %Reopen connection
 
 a = arduino();
 
disp ('Client - Sender');

t = tcpip('192.168.43.152', 5000, 'NetworkRole', 'client');
%t = tcpip('localhost', 6969, 'NetworkRole', 'client');

fopen(t);
pause(1);
disp('fopen')
 
%make timer
 T0 = tic;
 %plot values
 x_r = 0;
 x_l = 0;
 counter = 0;
 command_r = 0;
 command_l = 0;
 command = 0;
 %Command:
    %0 - PARADO
    %1 - ANDAR
    %2 - PARAR RODAR A DIREITA
    %3 - PARAR RODAR A ESQUERDA
 %Threshold de tensao em cada braco (em V)   
 t_r = 0.9;
 t_l = 0.9;
 
 list_command = 0;
 figure; 
 while(toc(T0)<200)
     %reading voltage from arduino
     voltage_r = readVoltage(a,'A0'); %right arm electrodes
     voltage_l = readVoltage(a,'A2'); %left arm electrodes 
     x_r = [x_r,voltage_r];
     x_l = [x_l,voltage_l];
%      subplot 211
%      plot(x)

%      %Define window in plot
%      if length(x) >200
%          xlim([length(x)-200 length(x)])
%      end
     
     if (voltage_r <t_r && command_r) || (voltage_r>t_r &&~command_r)||(voltage_l <t_l && command_l) || (voltage_l>t_l &&~command_l)
         counter = counter +1;
         if counter>1
             
             if (voltage_r <t_r && command_r) || (voltage_r>t_r &&~command_r)
                 command_r = 1-command_r;  
             end
             if (voltage_l <t_l && command_l) || (voltage_l>t_l &&~command_l)
                    command_l = 1-command_l;
             end

             counter = 0;
             
             if command_r==0 
                 if command_l ==0
                    command = 0;
                 else
                     command = 3;
                 end
             elseif command_l ==0
                 command = 2;
             else 
                 command =1;
             end
         end
     else 
         counter = 0;
     end      
     disp(command)
     fwrite(t,command);

 end

fclose(t);
delete(t);

delete(timerfindall)
delete(instrfindall)

