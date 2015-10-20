//port_name=evstr(x_dialog('Please enter COM port number: ','3'))
//if port_name==[] then
//    msg=_("ERROR: No serial port has been chosen. ");
//    messagebox(msg, "ERROR", "error");
//    error(msg);
//    return;
//end 
////
//global %serial_port
//%serial_port=openserial(port_name,"9600,n,8,1");

com =-1;
error_number = 999;
while (error_number <> 0)
    com = com+1;
    try
        %serial_port=openserial(com,"9600,n,8,1");
    end 
    [error_message,error_number]=lasterror(%t)
    if com == 10 then
        disp("Arduino not found or permission denied")
        abort
    end
end

