funcprot(0)
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
    global %stability_time
    global %stability_value
    global %warning
    %Acquisition = %t;
    readserial(%serial_port);
    //
    while(%Acquisition)
        //
        values = [];
        value = ascii(0);
        ln = 1;
        v="";
        v2="";
        //        
        while (value ~= "{") do
            value = readserial(%serial_port,1);
        end
        //
        if (value == '{') then
            values(ln,1) = value;
        end
        //
        while (value ~= '}') do
            value =  readserial(%serial_port,1);
            //
            if (ascii(value) < 33 | ascii(value) > 125) then
                ln = ln+1;
                while(ascii(value) < 33 | ascii(value) > 125)
                    value = readserial(%serial_port,1);
                end
                //
                values(ln,1) = value;
                continue
            end
            //
            values(ln,1) = values(ln,1) + value;
        end
        //
        json = JSONParse(values);
        //
        if (json.sensors(1) == 1) then
            v=json.temp(1);
        end
        //
        if (json.sensors(2) == 1) then
            v2=json.temp(2);
        end
        //
        if (v~="" & v2~="") then
            xinfo("Temp1 = "+string(v)+"°C / "+string(v+273.15)+" K" + ...
            "     |     Temp2 = "+string(v2)+"°C / "+string(v2+273.15)+" K");
            %data = [%data v]
            %data2 = [%data2 v2]
            %time = length(%data)-1
            %temp = v;
            %temp2 = v2;
            updateSensorValue(v, v2);
        elseif (v~="" & v2=="") then
            xinfo("Temp1 = "+string(v)+"°C / "+string(v+273.15)+" K");
            %data = [%data v]
            %data2 = [%data2 -1]
            %time = length(%data)-1
            %temp = v;             
            %temp2 = -1;
            updateSensorValue(v, -1);
        elseif (v=="" & v2~="") then
            xinfo("Temp2 = "+string(v2)+"°C / "+string(v2+273.15)+" K");
            %data = [%data -1]
            %data2 = [%data2 v2]
            %time = length(%data)-1
            %temp = -1;           
            %temp2 = v2;
            updateSensorValue(-1, v2);
        end
        //
        if (%time>%stability_time) then
           resp1=0;
           resp2=0;
           if (sum(abs(diff(%data($-%stability_time+1 : $)))) < %stability_value) & (%warning(1) == %t) then
               resp1 = messagebox("Sensor 1 is stable", "Info", "info", ["Continue" "Stop"], "modal")
           elseif  (sum(abs(diff(%data2($-%stability_time+1 : $)))) < %stability_value) & (%warning(2) == %t) then
               resp2 = messagebox("Sensor 2 is stable", "Info", "info", ["Continue" "Stop"], "modal")
           end
           //
           if resp1 == 1 then
               %warning(1) = %f
           end
           if resp2 == 1 then
               %warning(2) = %f
           end
           if resp1 == 2 | resp2 == 2 then
               stopSensor();
           end
        end
    end
endfunction
//
function stopSensor()
    global %Acquisition
    %Acquisition = %f;
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
function updateSensorValue(data, data2)
    global %MaxTemp
    global %MaxTemp2
    global %MinTemp
    global %MinTemp2
    //
    if data ~= -1 then
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
        e = findobj("tag", "Sensor1");
        lastPoints = e.data(:, 2);
        e.data(:, 2) = [data ; lastPoints(1:$-1)];
    end
    //
    if data2 ~= -1 then
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
        e = findobj("tag", "Sensor2");
        lastPoints = e.data(:, 2);
        e.data(:, 2) = [data2 ; lastPoints(1:$-1)];
    end
    //
    update();
endfunction
//
function update()
    global %temp
    global %temp2
    global %time
    //
    if %temp ~= -1 then
        set(tempValue, "string", string(%temp)+"ºC", "fontsize", 25);
        //
        set(timeValue, "string", string(%time)+"s", "fontsize", 25);
    end
    //
    if %temp2 ~= -1 then
        set(tempValue2, "string", string(%temp2)+"ºC", "fontsize", 25);
        //
        set(timeValue2, "string", string(%time)+"s", "fontsize", 25);
    end
endfunction
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

    csvWrite(M, "../data/tempData_" + string(%Export) + ".csv", ";", [], "%g");
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
