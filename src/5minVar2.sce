subplot(224);
a = gca();
a.axes_bounds = bottom_axes_bounds;
a.tight_limits="on";
a.axes_reverse = ['on', 'off', 'off'];
a.grid=[-1, color("darkgrey")]
a.tag = "sensor2Axes";
plot2d(0:timeBuffer2, zeros(1,timeBuffer2 + 1)-50, color("red"));
a.title.text="Temperature variations of the sensor 2";
a.data_bounds = [0, minTempDisplay2; timeBuffer2, maxTempDisplay2];
e = gce();
e = e.children(1);
e.tag = "Sensor2";
//
a = newaxes();
a.y_location = "right";
a.filled = "off" 
a.grid=[-1, color("lightblue")]
a.tag = "sensor2NewAxes";
a.tight_limits="on"
a.axes_bounds = bottom_axes_bounds;
plot2d(0:timeBuffer2, zeros(1,timeBuffer2 + 1)-50, color("blue"));
a.data_bounds = [0, minRegulationDisplay2; timeBuffer2, maxRegulationDisplay2];
a.axes_visible(1) = "off";
a.foreground=color("blue");
a.font_color=color("blue");
e = gce();
e = e.children(1);
e.tag = "minute2Regulation";
