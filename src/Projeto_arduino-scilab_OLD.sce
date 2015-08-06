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

//
// Connection
//
port_name=evstr(x_dialog('Please enter COM port number: ','5'))
if port_name==[] then
    msg=_("ERROR: No serial port has been chosen. ");
    messagebox(msg, "ERROR", "error");
    error(msg);
    return;
end 
//
global %serial_port
%serial_port=openserial(port_name,"19200,n,8,1");

//
// Monitoring Phase
//
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
f=figure("dockable","off");
f.resize="off";
f.menubar_visible="off";
f.toolbar_visible="off";
f.figure_name="Real-time Temperature Monitoring and Control";
f.tag="mainWindow";
//
bar(.5,0,'blue');
e = gce();
e = e.children(1);
e.tag = "instantSensor";
//
plot([0, 1], [%MinTemp, %MinTemp]);
e = gce();
e = e.children(1);
e.tag = "instantMinTemp";
e.line_style = 5;
e.thickness = 2;
e.foreground = color("orange");
//
plot([0, 3], [%MaxTemp, %MaxTemp]);
e = gce();
e = e.children(1);
e.tag = "instantMaxTemp";
e.line_style = 5;
e.thickness = 2;
e.foreground = color("red");
//
a = gca();
a.data_bounds = [0, 0; 1, 45];
a.grid = [-1, color("darkgrey")];
a.axes_bounds = [0.1, 0.2, 0.25, 0.85];
a.axes_visible(1) = "off";
a.tag = "liveAxes";
//
f.figure_position = [0 0];
f.figure_size = [1000 700];
f.background = color(246,244,242) 
//
minTempSlider = uicontrol("style", "slider", "position", [60 30 30 440], ...
"min", 0, "max", 45, "sliderstep", [1 5], "value" , %MinTemp, ...
"callback", "changeMinTemp", "tag", "minTempSlider");
maxTempSlider = uicontrol("style", "slider", "position", [20 30 30 440], ...
"min", 0, "max", 45, "sliderstep", [1 5], "value" , %MaxTemp, ...
"callback", "changeMaxTemp", "tag", "maxTempSlider");

//
// Regulation Phase
//
top_axes_bounds = [0.25 0 0.8 0.5];
bottom_axes_bounds = [0.25 0.5 0.8 0.5];
minTempDisplay = 20;
maxTempDisplay = 45;
minRegulationDisplay = minTempDisplay + 273.15;
maxRegulationDisplay = maxTempDisplay + 273.15;
//
// Temperature variations in the last 5 minutes
timeBuffer = 300;
subplot(222);
a = gca();
a.axes_bounds = top_axes_bounds;
a.axes_reverse = ['on', 'off', 'off'];
a.grid=[-1, color("darkgrey")]
a.tag = "minuteAxes";
plot2d(0:timeBuffer, zeros(1,timeBuffer + 1), color("red"));
a.title.text="Temperature variations in the last 5 minutes";
a.data_bounds = [0, minTempDisplay; timeBuffer, maxTempDisplay];
e = gce();
e = e.children(1);
e.tag = "minuteSensor";
//
a = newaxes();
a.y_location = "right";
a.filled = "off" 
a.grid=[-1, color("lightblue")]
a.tight_limits="on"
a.axes_bounds = top_axes_bounds;
plot2d(0:timeBuffer, zeros(1,timeBuffer + 1), color("blue"));
a.data_bounds = [0, minRegulationDisplay; timeBuffer, maxRegulationDisplay];
a.axes_visible(1) = "off";
a.foreground=color("blue");
a.font_color=color("blue");
e = gce();
e = e.children(1);
e.tag = "minuteRegulation";
//
// Temperature variations in the last hour
timeBuffer = 3600;
subplot(224);
a = gca();
a.axes_bounds = bottom_axes_bounds;
a.tight_limits="on"
a.axes_reverse = ['on', 'off', 'off'];
a.grid=[-1, color("darkgrey")]
a.tag = "hourAxes";
plot2d(0:timeBuffer, zeros(1,timeBuffer + 1), color("red"));
a.title.text="Temperature variations in the last hour";
a.data_bounds = [0, minTempDisplay; timeBuffer, maxTempDisplay];
e = gce();
e = e.children(1);
e.tag = "hourSensor";
// 
a = newaxes();
a.y_location = "right";
a.filled = "off" 
a.grid=[-1, color("lightblue")]
a.tight_limits="on"
a.axes_bounds = bottom_axes_bounds;
plot2d(0:timeBuffer, zeros(1,timeBuffer + 1), color("blue"));
a.data_bounds = [0, minRegulationDisplay; timeBuffer, maxRegulationDisplay];
a.axes_visible(1) = "off";
a.foreground=color("blue");
a.font_color=color("blue");
e = gce();
e = e.children(1);
e.tag = "hourRegulation";

//
// Functions 
//
function changeMinTemp()
    global %MinTemp
    e = findobj("tag", "minTempSlider");
    %MinTemp = e.value;
    e = findobj("tag", "instantMinTemp");
    e.data(:,2) = %MinTemp;
