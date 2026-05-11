{pkgs, ...}: let
  treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.c
    p.cpp
    p.python
    p.nix
    p.lua
    p.markdown
    p.markdown_inline
    p.bash
    p.json
    p.yaml
    p.toml
  ]);
  textobjects = pkgs.vimPlugins.nvim-treesitter-textobjects;
in {
  programs.neovim = {
    enable = true;
    plugins = [treesitter textobjects];
  };
}
