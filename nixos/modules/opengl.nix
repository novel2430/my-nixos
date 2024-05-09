{ pkgs, ...}:
{
  # OpenGL
  hardware.opengl = {
    package = pkgs.unstable.mesa.drivers;
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
