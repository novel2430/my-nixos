{pkgs, lib, opt-config,  ... }:
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    oh-my-zsh.enable = true;
    oh-my-zsh.plugins = [ "git" ];
    oh-my-zsh.theme = "robbyrussell";
    syntaxHighlighting.enable = true;
    initExtra = lib.mkMerge [
      (lib.mkIf (opt-config.use-proxy == true) ''
        export http_proxy="${opt-config.http-proxy}"
        export https_proxy="${opt-config.https-proxy}"
      '')
      # Other Stuff
      (''
        export EDITOR="nvim"
      '')
      # FZF Stuff
      (''
        export FZF_COMPLETION_TRIGGER='\'
        # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
        # - The first argument to the function ($1) is the base path to start traversal
        # - See the source code (completion.{bash,zsh}) for the details.
        _fzf_compgen_path() {
          fd --follow --exclude ".git" . "$1"
        }

        # Use fd to generate the list for directory completion
        _fzf_compgen_dir() {
          fd --type d --follow --exclude ".git" . "$1"
        }
      '')
    ];
  };
}
