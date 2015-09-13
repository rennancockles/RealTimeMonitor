a = newaxes();
bar(.5,0,'blue');
e = gce();
e = e.children(1);
e.tag = "instantSensor2";
//
plot([0, 1], [%MinTemp2, %MinTemp2]);
e = gce();
e = e.children(1);
e.tag = "instantMinTemp2";
e.line_style = 5;
e.thickness = 2;
e.foreground = color("orange");
//
plot([0, 3], [%MaxTemp2, %MaxTemp2]);
e = gce();
e = e.children(1);
e.tag = "instantMaxTemp2";
e.line_style = 5;
e.thickness = 2;
e.foreground = color("red");
//
a.data_bounds = [0, minTempDisplay2; 1, maxTempDisplay2];
a.grid = [-1, color("darkgrey")];
a.axes_bounds = [.765, 0.105, 0.25, .95];
a.axes_visible(1) = "off";
a.tag = "liveAxes2";
a.tight_limits="on";
