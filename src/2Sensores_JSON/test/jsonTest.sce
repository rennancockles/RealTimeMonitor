//clear
clc
funcprot(0)
//
//exec("..\..\..\etc\JSON\loader.sce", -1)

//json_eg = mgetl("jsonTest_1sensor.txt");
//mystruct = JSONParse(json_eg)
//disp(mystruct)
//disp ("sensor 1")
//disp(mystruct.sensors(1))
//disp(mystruct.temp(1))
//disp ("sensor 2")
//disp(mystruct.sensors(2))
//disp(mystruct.temp(2))
////
//disp(" ")
//disp("---PARTE 2---")
//disp(" ")
//
fn = "jsonTest_1sensor.txt"; // absolute path to some file
fd = mopen(fn, 'rt');           // open file as text with read mode
//
values = [];
value = ascii(0);
//
while(~meof(fd))
    ln = 1;
    //
    values = [];
    value = ascii(0);
    dado=[];
    dado2=[];
    //        
    while (value ~= "{") do
        value = mgetstr(1, fd);
        if (meof(fd)) then
            disp("FECHANDO CONEXÃO")
            mclose(fd);
            return
        end
    end
    //
    if (value == '{') then
        values(ln,1) = value;
    end
    //
    while (value ~= '}') do
        value = mgetstr(1, fd);
        //
        if (value == ascii(13)) then
            ln = ln+1;
            while(value == ascii(13) | value == ascii(10))
                value = mgetstr(1, fd);
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
    disp(string(json.qtdSensor) + " sensor(es) encontrado(s)")
    
    if (json.sensors(1) == 1) then
        v=json.temp(1);
        disp("  valor do sensor 1 = " + string(v) + "°C")
    else
        disp("  sensor 1 nao encontrado")
    end
    
    if (json.sensors(2) == 1) then
        v2=json.temp(2);
        disp("  valor do sensor 2 = " + string(v2) + "°C")
    else
        disp("  sensor 2 nao encontrado")
    end
end

