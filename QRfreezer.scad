// This doesn't work in customizer, you'll need to download OpenSCAD, input values as appropriate at the top of the file, press F6 for it to render, then press the "STL" button on the top bar to generate a STL.
//
// After a friend sent me a photo of a coaster with a QR Code, I wanted one of my own, so I designed this.
//
// Using ridercz's OpenSCAD QR Code generator, you can generate your own WiFi QR Code and have it on a coaster. You can also optionally have the credentials in plain text on the coaster, and have a space left open inside the coaster for you to insert a NFC sticker. Everything is configurable, so you could set this up however you like (maybe WiFi placemats? who knows.).
//
// You will need to insert color changes and ideally have some white and black filament for this to work well. You can generate a color change easily by using Prusas ColorPrint page at
// https://www.prusaprinters.org/color-print/
//
// If you opt to have a NFC sticker, use ColorPrint to add another "color change" just before the compartment gets closed. The printer will pause enabling you to insert the NFC sticker before it gets printed over.
//
// To obtain your QR_DATA go to
// https://ridercz.github.io/OpenSCAD-QR/
// and enter a valid WiFi URI, see
// https://github.com/zxing/zxing/wiki/Barcode-Contents#wifi-network-config-android
// for how to write WiFi syntax. A valid example would be WIFI:T:WPA;S:MyRouter;P:SecretPassword;;
//
// Have fun! :)





$fn=128;

// Width of the coaster
WIDTH = 80;
// Height of the coaster
HEIGHT = 80;
// Thickness of the base (white) part of the coaster
BASE_THICKNESS = 4;
// Thickness of the boarder around the edge of the coaster
BORDER = 2;
// Thickness of the QR code
QR_THICKNESS = 0.4;
// Margin around the QR Code
MARGIN = 2;
// Rounded corners on the edge of the coaster
ROUNDED_CORNERS = 5;
// Rounded corners on the inside of the boarder
INNER_ROUNDED_CORNERS = 3;
// Make a hole for placing an NFC sticker inside the coaster
NFC_SIZE = [31, 1.5];
// QR Data, see item description for how to obtain
// Freezer Doc
// g = "https://docs.google.com/spreadsheets/d/1_5_7lCFLuCVkoOwJttd7lWXHpR27IYH-pm-2Oe96CqY/edit"
// puts QrCode.new.qr(url: g, size: 5).to_s.gsub(" ", "0").gsub("x", "1").split("\n").map {|r|"[#{r.split('').join(',')}],"}
QR_DATA = [
[1,1,1,1,1,1,1,0,1,0,1,0,1,1,0,0,1,1,1,0,1,1,1,0,0,0,0,0,1,0,1,1,1,1,1,1,1],
[1,0,0,0,0,0,1,0,0,1,1,1,1,0,1,0,0,1,0,0,0,1,1,1,1,0,0,0,0,0,1,0,0,0,0,0,1],
[1,0,1,1,1,0,1,0,1,1,1,0,0,1,1,0,0,0,1,0,1,0,1,1,0,1,1,0,1,0,1,0,1,1,1,0,1],
[1,0,1,1,1,0,1,0,1,1,1,0,1,1,1,1,0,0,0,0,1,0,1,0,1,1,1,0,0,0,1,0,1,1,1,0,1],
[1,0,1,1,1,0,1,0,1,0,0,1,1,0,0,1,1,0,1,1,1,1,0,1,1,0,1,1,1,0,1,0,1,1,1,0,1],
[1,0,0,0,0,0,1,0,0,0,1,1,0,1,1,0,0,0,0,1,0,1,1,0,1,1,1,0,0,0,1,0,0,0,0,0,1],
[1,1,1,1,1,1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1,1,1,1,1,1],
[0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,1,1,1,1,0,1,1,1,0,0,1,0,0,0,0,0,0,0,0,0],
[1,1,1,1,0,0,1,0,1,0,1,1,1,1,0,0,1,0,1,1,1,1,0,0,1,0,1,0,0,1,0,0,1,1,1,0,1],
[1,1,1,1,1,1,0,0,0,1,1,0,1,1,0,0,1,1,1,1,0,0,0,1,0,0,1,0,1,0,0,1,0,1,1,1,0],
[1,1,0,1,1,1,1,0,0,1,1,1,1,1,0,0,1,1,0,0,1,1,1,1,0,0,0,0,0,0,0,0,1,0,1,1,0],
[0,0,1,0,0,0,0,1,0,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,1,1,0,0,0,1,0,0,1,0,1,1,1],
[0,1,0,0,1,1,1,1,0,1,0,0,1,0,1,0,0,1,1,0,1,1,1,1,1,1,1,1,0,0,1,0,1,1,1,0,1],
[0,0,0,0,0,1,0,0,0,1,1,1,1,0,1,1,0,0,0,0,0,1,0,1,1,0,0,1,1,1,1,1,1,1,1,0,1],
[0,1,0,1,0,0,1,1,1,0,1,1,0,1,0,0,0,0,1,1,0,1,0,0,0,0,0,0,0,1,1,0,1,1,0,1,0],
[0,1,1,1,1,0,0,0,0,1,0,1,0,0,1,1,0,0,0,0,0,1,1,1,0,0,1,1,0,0,0,1,0,1,0,0,1],
[0,0,1,0,0,1,1,0,0,0,1,0,1,0,1,1,1,0,1,0,0,1,1,1,0,1,1,0,0,0,0,0,0,0,1,1,0],
[0,0,1,0,1,0,0,0,1,1,0,0,0,0,1,0,0,0,1,0,1,0,0,0,1,0,0,1,0,0,1,0,0,1,0,1,1],
[1,0,0,0,0,0,1,0,1,0,0,0,0,1,1,1,1,0,1,0,0,0,1,0,0,1,1,1,1,0,1,1,1,0,1,1,1],
[1,1,1,1,1,1,0,0,1,0,1,1,0,1,1,0,0,1,0,0,1,0,1,0,0,0,0,0,1,0,1,1,0,1,0,1,0],
[0,1,0,0,1,0,1,0,1,1,1,0,0,1,1,0,0,1,1,0,0,0,0,0,0,0,1,0,1,1,0,1,1,0,0,1,0],
[1,0,1,1,1,0,0,1,1,0,1,0,0,0,0,0,1,1,1,0,1,0,0,0,0,0,0,0,1,0,0,1,0,0,0,1,0],
[1,1,0,0,0,0,1,0,1,0,1,0,0,0,1,0,1,1,1,0,1,1,0,1,0,0,0,0,0,0,1,1,0,0,0,0,0],
[1,1,0,0,0,0,0,1,1,0,0,1,1,1,1,1,1,0,1,1,0,0,1,0,1,1,0,1,1,1,1,0,1,1,1,0,0],
[0,1,1,1,0,0,1,1,0,0,1,1,0,0,0,1,0,1,1,1,1,0,1,1,1,1,0,1,1,1,1,0,1,1,1,1,1],
[0,1,0,0,1,0,0,0,1,0,1,1,0,1,0,0,1,0,0,0,0,0,1,0,1,1,1,1,1,1,1,1,1,1,1,0,1],
[0,1,1,1,0,0,1,1,1,1,0,0,1,0,1,0,1,0,1,1,1,0,0,0,1,0,1,0,1,1,1,0,1,1,0,1,0],
[1,0,0,1,0,1,0,1,1,1,1,0,1,1,0,0,1,0,0,1,1,1,0,1,0,0,1,1,0,1,1,1,0,0,0,0,1],
[0,0,1,0,0,1,1,0,0,0,1,1,0,0,0,0,1,0,0,0,0,1,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1],
[0,0,0,0,0,0,0,0,1,0,1,0,1,1,0,1,1,0,1,1,1,0,0,1,0,1,1,1,1,0,0,0,1,0,1,0,1],
[1,1,1,1,1,1,1,0,0,1,1,1,1,0,0,1,1,1,1,0,0,1,1,0,0,0,0,0,1,0,1,0,1,0,1,1,1],
[1,0,0,0,0,0,1,0,0,1,1,0,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,1,1,0,0,0,1,1,0,1,0],
[1,0,1,1,1,0,1,0,0,0,0,1,1,1,0,1,0,0,1,0,0,1,0,1,1,1,1,0,1,1,1,1,1,1,0,0,1],
[1,0,1,1,1,0,1,0,1,1,0,0,1,1,1,0,0,1,1,1,1,1,0,0,0,1,1,0,1,0,1,0,1,1,0,1,1],
[1,0,1,1,1,0,1,0,1,0,0,1,1,1,0,0,1,0,1,0,0,0,1,1,1,1,0,0,0,1,1,1,1,1,1,0,0],
[1,0,0,0,0,0,1,0,1,1,1,0,0,0,0,0,0,0,1,0,1,0,1,0,1,1,1,1,0,1,1,1,1,0,1,0,0],
[1,1,1,1,1,1,1,0,1,0,0,0,1,0,1,1,0,1,0,0,1,0,0,0,0,1,0,0,0,1,0,1,1,1,1,1,1]
];

