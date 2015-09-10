clear
clc

json_eg = mgetl("jsonTest.txt");
mystruct = JSONParse(json_eg)
disp(mystruct)
disp ("sensor 1")
disp(mystruct.sensors(1))
disp(mystruct.temp(1))
disp ("sensor 2")
disp(mystruct.sensors(2))
disp(mystruct.temp(2))
