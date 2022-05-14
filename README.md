## EMG sensing for Dual Control of Unicycle Robot

The implementation in this repository allows the control of a platform robot, Pioneer P3-DX, via two electromyography (EMG) setups, each placed on the bicep of one arm, allowing for full, remote control on a 2D-space.  

The methods and pipeline used are extensively described in the ***report.pdf*** file.

### Code:

You can find all the code files from this project inside the ***code*** directory.
There are two main files there:

+ ***client.m*** - file to be run in the computer connected to the EMG reading device (Arduino); it reads the data coming from the EMG signal and sends it to the computer connected to the robot; 
+ ***server.m*** - file to be run in the computer connected to the robot; it receives the data sent by the *client* and sets the robot response accordingly.

 We apologize for having some of the code comments in Portuguese. 