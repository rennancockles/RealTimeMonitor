clc

com =-1;
error_number = 999;
while (error_number <> 0)
    com = com+1;
    try
        %serial_port=openserial(com,"9600,n,8,1");
    catch
        disp(['Não pode ler serial'])
    end 
    [error_message,error_number]=lasterror(%t)
    disp("ERROR")
    disp(error_message)
    disp(error_number)
    if com == 10 then
        break
    end
end
disp("SUCESSO")
disp("COM"+string(com))
//closeserial(%serial_port);

//com = 3;
//try
//    %serial_port=openserial(com,"9600,n,8,1");
//catch
//    disp(['Não pode ler serial'])
//end 
//[error_message,error_number]=lasterror(%t)
//disp("ERROR")
//disp(error_message)
//disp(error_number)
//disp(error_number==0)
//closeserial(%serial_port);
