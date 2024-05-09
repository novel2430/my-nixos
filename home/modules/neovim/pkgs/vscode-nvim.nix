{pkgs, ...}:

with pkgs;
vimUtils.buildVimPlugin {
  name = "vscode-nvim";
  src = fetchgit {
    url = "https://github.com/Mofiqul/vscode.nvim.git";
    hash = "sha256-1CvsM0tQO/BYkFiIM8K9z4ZY7iDP0URrratEzFPq5Dg=";
  };
}
