timeBuffer = 300;
subplot(224);
a = gca();
a.axes_bounds = bottom_axes_bounds;
a.tight_limits="on";
a.axes_reverse = ['on', 'off', 'off'];
a.grid=[-1, color("darkgrey")]
a.tag = "sensor2Axes";
plot2d(0:timeBuffer, zeros(1,timeBuffer + 1), color("red"));
a.title.text="Temperature variations in the last 5 minutes";
a.data_bounds = [0, minTempDisplay; timeBuffer, maxTempDisplay];
e = gce();
e = e.children(1);
e.tag = "Sensor2";
//
a = newaxes();
a.y_location = "right";
a.filled = "off" 
a.grid=[-1, color("lightblue")]
a.tight_limits="on"
a.axes_bounds = bottom_axes_bounds;
plot2d(0:timeBuffer, zeros(1,timeBuffer + 1), color("blue"));
a.data_bounds = [0, minRegulationDisplay; timeBuffer, maxRegulationDisplay];
a.axes_visible(1) = "off";
a.foreground=color("blue");
a.font_color=color("blue");
e = gce();
e = e.children(1);
e.tag = "minute2Regulation";
