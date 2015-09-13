subplot(222);
a = gca();
a.axes_bounds = top_axes_bounds;
a.tight_limits="on";
a.axes_reverse = ['on', 'off', 'off'];
a.grid=[-1, color("darkgrey")]
a.tag = "sensor1Axes";
plot2d(0:timeBuffer, zeros(1,timeBuffer + 1)-50, color("red"));
a.title.text="Temperature variations of the sensor 1";
a.data_bounds = [0, minTempDisplay; timeBuffer, maxTempDisplay];
e = gce();
e = e.children(1);
e.tag = "Sensor1";
//
a = newaxes();
a.y_location = "right";
a.filled = "off" 
a.grid=[-1, color("lightblue")]
a.tag = "sensor1NewAxes";
a.tight_limits="on"
a.axes_bounds = top_axes_bounds;
plot2d(0:timeBuffer, zeros(1,timeBuffer + 1)-50, color("blue"));
a.data_bounds = [0, minRegulationDisplay; timeBuffer, maxRegulationDisplay];
a.axes_visible(1) = "off";
a.foreground=color("blue");
a.font_color=color("blue");
e = gce();
e = e.children(1);
e.tag = "minute1Regulation";
