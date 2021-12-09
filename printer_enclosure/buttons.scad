// Retract | Back | Extrude | Up   | Cool | Pause |
// Left    | Fwd  | Right   | Down | Heat | Home  |
// D | B | U | E | H
// L | F | R | T | C

screen_w = 102;
screen_d = 115;
screen_bend_d = 46;
screen_bend_a = 45; // Need to measure this

cube([screen_w, screen_d, 1]);

rotate([screen_bend_a, 0, 0])
translate([0, -screen_bend_d, 0])
cube([screen_w, screen_bend_d, 1]);










// Home all axes:
// M300 S100 P20 ;quick beep to confirm button press (delete if you find it irritating)
// G28
//
// My unload filament script for TriangleLabs DDE: (if you have ADVANCED_PAUSE_FEATURE enabled in marlin you can use M702)
// M300 S100 P20 ;quick beep to confirm button press (delete if you find it irritating)
// G21
// G90
// G92 E0
// G1 E10 F100 ;extrude a little bit slowly to prevent blob forming (change Exxx for your lenght)
// G92 E0
// G1 E-120 F2000 ;quickly unload the filament (change E-xxx for your lenght)
// G92 E0
// M400
//
// My load filament script for TriangleLabs DDE: (if you have ADVANCED_PAUSE_FEATURE enabled in marlin you can use M701)
// M300 S100 P20 ;quick beep to confirm button press (delete if you find it irritating)
// G21
// G90
// G4 S5
// G92 E0
// G1 E80 F2000 ;quickly insert the filament untill the hotzone (change Exxx for your lenght)
// G92 E0
// G1 E40 F200 ;slowly insert the filament into the hotzone and extrude a little bit more to prime it (change Exxx for your lenght)
// G92 E0
// M400
//
// Preheat nozzle to 200C script:
// M300 S100 P20 ;quick beep to confirm button press (delete if you find it irritating)
// M104 S200 T0 ;change Sxxx for your temperature
//
// Preheat bed to 60C script:
// M300 S100 P20 ;quick beep to confirm button press (delete if you find it irritating)
// M140 S60 ;change Sxxx for your temperature
//
// Cooldown E and Bed:
// M300 S100 P20 ;quick beep to confirm button press (delete if you find it irritating)
// M104 S0; Set Hot-end to 0C (off)
// M140 S0; Set bed to 0C (off)
//
// Disable steppers:
// M300 S100 P20 ;quick beep to confirm button press (delete if you find it irritating)
// M18
//
// Pause print (!YOU NEED ADVANCED_PAUSE_FEATURE IN MARLIN FIRMWARE!):
// M300 S100 P20 ;quick beep to confirm button press (delete if you find it irritating)
// M125
//
// Change Filament (!YOU NEED ADVANCED_PAUSE_FEATURE IN MARLIN FIRMWARE!):
// M300 S100 P20 ;quick beep to confirm button press (delete if you find it irritating)
// M600
