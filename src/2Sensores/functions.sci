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
function changeMinTemp2()
    global %MinTemp2
    e = findobj("tag", "minTempSlider2");
    %MinTemp2 = e.value;
    e = findobj("tag", "instantMinTemp2");
    e.data(:,2) = %MinTemp2;
endfunction
//
function changeMaxTemp2()
    global %MaxTemp2
    e = findobj("tag", "maxTempSlider2");
    %MaxTemp2 = e.value;
    e = findobj("tag", "instantMaxTemp2");
    e.data(:,2) = %MaxTemp2;
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
    global %MaxTemp2
    global %serial_port
    global %Acquisition
    global %time
    global %temp
    global %temp2
    global %data
    global %data2
    %Acquisition = %t;
    readserial(%serial_port);
    //
    while %Acquisition 
        values = [];
        value = ascii(0);
        v="";
        v2="";
        //        
        while (value ~= "!") do
            value=readserial(%serial_port,1);
        end
        //
        if (value == "!") then
            while (value ~= ascii(13)) do
                value=readserial(%serial_port,1);
                //
                if (value == ascii(13)) then
                    break;
                end
                //
                values=values+value;
                v=strsubst(values,string(ascii(10)),'')
                v=strsubst(v,string(ascii(13)),'')
                dado=evstr(v)
            end
        end
        //
        values = [];
        while (value ~= "?") do
            value=readserial(%serial_port,1);
        end
        //
        if (value == "?") then
            while (value ~= ascii(13)) do
                value=readserial(%serial_port,1);
                //
                if (value == ascii(13)) then
                    break;
                end
                //
                values=values+value;
                v2=strsubst(values,string(ascii(10)),'')
                v2=strsubst(v2,string(ascii(13)),'')
                dado2=evstr(v2)
            end
        end
        //
        if (v~="" & v2~="") then
            xinfo("Temp1 = "+v+"°C / "+string(dado+273.15)+" K" + ...
            "  |  Temp2 = "+v2+"°C / "+string(dado2+273.15)+" K");
            %data = [%data dado]
            %data2 = [%data2 dado2]
            %time = length(%data)-1
            %temp = dado;
            %temp2 = dado2;
            updateSensorValue(dado, dado2);
        end
    end
endfunction
//
function updateSensorValue(data, data2)
    global %MaxTemp
    global %MaxTemp2
    global %MinTemp
    global %MinTemp2
    global %time
    global %temp
    global %temp2
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
    e = findobj("tag", "instantSensor2");
    e.data(2) = data2;
    if data2 > %MaxTemp2 then
        e.background = color("red");
    elseif data2 < %MinTemp2  then
        e.background = color("blue");
    else
        e.background = color("green");
    end
    //
    e = findobj("tag", "Sensor1");
    lastPoints = e.data(:, 2);
    e.data(:, 2) = [data ; lastPoints(1:$-1)];
    //
    e = findobj("tag", "Sensor2");
    lastPoints = e.data(:, 2);
    e.data(:, 2) = [data2 ; lastPoints(1:$-1)];
    //
    update();
endfunction
//
function update()
    global %temp
    global %temp2
    global %time
    //
    set(tempValue, "string", string(%temp)+"ºC", "fontsize", 25);
    //
    set(tempValue2, "string", string(%temp2)+"ºC", "fontsize", 25);
    //
    set(timeValue, "string", string(%time)+"s", "fontsize", 25);
    //
    set(timeValue2, "string", string(%time)+"s", "fontsize", 25);
endfunction
//
function resetDisplay()
    exportValues()
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
    global %serial_port
    readserial(%serial_port);
    //
    update();
    xinfo(f.figure_name);
    //
    e = findobj("tag", "instantSensor");
    e.data(:, 2) = 0;
    e = findobj("tag", "Sensor1");
    e.data(:, 2) = 0;
    e = findobj("tag", "minute1Regulation");
    e.data(:, 2) = 0;
    //
    e = findobj("tag", "instantSensor2");
    e.data(:, 2) = 0;
    e = findobj("tag", "Sensor2");
    e.data(:, 2) = 0;
    e = findobj("tag", "minute2Regulation");
    e.data(:, 2) = 0;
endfunction
//
function exportValues()
    global %data
    global %data2
    global %Export
    if %data == [] & %data2 == [] then
        return
    end
    tempo = 0:size(%data,2)-1;
    M = [tempo' %data' %data2'];
    
    csvWrite(M, "tempData_" + string(%Export) + ".csv", ";", [], "%g");
    %Export = %Export+1;
endfunction
//
function popupCallback ()
   obj = findobj("tag", "acqButton");
   val = get ( obj, 'value' );
   
   if val == 1 then
       launchSensor();
   else
       stopSensor();
   end
 endfunction
