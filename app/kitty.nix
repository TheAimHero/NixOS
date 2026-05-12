{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    font = {
      name = "ComicShannsMono Nerd Font";
      package = pkgs.nerd-fonts.comic-shanns-mono;
      size = 12;
    };
    settings = {
      copy_on_select = "yes";
      allow_remote_control = "socket-only";
      listen_on = "unix:/tmp/kitty";
      enabled_layouts = "splits, stack";
      layout = "splits";
      undercurl_style = "thin-sparse";
      cursor_beam_thickness = "1.0";
      cursor_underline_thickness = "1.0";
      cursor_blink_interval = 0;
      scrollback_lines = 20000;
      wheel_scroll_multiplier = "5.0";
      wheel_scroll_min_lines = 3;
      confirm_os_window_close = 0;
      mouse_hide_wait = "1.0";
      open_url_with = "default";
      enable_audio_bell = "no";
      url_prefixes = "file ftp ftps gemini git gopher http https irc ircs kitty mailto news sftp ssh";
      detect_urls = "yes";
      show_hyperlink_targets = "yes";
      mouse_map = "ctrl+left release grabbed,ungrabbed mouse_handle_click link";
      strip_trailing_spaces = "always";
      select_by_word_characters = "-";
      focus_follows_mouse = "no";
      pointer_shape_when_grabbed = "arrow";
      default_pointer_shape = "beam";
      pointer_shape_when_dragging = "hand";
      tab_bar_min_tabs = 1;
      background_opacity = "0.8";
      dynamic_background_opacity = "yes";
    };
    shellIntegration.enableZshIntegration = true;
    keybindings = {
      # Font size
      "ctrl+equal" = "change_font_size all +1.0";
      "ctrl+minus" = "change_font_size all -1.0";
      "ctrl+0" = "change_font_size all 0";

      # Splits (like tmux: C-a v = split-h, C-a x = split-v)
      "ctrl+shift+enter" = "launch --location=vsplit --cwd=current";
      "ctrl+shift+x" = "launch --location=hsplit --cwd=current";

      # Zoom / fullscreen toggle (like tmux: C-a C-f)
      "ctrl+shift+f" = "toggle_layout stack";

      # Navigate panes (like tmux C-h/j/k/l with nvim-tmux integration)
      "ctrl+shift+h" = "neighboring_window left";
      "ctrl+shift+j" = "neighboring_window down";
      "ctrl+shift+k" = "neighboring_window up";
      "ctrl+shift+l" = "neighboring_window right";
    };
  };
}
