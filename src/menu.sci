mAcq=uimenu(f,'label', 'Acquisition');
mSetup=uimenu(f,'label', "Setup");
mExport=uimenu(f,'label', "Export Data", "callback", "exportValues");
//
mAcq1=uimenu(mAcq,'label', "Start", "callback", "launchSensor");
mAcq2=uimenu(mAcq,'label', "Stop", "callback", "stopSensor");
mAcq3=uimenu(mAcq,'label', "Reset", "callback", "resetDisplay");
//
mSensor1=uimenu(mSetup,'label', "Sensor 1");
mSensor2=uimenu(mSetup,'label', "Sensor 2");
mStability=uimenu(mSetup,'label', "Stability");
//
mBuffer1=uimenu(mSensor1,'label', "Time Buffer", "callback", "changeBuffer(1)");
mMinTemp1=uimenu(mSensor1,'label', "Min Temp Display", "callback", "setupMinTemp(1)");
mMaxTemp1=uimenu(mSensor1,'label', "Max Temp Display", "callback", "setupMaxTemp(1)");
//
mBuffer2=uimenu(mSensor2,'label', "Time Buffer", "callback", "changeBuffer(2)");
mMinTemp2=uimenu(mSensor2,'label', "Min Temp Display", "callback", "setupMinTemp(2)");
mMaxTemp2=uimenu(mSensor2,'label', "Max Temp Display", "callback", "setupMaxTemp(2)");
//
mStabilityValue=uimenu(mStability,'label', "Stability value", "callback", "setupStability(1)");
mStabilityTime=uimenu(mStability,'label', "Stability time", "callback", "setupStability(2)");
//
function changeBuffer(id)
    newBuffer=evstr(x_dialog('Set new time buffer value (seconds): ','300'))
    //
    if newBuffer == [] then
        return
    elseif id == 1 then
        global timeBuffer
        timeBuffer = newBuffer;
        a = findobj("tag", "sensor1Axes");
        e = findobj("tag", "sensor1NewAxes");
        //
        a.data_bounds = [0, minTempDisplay; timeBuffer, maxTempDisplay];
        e.data_bounds = [0, minRegulationDisplay; timeBuffer, maxRegulationDisplay];
    elseif id == 2 then
        global timeBuffer2
        timeBuffer2 = newBuffer;
        a = findobj("tag", "sensor2Axes");
        e = findobj("tag", "sensor2NewAxes");
        //
        a.data_bounds = [0, minTempDisplay2; timeBuffer2, maxTempDisplay2];
        e.data_bounds = [0, minRegulationDisplay2; timeBuffer2, maxRegulationDisplay2];
    end
endfunction
//
function setupMinTemp(id)
    newMinTemp=evstr(x_dialog('Set new min temperature value: ','15'))
    //
    if newMinTemp == [] then
        return
    elseif id == 1 then
        global minTempDisplay
        global minRegulationDisplay
        minTempDisplay = newMinTemp;
        minRegulationDisplay = minTempDisplay + 273.15;
        a = findobj("tag", "sensor1Axes");
        e = findobj("tag", "sensor1NewAxes");
        l = findobj("tag", "liveAxes");
        minS = findobj("tag", "minTempSlider");
        maxS = findobj("tag", "maxTempSlider");
        //
        a.data_bounds = [0, minTempDisplay; timeBuffer, maxTempDisplay];
        e.data_bounds = [0, minRegulationDisplay; timeBuffer, maxRegulationDisplay];
        l.data_bounds = [0, minTempDisplay; 1, maxTempDisplay];
        minS.min = minTempDisplay;
        maxS.min = minTempDisplay;
    elseif id == 2 then
        global minTempDisplay2
        global minRegulationDisplay2
        minTempDisplay2 = newMinTemp;
        minRegulationDisplay2 = minTempDisplay2 + 273.15;
        a = findobj("tag", "sensor2Axes");
        e = findobj("tag", "sensor2NewAxes");
        l = findobj("tag", "liveAxes2");
        minS = findobj("tag", "minTempSlider2");
        maxS = findobj("tag", "maxTempSlider2");
        //
        a.data_bounds = [0, minTempDisplay2; timeBuffer2, maxTempDisplay2];
        e.data_bounds = [0, minRegulationDisplay2; timeBuffer2, maxRegulationDisplay2];
        l.data_bounds = [0, minTempDisplay2; 1, maxTempDisplay2];
        minS.min = minTempDisplay2;
        maxS.min = minTempDisplay2;
    end
endfunction
//
function setupMaxTemp(id)
    newMaxTemp=evstr(x_dialog('Set new max temperature value: ','50'))
    //
    if newMaxTemp == [] then
        return
    elseif id == 1 then
        global maxTempDisplay
        global maxRegulationDisplay
        maxTempDisplay = newMaxTemp;
        maxRegulationDisplay = maxTempDisplay + 273.15;
        a = findobj("tag", "sensor1Axes");
        e = findobj("tag", "sensor1NewAxes");
        l = findobj("tag", "liveAxes");
        minS = findobj("tag", "minTempSlider");
        maxS = findobj("tag", "maxTempSlider");
        //
        a.data_bounds = [0, minTempDisplay; timeBuffer, maxTempDisplay];
        e.data_bounds = [0, minRegulationDisplay; timeBuffer, maxRegulationDisplay];
        l.data_bounds = [0, minTempDisplay; 1, maxTempDisplay];
        minS.max = maxTempDisplay;
        maxS.max = maxTempDisplay;
    elseif id == 2 then
        global maxTempDisplay2
        global maxRegulationDisplay
        maxTempDisplay2 = newMaxTemp;
        maxRegulationDisplay2 = maxTempDisplay2 + 273.15;
        a = findobj("tag", "sensor2Axes");
        e = findobj("tag", "sensor2NewAxes");
        l = findobj("tag", "liveAxes2");
        minS = findobj("tag", "minTempSlider2");
        maxS = findobj("tag", "maxTempSlider2");
        //
        a.data_bounds = [0, minTempDisplay2; timeBuffer2, maxTempDisplay2];
        e.data_bounds = [0, minRegulationDisplay2; timeBuffer2, maxRegulationDisplay2];
        l.data_bounds = [0, minTempDisplay2; 1, maxTempDisplay2];
        minS.max = maxTempDisplay2;
        maxS.max = maxTempDisplay2;
    end
endfunction
//
function setupStability(opt)
    if opt == 1 then
        newStability=evstr(x_dialog('Set new stability value: ','0.3'))
        //
        if newStability == [] then
            return
        else
            global %stability_value
            %stability_value = newStability;
        end
    elseif opt == 2 then
        newStability=evstr(x_dialog('Set new stability time value (seconds): ','30'))
        //
        if newStability == [] then
            return
        else
            global %stability_time
            global %warning
            //
            %warning = [%t, %t];
            %stability_time = newStability;
        end
    end
endfunction
