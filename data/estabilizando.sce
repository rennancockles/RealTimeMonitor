close
clear
clearglobal
clc

M = csvRead("tempData_Geladeira_Estabilizando.csv", ";");
tempo = M(:,1)
T_freezer = M(:,2)
T_geladeira = M(:,3)


// --||-- PLOT --||--


//subplot(2,1,1)
plot (tempo, T_freezer,'-b' )
//plot (20*ones(1,2), [-20,35],'-k' )
xlabel("tempo (s)")
ylabel("temperatura (ºC)")
xtitle("Estabilização da temperatura do freezer")
xgrid(16)

a = gca()
a.data_bounds = [0,-15;420,32]
a.tight_limits = 'on'

////subplot(2,1,2)
//plot (tempo, T_geladeira,'-r' )
////plot (20*ones(1,2), [-20,35],'-k' )
//xlabel("tempo (s)")
//ylabel("temperatura (ºC)")
//xtitle("Estabilização da temperatura da geladeira")
//xgrid(16)
//
//b = gca()
//b.data_bounds = [0,10;420,27]
//b.tight_limits = 'on'


