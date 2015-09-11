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
//
top_axes_bounds = [0.230 0 0.535 0.5];
bottom_axes_bounds = [0.230 0.5 0.535 0.5];
minTempDisplay = 15;
maxTempDisplay = 45;
minRegulationDisplay = minTempDisplay + 273.15;
maxRegulationDisplay = maxTempDisplay + 273.15;
//
exec("..\..\etc\ScilabLib\Serial_Communication_Toolbox\0.4.1-2\loader.sce", -1)
exec("connection.sce", -1)
exec("monitoring.sce", -1)
exec("monitoring2.sce", -1)
exec("5minVar.sce", -1)
exec("5minVar2.sce", -1)
exec("functions.sci", -1)
exec("controls.sci", -1)
exec("controls2.sci", -1)
//
update();
//
