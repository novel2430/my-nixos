{pkgs, ...}:

with pkgs;
vimUtils.buildVimPlugin {
  name = "vscode-nvim";
  src = fetchgit {
    url = "https://github.com/Mofiqul/vscode.nvim.git";
    hash = "sha256-NNgvYuinSiLEX0x1eSjJHGU7frzwZriMhz9PKF7yWtY=";
  };
}
