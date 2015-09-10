f=figure("dockable","off", "menubar", "none");
f.figure_position = [25, 58];
f.figure_name="Real-time Temperature Monitoring and Control";
f.figure_size = [1200 700];
f.background = color(246,244,242);
f.resize="off";
f.menubar_visible="on";
f.toolbar_visible="off";
f.info_message=f.figure_name
f.tag="mainWindow";
f.closerequestfcn="closeFigure";
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
a.axes_bounds = [0.05, 0.105, 0.25, .95];
a.axes_visible(1) = "off";
a.tag = "liveAxes";
