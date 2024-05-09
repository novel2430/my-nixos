{lib, ...}:
with lib;
let
  wayfire-config = {
    alpha = {
      min_value = 0.100000;
      modifier = "<alt> <super>";
    };
    animate = {
      close_animation = "zoom";
      duration = 400;
      enabled_for = ''(type equals "toplevel" | (type equals "x-or" & focusable equals true))'';
      fade_duration = 400;
      fade_enabled_for = ''type equals "overlay"'';
      fire_color = "#B22303FF";
      fire_duration = 300;
      fire_enabled_for = "none";
      fire_particle_size = 16.000000;
      fire_particles = 2000;
      open_animation = "zoom";
      random_fire_color = "false";
      startup_duration = 600;
      zoom_duration = 500;
      zoom_enabled_for = "none";
    };
  };
in
{
  home.file."outout.ini".text = 
  let
    renderSection = name: section:
      let
        renderOption = key: value: ''${key} = ${value}'';
      in
      "[${name}]\n" + (concatStringsSep "\n" (mapAttrsToList renderOption section));
  in
  concatStringsSep "\n\n" (mapAttrsToList renderSection wayfire-config);
}