endfunction
//
function changeMaxTemp()
    global %MaxTemp
    e = findobj("tag", "maxTempSlider");
    %MaxTemp = e.value;
    e = findobj("tag", "instantMaxTemp");
    e.data(:,2) = %MaxTemp;
endfunction
//
function closeFigure()
    stopSensor();
    exportValues();
    global %serial_port
    closeserial(%serial_port);
    f = findobj("tag", "mainWindow");
    delete(f);
endfunction
//
function stopSensor()
    global %Acquisition
    %Acquisition = %f;
endfunction
//
function launchSensor()
    global %MaxTemp
    global %serial_port
    global %Acquisition
    global %time
    global %temp
    global %data
    %Acquisition = %t;
    readserial(%serial_port);
    //
    while %Acquisition 
        values=[];
        value=ascii(0);

        while(value~=ascii(13)) then
            value=readserial(%serial_port,1);
            values=values+value;
            v=strsubst(values,string(ascii(10)),'')
            v=strsubst(v,string(ascii(13)),'')
            dado=evstr(v)
        end
        //
        xinfo("Temp = "+v+"°C / "+string(dado+273.15)+" K");
        %data = [%data dado]
        %time = length(%data)-1
        %temp = dado;
        updateSensorValue(dado);
    end
endfunction
//
function updateSensorValue(data)
    global %MaxTemp
    global %MinTemp
    global %time
    global %temp
    //
    e = findobj("tag", "instantSensor");
    e.data(2) = data;
    if data > %MaxTemp then
        e.background = color("red");
    elseif data < %MinTemp  then
        e.background = color("blue");
    else
        e.background = color("green");
    end
    //
    e = findobj("tag", "minuteSensor");
    lastPoints = e.data(:, 2);
    e.data(:, 2) = [data ; lastPoints(1:$-1)];
    //
    e = findobj("tag", "hourSensor");
    lastPoints = e.data(:, 2);
    e.data(:, 2) = [data ; lastPoints(1:$-1)];
    //
    updateTime();
    updateTemp();
endfunction
//
function updateTime()
    global %time
    //
    timeValue = uicontrol(f, "style", "text", "position", ...
    [85 505 60 30], "string", string(%time)+"s", "fontsize", 25)
endfunction
//
function updateTemp()
    global %temp
    //
    tempValue = uicontrol(f, "style", "text", "position", ...
    [210 505 105 30], "string", string(%temp)+"ºC", "fontsize", 25)
endfunction
//
function resetDisplay()
    exportValues()
    e = findobj("tag", "instantSensor");
    e.data(:, 2) = 0;
    e = findobj("tag", "minuteSensor");
    e.data(:, 2) = 0;
    e = findobj("tag", "hourSensor");
    e.data(:, 2) = 0;
    e = findobj("tag", "minuteRegulation");
    e.data(:, 2) = 0;
    e = findobj("tag", "hourRegulation");
    e.data(:, 2) = 0;
    global %time
    %time = 0;
    global %temp
    %temp = [];
    global %data
    %data = [];
    global %serial_port
    readserial(%serial_port);
endfunction
//
function exportValues()
    global %data
    global %Export
    tempo = 0:size(%data,2)-1;
    M = [tempo' %data'];
    
    csvWrite(M, "tempData_" + string(%Export) + ".csv", ";", [], "%g");
    %Export = %Export+1;
endfunction

//
// Buttons 
// 
mainFrame = uicontrol(f, "style", "frame", "position", [15 560 305 80], ...
"tag", "mainFrame", "ForegroundColor", [0/255 0/255 0/255],...
"border", createBorder("titled", createBorder("line", "lightGray", 1)...
, _("Main Panel"), "center", "top", createBorderFont("", 11, "normal"), ...
"black"));
//
startButton = uicontrol(f, "style", "pushbutton", "position", ...
[20 595 145 30], "callback", "launchSensor", "string", "Start Acquisition", ...
"tag", "startButton");
//
stopButton = uicontrol(f, "style", "pushbutton", "position", ...
[170 595 145 30], "callback", "stopSensor", "string", "Stop Acquisition", ...
"tag", "stopButton");
//
resetButton = uicontrol(f, "style", "pushbutton", "position", ...
[20 565 145 30], "callback", "resetDisplay", "string", "Reset", ...
"tag", "resetButton");
//
quitButton = uicontrol(f, "style", "pushbutton", "position", ...
[170 565 145 30], "callback", "closeFigure", "string", "Quit", ...
"tag", "quitButton");
//
ValueFrame = uicontrol(f, "style", "frame", "position", [15 490 305 65]...
,"tag", "valueFrame", "ForegroundColor", [0/255 0/255 0/255],...
"border", createBorder("titled", createBorder("line", "lightGray", 1), ...
_("View Panel"), "center", "top", createBorderFont("", 11, "normal"),...
 "black"));
//
timeLabel = uicontrol(f, "style", "text", "position", ...
[45 505 40 30], "string", "t = ", "fontsize", 25)
//
tempLabel = uicontrol(f, "style", "text", "position", ...
[160 505 50 30], "string", "T = ", "fontsize", 25)
//
updateTime()
//
updateTemp()
//
