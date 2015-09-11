//* Projeto final do curso de Engenharia de Computação do
//*Instituto Politécnico da Universidade Estadual do Rio de
//*Janeiro (IPRJ-UERJ).
//
//*Aluno: Rennan Cockles
//*Orientador: José Humberto Zani
//

close
clear
clc

global %time
%time = 0;
global %temp
%temp = [];
global %data
%data = [];
global %MaxTemp
%MaxTemp = 25;
global %MinTemp
%MinTemp = 20;
global %Export
%Export = 0;
//
top_axes_bounds = [0.25 0 0.8 0.5];
bottom_axes_bounds = [0.25 0.5 0.8 0.5];
minTempDisplay = 15;
maxTempDisplay = 45;
minRegulationDisplay = minTempDisplay + 273.15;
maxRegulationDisplay = maxTempDisplay + 273.15;
//
exec("..\etc\ScilabLib\Serial_Communication_Toolbox\0.4.1-2\loader.sce", -1)
//exec("connection.sce", -1)
exec("monitoring.sce", -1)
exec("5minVar.sce", -1)
exec("lastHourVar.sce", -1)
exec("functions.sci", -1)
exec("controls.sci", -1)
//
update();
//
