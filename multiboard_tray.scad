/*
Mockedarche multiboard tray file

openscad file for the multiboard tray uses the big threads along with a threaded bolt to attach the tray to the multiboard.
Relatively basic approach but does have nice features like chamfered edges and a front lip to prevent the contents from falling out.

*/

chamfer_height = 20;
chamfer_width = 20;

// Variables that are commonly used
floor_width = 90;
floor_height = 3;
floor_length = 150;


desired_wall_height = 50 + floor_height - 1; 

wall_width = 4;
wall_height = desired_wall_height + floor_height;
wall_length = floor_width + 10;


adjusted_floor_length = floor_length + wall_width;

front_wall_height = wall_height / 3;

x_start = 0;
y_start = 0;

facet_number = 200;

thread_spacing = floor(adjusted_floor_length / 25);


module multiboard_bin() {
    union() {
        // floor
        cube([floor_width + wall_width,adjusted_floor_length,floor_height]);
        // left wall
        translate([x_start,y_start,0]) cube([floor_width + wall_width, wall_width, wall_height]);
        // right wall
        translate([x_start,adjusted_floor_length,0]) cube([floor_width + wall_width, wall_width, wall_height]);
        // back wall
        translate([x_start,0,0]) cube([wall_width, adjusted_floor_length, wall_height]);
        // front wall
        translate([floor_width + wall_width, 0, 0]) cube([wall_width, adjusted_floor_length + (wall_width), front_wall_height]);


        // Horizontal corners
        // left bottom corner fillet
        translate([x_start + wall_width, y_start + (wall_width / 10), floor_height]) rotate([-50, 0, 0]) cube([floor_width, wall_width, wall_width]);
        // right bottom corner fillet
        translate([x_start + wall_width, y_start + adjusted_floor_length - (wall_width / 2), floor_height]) rotate([-50, 0, 0]) cube([floor_width, wall_width, wall_width]);
        // back bottom corner fillet
        translate([x_start + (wall_width / 10), y_start, floor_height]) rotate([0, 50, 0]) cube([wall_width, adjusted_floor_length, wall_width]);
        // front bottom corner fillet
        translate([x_start + floor_width + (wall_width / 2), y_start, floor_height]) rotate([0, 50, 0]) cube([wall_width, adjusted_floor_length, wall_width]);

        // Vertical corners
        // left back corner fillet
        translate([x_start + wall_width, y_start + (wall_width / 10), floor_height]) rotate([-45, -90, 0]) cube([wall_height - floor_height, wall_width, wall_width]);
        // right back corner fillet
        translate([x_start + wall_width, y_start + adjusted_floor_length - (wall_width / 2), floor_height]) rotate([-45, -90, 0]) cube([wall_height - floor_height, wall_width, wall_width]);
        // left front corner fillet
        translate([x_start + wall_width + floor_width, y_start + (wall_width / 10), floor_height]) rotate([-45, -90, 0]) cube([front_wall_height - floor_height, wall_width, wall_width]);
        // right front corner fillet
        translate([x_start + wall_width + floor_width, y_start + adjusted_floor_length - (wall_width / 2), floor_height]) rotate([-45, -90, 0]) cube([front_wall_height - floor_height, wall_width, wall_width]);

    }
}

difference() {
    multiboard_bin();
    // chamfered edges
    //left wall
    //translate([x_start - 1,y_start,wall_height - 5]) rotate([45,0,0]) cube([wall_length + 2, chamfer_width, chamfer_height]);
    // right wall
    //translate([x_start - 1,adjusted_floor_length + wall_width,wall_height - 5]) rotate([45,0,0]) cube([wall_length + 2, chamfer_width, chamfer_height]);
    // back wall
    //translate([x_start - 1,y_start - 1,wall_height - 6]) rotate([0,-45,0]) cube([wall_width *  3, adjusted_floor_length + (chamfer_width*4), chamfer_height]);
    // front wall
    translate([floor_width + wall_width, - wall_width - 1, front_wall_height]) rotate([0,45,0]) cube([wall_width * 2, adjusted_floor_length + (2 * wall_width) + 2, wall_width]);

    // holes for threads
    // if we have enough space for two threads
    if (adjusted_floor_length >= 100 + wall_width){
        translate([0, 26 + (wall_width / 2), wall_height / 2]) rotate([0, 90, 0]) cylinder(h=wall_width * 2, r=12, center=true, $fn=facet_number);
        translate([0, ((thread_spacing - 1) * 26) - (thread_spacing - 2) + (wall_width / 2), wall_height / 2]) rotate([0, 90, 0]) cylinder(h=wall_width * 2, r=12, center=true, $fn=facet_number);
        translate([wall_width + 1, 26 + (wall_width / 2), wall_height / 2]) rotate([0, 90, 0]) cylinder(h=wall_width * 2, r=22, center=true, $fn=facet_number);
        translate([wall_width + 1, ((thread_spacing - 1) * 26) - (thread_spacing - 2) + (wall_width / 2), wall_height / 2]) rotate([0, 90, 0]) cylinder(h=wall_width * 2, r=22, center=true, $fn=facet_number);

    }
    // if we only have enough space for one thread
    else{
        translate([0, adjusted_floor_length / 2 + (wall_width / 2), wall_height / 2]) rotate([0, 90, 0]) cylinder(h=wall_width * 2, r=12, center=true, $fn=facet_number);
        translate([wall_width + 1, adjusted_floor_length / 2 + (wall_width / 2), wall_height / 2]) rotate([0, 90, 0]) cylinder(h=wall_width * 2, r=22, center=true, $fn=facet_number);
    }
}
