port_name=evstr(x_dialog('Please enter COM port number: ','3'))
if port_name==[] then
    msg=_("ERROR: No serial port has been chosen. ");
    messagebox(msg, "ERROR", "error");
    error(msg);
    return;
end 
//
global %serial_port
%serial_port=openserial(port_name,"9600,n,8,1");
