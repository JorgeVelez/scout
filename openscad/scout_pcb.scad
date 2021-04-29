/* TODO: extract into common parts repo */
use <../../apc/openscad/pcb.scad>;
use <../../poly555/openscad/lib/switch.scad>;

PCB_WIDTH = 177.292 - 32.004;
PCB_LENGTH = 126.365 - 83.566;
PCB_HEIGHT = 1.6;

function _(xy, nudge = [0, 0]) = (
    [(xy.x + nudge.x - 32.004), -(xy.y - 123.444) + nudge.y]
);

PCB_BUTTON_POSITIONS = [
    _([170.942 + 2.54 * .9, 121.92 - 2.54 * 2.45]),
    _([163.322 + 2.54 * .9, 121.92 - 2.54 * 2.45]),
    _([155.702 + 2.54 * .9, 121.92 - 2.54 * 2.45]),
    _([148.082 + 2.54 * .9, 121.92 - 2.54 * 2.45]),
    _([140.462 + 2.54 * .9, 121.92 - 2.54 * 2.45]),
    _([125.222 + 2.54 * .9, 121.92 - 2.54 * 2.45]),
    _([117.602 + 2.54 * .9, 121.92 - 2.54 * 2.45]),
    _([109.982 + 2.54 * .9, 121.92 - 2.54 * 2.45]),
    _([102.362 + 2.54 * .9, 121.92 - 2.54 * 2.45]),
    _([94.742 + 2.54 * .9, 121.92 - 2.54 * 2.45]),
    _([87.122 + 2.54 * .9, 121.92 - 2.54 * 2.45]),
    _([79.502 + 2.54 * .9, 121.92 - 2.54 * 2.45]),
    _([64.262 + 2.54 * .9, 121.92 - 2.54 * 2.45]),
    _([56.642 + 2.54 * .9, 121.92 - 2.54 * 2.45]),
    _([49.022 + 2.54 * .9, 121.92 - 2.54 * 2.45]),
    _([41.402 + 2.54 * .9, 121.92 - 2.54 * 2.45]),
    _([33.782 + 2.54 * .9, 121.92 - 2.54 * 2.45]),
];

PCB_HOLE_DIAMTER = 3.2;
PCB_HOLE_POSITIONS = [
    _([138.938, 107.696 - 2.9]),
    _([104.648, 107.696 - 2.9]),
    _([173.228, 107.696 - 2.9]),
    _([36.068, 107.696 - 2.9]),
    _([70.358, 107.696 - 2.9]),
];

PCB_LED_POSITION = _([37.338 - 2.54 * .75, 93.446], [0, 2.9]);
PCB_POT_POSITION = _([172.824 - 2.54, 97.096 - 7], [-.104, 2.9]);

PCB_SWITCH_POSITION = _([44.45, 97.345], [0, 2.9]);

LED_DIAMETER = 5.9;
LED_HEIGHT = 8.6;

PTV09A_POT_BASE_WIDTH = 10;
PTV09A_POT_BASE_HEIGHT = 6.8;
PTV09A_POT_ACTUATOR_DIAMETER = 6;
PTV09A_POT_ACTUATOR_BASE_DIAMETER = 6.9;
PTV09A_POT_ACTUATOR_BASE_HEIGHT = 2;
PTV09A_POT_ACTUATOR_HEIGHT = 20 - PTV09A_POT_BASE_HEIGHT;
PTV09A_POT_ACTUATOR_D_SHAFT_HEIGHT = 7;
PTV09A_POT_ACTUATOR_D_SHAFT_DEPTH = PTV09A_POT_ACTUATOR_DIAMETER - 4.5;

BUTTON_HEIGHT = 6;

module scout_pcb(
    show_buttons = true,
    show_silkscreen = true,
    show_led = true,
    show_pot = true,
    show_switch = true
) {
    e = .0943;
    silkscreen_height = e;

    difference() {
        union() {
            color("purple") cube([PCB_WIDTH, PCB_LENGTH, PCB_HEIGHT]);

            if (show_silkscreen) {
                translate([0, 0, PCB_HEIGHT - e]) {
                    linear_extrude(silkscreen_height + e) {
                        offset(e) {
                            import("../scout-brd.svg");
                        }
                    }
                }
            }
        }

        for (xy = PCB_HOLE_POSITIONS) {
            translate([xy.x, xy.y, -e]) {
                cylinder(
                    d = PCB_HOLE_DIAMTER,
                    h = PCB_HEIGHT + e * 2 + 3,
                    $fn = 12
                );
            }
        }
    }

    if (show_buttons) {
        for (xy = PCB_BUTTON_POSITIONS) {
            translate([xy.x, xy.y, PCB_HEIGHT - e]) {
                % cylinder(
                    h = 6 + e,
                    d = BUTTON_HEIGHT
                );
            }
        }
    }

    if (show_led) {
        translate([PCB_LED_POSITION.x, PCB_LED_POSITION.y, PCB_HEIGHT - e]) {
            % cylinder(
                d = LED_DIAMETER,
                h = LED_HEIGHT + e,
                $fn = 12
            );
        }
    }

    if (show_pot) {
        translate([PCB_POT_POSITION.x, PCB_POT_POSITION.y, PCB_HEIGHT - e]) {
            % pot();
        }
    }

    if (show_switch) {
        translate([PCB_SWITCH_POSITION.x, PCB_SWITCH_POSITION.y, e]) {
            mirror([0, 0, 1]) mirror([0, 1, 0]) {
                % switch();
            }
        }
    }
}