QR_BIT_WIDTH = len(QR_DATA);
QR_WIDTH = WIDTH - BORDER * 2 - MARGIN * 2;
QR_HEIGHT = HEIGHT - BORDER * 2 - MARGIN * 2;

color("black") {
  // QR Render
  translate([BORDER + MARGIN, BORDER + MARGIN, BASE_THICKNESS]) {
    scale([QR_WIDTH / QR_BIT_WIDTH, QR_HEIGHT / QR_BIT_WIDTH, 1.0*QR_THICKNESS]) {
      qr_render(QR_DATA);
    }
  }
  // Border
  translate([0, 0, BASE_THICKNESS]) {
    difference() {
      base([WIDTH, HEIGHT, QR_THICKNESS], ROUNDED_CORNERS);

      translate([BORDER, BORDER, -1])
      base([WIDTH-(BORDER*2), HEIGHT-(BORDER*2), QR_THICKNESS+2], INNER_ROUNDED_CORNERS);
    }
  }
}

// BASE
color("white") {
  difference() {
    base([WIDTH, HEIGHT, BASE_THICKNESS], ROUNDED_CORNERS);
    translate([WIDTH/2, HEIGHT/2, BASE_THICKNESS/2]) {
      #cylinder(r=NFC_SIZE[0]/2, h=NFC_SIZE[1], center=true);
    }
  }
}

module base(xyz, radius) {
  if (radius > 0) {
    hull() {
      translate([radius, radius, 0])
      cylinder(r=radius, h=xyz[2]);
      translate([xyz[0]-radius, radius, 0])
      cylinder(r=radius, h=xyz[2]);
      translate([xyz[0]-radius, xyz[1]-radius, 0])
      cylinder(r=radius, h=xyz[2]);
      translate([radius, xyz[1]-radius, 0])
      cylinder(r=radius, h=xyz[2]);
    }
  } else {
    cube(xyz);
  }
}

// QR code rendering method
module qr_render(data, module_size = 1, height = 1) {
  maxmod = len(data) - 1;
  for(r = [0 : maxmod]) {
    for(c = [0 : maxmod]) {
      if(data[r][c] == 1){
        xo = c * module_size;
        yo = (maxmod - r) * module_size;
        translate([xo, yo, 0]) cube([module_size, module_size, height]);
      }
    }
  }
}
