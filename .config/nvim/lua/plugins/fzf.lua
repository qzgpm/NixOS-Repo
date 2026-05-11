return {
  { "junegunn/fzf", build = "./install --bin" },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    cmd = { "Files", "Rg", "Buffers", "Commands" },
  },
}
