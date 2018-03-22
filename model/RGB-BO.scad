$fn = 40;

module body(
  body_height,
  body_width,
  body_depth,
  body_taper,
  mount_radius,
  mount_protude,
  ) {
  hull() {
    linear_extrude(height=body_height, scale=body_taper) {
      square([body_depth, body_width], center=true);
    }
    cylinder(r=mount_radius, h=body_height+mount_protude);
  }
  translate([0, 0, body_height+mount_protude]) {
    sphere(r=mount_radius);
  }
}

module eye(
  base_radius,
  base_protude,
  inner_radius,
  inner_protude,
  right_from_center,
  height_from_base,
  ) {
  hull() {
    translate([0, right_from_center, height_from_base]) {
      rotate(90, [0, 1, 0]) {
        cylinder(r=base_radius, h=base_protude);
      }
    }
    translate([0, right_from_center, height_from_base]) {
      rotate(90, [0, 1, 0]) {
        cylinder(r=inner_radius, h=base_protude + inner_protude);
      }
    }
  }
}

module mouth(
  width,
  height,
  droop,
  base_protude,
  height_from_base) {
  translate([0, 0, height_from_base+height]) {
    rotate(90, [0, 0, 1]) {
      rotate(90, [1, 0, 0]) {
        difference() {
          difference() {
            scale([1, 2*height/width, 1]) {
              cylinder(r=width/2,h=base_protude);
            }
            translate([0, 0, -0.01]) {
              scale([1, 2*droop/width, 1.02]) {
                cylinder(r=width/2,h=base_protude);
              }
            }
          }
          translate([-0.5*width, 0, 0]) {
            translate([0, 0, -0.01]) {
              scale([1, 1, 1.02]) {
                cube([width, height, base_protude]);
              }
            }
          }    
        }
      }
    }
  }
}

module RGB_BO (
  body_height,
  body_width,
  body_depth,
  body_taper,
  mount_radius,
  mount_protude,
  face_feature_protude,
  left_eye_radius,
  right_eye_radius,
  eye_off_center,
  eye_height_from_base,
  eyeball_radius,
  eyeball_protude,
  mouth_height,
  mouth_droop,
  mouth_width,
  mouth_height_from_base,
  ) {
  
  body(
    body_height,
    body_width,
    body_depth,
    body_taper,
    mount_radius,
    mount_protude);
  
  mouth(
    mouth_width,
    mouth_height,
    mouth_droop,
    face_feature_protude + eyeball_protude,
    mouth_height_from_base);
  
  eye(
    left_eye_radius,
    face_feature_protude,
    eyeball_radius,
    eyeball_protude,
    -1 * eye_off_center,
    eye_height_from_base);
  
  eye(
    right_eye_radius,
    face_feature_protude,
    eyeball_radius,
    eyeball_protude,
    eye_off_center,
    eye_height_from_base);
}

RGB_BO(
  body_height=16,
  body_width=15,
  body_depth=10,
  body_taper=0.8,
  
  mount_radius=3,
  mount_protude=1,
  face_feature_protude=5,
  left_eye_radius=2,
  right_eye_radius=2.5,
  eye_off_center=3,
  eye_height_from_base=11,
  eyeball_radius=1.5,
  eyeball_protude=0.5,
  mouth_height=5,
  mouth_droop=2,
  mouth_width=9,
  mouth_height_from_base=2);
