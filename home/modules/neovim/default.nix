{ pkgs, custom-pkgs, ... }:
{
  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    buildJdtConfig = import ./lsp-jdtls.nix;
  in
  {
    enable = true;
    # Custom Plugin Package add to nixpkgs
     
    # Language Server Package
    extraPackages = with pkgs; [
      lua-language-server # Lua
      nodePackages_latest.pyright # Python
      clang-tools # C family
      jdt-language-server # Java
      nil # Nix
      nodePackages.bash-language-server # Bash
      rust-analyzer # Rust
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./options/basic-autocommand.lua}
      ${builtins.readFile ./options/basic-keymap.lua}
      ${builtins.readFile ./options/options.lua}
    '';
    plugins = with pkgs.vimPlugins; [
      # nvim-autopairs
      {
        plugin = nvim-autopairs;
        config = toLuaFile ./plugins/autopairs.lua;
      }
      # nvim-cmp
      luasnip
      cmp-nvim-lsp
      cmp-path
      {
        plugin = nvim-cmp;
        config = toLuaFile ./plugins/cmp.lua;
      }
      # nvim-telescope
      telescope-ui-select-nvim
      nvim-web-devicons
      plenary-nvim
      {
        plugin = telescope-nvim;
        config = toLuaFile ./plugins/telescope.lua;
      }
      # LSP
      {
        plugin = nvim-lspconfig;
        config = (toLuaFile ./plugins/lsp.lua) + 
          (
            toLua (
              buildJdtConfig {
                java = pkgs.jdk17; # Change to your JDK
                jdt = pkgs.jdt-language-server;
              }
            )
          )
        ;
      }
      # treesitter
      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
          p.tree-sitter-jsonc
          p.tree-sitter-yaml
          p.tree-sitter-xml
          p.tree-sitter-ninja
          p.tree-sitter-meson
          p.tree-sitter-markdown
          p.tree-sitter-java
          p.tree-sitter-html
          p.tree-sitter-css
          p.tree-sitter-cpp
          p.tree-sitter-cmake
          p.tree-sitter-c
        ]));
        config = toLuaFile ./plugins/treesitter.lua;
      }
      # indent-blankline (Blank Line)
      {
        plugin = indent-blankline-nvim;
        config = toLuaFile ./plugins/indent-blankline.lua;
      }
      # Comment.nvim
      {
        plugin = comment-nvim;
        config = toLuaFile ./plugins/comment.lua;
      }
      # markdown-preview
      markdown-preview-nvim
      # Vscode colorscheme
      {
        plugin = custom-pkgs.vscode-nvim;
        config = toLuaFile ./plugins/vscode-nvim.lua;
      }
      # rustaceanvim (rust tools)
      # {
      #   plugin = rustaceanvim;
      # }
    ];
  };
}
