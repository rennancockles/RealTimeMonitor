//* Projeto final do curso de Engenharia de Computação do
//*Instituto Politécnico da Universidade Estadual do Rio de
//*Janeiro (IPRJ-UERJ).
//
//*Aluno: Rennan Cockles
//*Orientador: José Humberto Zani
//

close
clear
clearglobal
clc

global %time
%time = 0;
global %temp
%temp = [];
global %temp2
%temp2 = [];
global %data
%data = [];
global %data2
%data2 = [];
global %MaxTemp
%MaxTemp = 25;
global %MinTemp
%MinTemp = 20;
global %MaxTemp2
%MaxTemp2 = 25;
global %MinTemp2
%MinTemp2 = 20;
global %Export
%Export = 0;
global %stability_time
%stability_time = 30;
global %stability_value
%stability_value = .3;
global %warning
%warning = [%t, %t];
//
global timeBuffer
global timeBuffer2
global minTempDisplay
global minTempDisplay2
global maxTempDisplay
global maxTempDisplay2
global minRegulationDisplay
global minRegulationDisplay2
global maxRegulationDisplay
global maxRegulationDisplay2
//
top_axes_bounds = [0.230 0 0.535 0.5];
bottom_axes_bounds = [0.230 0.5 0.535 0.5];
//
timeBuffer = 300;
minTempDisplay = 15;
maxTempDisplay = 50;
minRegulationDisplay = minTempDisplay + 273.15;
maxRegulationDisplay = maxTempDisplay + 273.15;
//
timeBuffer2 = 300;
minTempDisplay2 = 15;
maxTempDisplay2 = 50;
minRegulationDisplay2 = minTempDisplay2 + 273.15;
maxRegulationDisplay2 = maxTempDisplay2 + 273.15;
//
exec("..\etc\ScilabLib\Serial_Communication_Toolbox\0.4.1-2\loader.sce", -1)
//exec("..\etc\ScilabLib\JSON\loader.sce", -1)
//exec("connection.sce", -1)
exec("monitoring.sce", -1)
exec("monitoring2.sce", -1)
exec("5minVar.sce", -1)
exec("5minVar2.sce", -1)
exec("functions.sci", -1)
exec("controls.sci", -1)
exec("controls2.sci", -1)
exec("menu.sci", -1)
//
update();
//
