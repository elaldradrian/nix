{
  plugins.tmux-navigator = {
    enable = true;
    settings = {
      no_mappings = 1;
      no_wrap = 1;
    };
    keymaps = [
      {
        action = "left";
        key = "<C-left>";
      }
      {
        action = "down";
        key = "<C-down>";
      }
      {
        action = "up";
        key = "<C-up>";
      }
      {
        action = "right";
        key = "<C-right>";
      }
    ];
  };
}
