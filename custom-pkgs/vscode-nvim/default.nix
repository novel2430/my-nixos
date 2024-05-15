{pkgs, ...}:

with pkgs;
vimUtils.buildVimPlugin {
  name = "vscode-nvim";
  src = builtins.fetchGit {
    url = "https://github.com/novel2430/vscode.nvim.git";
    ref = "main";
    rev = "aaac667f49812794f23dd5713840e11b1151a94d";
  };
}
