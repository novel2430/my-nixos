{lib, ...}:
with lib;
let
  wayfire-config = {
    example = {
      aaa = "bbb";
      bbb = "aaa";
    };
  };
in
{
  home.file."outout".text = 
  let
    renderSection = name: section:
      let
        renderOption = key: value ''${key}=${value}'';
      in
      "[${name}]\n" + (concatStringsSep "\n" (mapAttrsToList renderOption section));
  in
  concatStringsSep "\n\n" (mapAttrsToList renderSection wayfire-config);
}
