 %Inicializar robot
sp  = serial_port_start;
pioneer_init(sp);
pause(0.3)


disp ('Receiver started');

t = tcpip('192.168.43.145', 5000, 'NetworkRole', 'server');

disp('Waiting for connection');
fopen(t);
disp('Connection OK');


 T0 = tic;
 %plot values
 x = 0;
 counter = 0;
 command = 0;
 
 while(toc(T0)<200)
     command = fread (t,1);
     if command ==0
         pioneer_set_controls(sp,0,0);
     elseif command ==1
         pioneer_set_controls(sp,250,0);
     elseif command ==2
         pioneer_set_controls(sp,0,-20);
     else 
         pioneer_set_controls(sp,0,20);

     end

 end

pioneer_set_controls(sp,0,0);

delete(timerfindall)
delete(instrfindall)
serial_port_stop(sp)
pioneer_close(sp)
