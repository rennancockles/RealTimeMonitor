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
    //set(acqButton, "value", 1);
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
    update();
endfunction
//
function update()
    global %temp
    global %time
    //
    set(tempValue, "string", string(%temp)+"ºC", "fontsize", 25);
    //
    set(timeValue, "string", string(%time)+"s", "fontsize", 25);
endfunction
//
function resetDisplay()
    exportValues()
    global %time
    %time = 0;
    global %temp
    %temp = [];
    global %data
    %data = [];
    global %serial_port
    readserial(%serial_port);
    //
    //set(acqButton, "value", 0);
    update();
    xinfo(f.figure_name);
    //
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
endfunction
//
function exportValues()
    global %data
    global %Export
    if %data == [] then
        return
    end
    tempo = 0:size(%data,2)-1;
    M = [tempo' %data'];
    
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
