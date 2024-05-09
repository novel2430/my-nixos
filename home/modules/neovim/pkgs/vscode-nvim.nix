{vimUtils, fetchFromGithub, ...}:

vimUtils.buildVimPlugin {
  name = "vscode-nvim";
  src = fetchFromGithub {
    owner = "Mofiqul";
    repo = "vscode.nvim";
    rev = "1a2cb491a962acf3bbf53c6d0a61b4ec76012570";
    sha256 = "10l01a8xaivz6n01x6hzfx7gd0igd0wcf9ril0sllqzbq7yx2bbk";
  };
}
