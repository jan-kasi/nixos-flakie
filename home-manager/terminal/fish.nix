{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAbbrs = {
      nurl = "nix run nixpkgs#nurl ";
      neofetch = "nix run nixpkgs#neofetch";
      "7zz" = "nix run nixpkgs#_7zz --";
      hmsw = "home-manager switch --flake .#jankasi@snow";
      nrsw = "sudo nixos-rebuild switch --flake .#snow";
      cleanboot = "sudo /run/current-system/bin/switch-to-configuration boot";
      nixhist = "sudo nix profile history --profile /nix/var/nix/profiles/system";
      replnix = "nix repl --expr 'import <nixpkgs>{}'";
    };
    functions = {
      fish_greeting = "krabby random";
      # change background color when certain actions performed (sudo)
      sudo = ''
        printf '\x1b]11;rgb:4040/2020/3030\x1b\\'
        command sudo $argv
        printf '\x1b]111\x1b\\'
      '';
    };
    interactiveShellInit = ''
      set FZF_ALT_C_OPTS "--preview 'exa --icons -LT 3 {}'"
      set FZF_CTRL_R_OPTS "--preview 'echo {}' --preview-window up:3:hidden:wrap --bind 'ctrl-/:toggle-preview' --color header:italic --header 'Press CTRL-Y to copy command into clipboard'"
      set FZF_ALT_C_OPTS "--preview 'exa --icons --tree {}'"
    '';
    shellInit = ''
      set fzf_preview_dir_cmd "exa --icons -LT 3"
      set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"
    '';

    plugins = [
      # Enable a plugin from nixpkgs
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "z"; src = pkgs.fishPlugins.z.src; }
      { name = "fzf.fish"; src = pkgs.fishPlugins.fzf-fish.src; }
      { name = "pure"; src = pkgs.fishPlugins.pure.src; }
      { name = "pisces"; src = pkgs.fishPlugins.pisces.src; }
      { name = "puffer"; src = pkgs.fishPlugins.puffer.src; }
    ];
  };
}