{pkgs, ...}:

with pkgs;
vimUtils.buildVimPlugin {
  name = "vscode-nvim";
  src = builtins.fetchGit {
    url = "https://github.com/Mofiqul/vscode.nvim.git";
    ref = "main";
    rev = "1a2cb491a962acf3bbf53c6d0a61b4ec76012570";
  };
}
