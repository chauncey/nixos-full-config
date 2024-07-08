{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cc";
  home.homeDirectory = "/home/cc";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  #home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  #};
  #home.file = {
  #  ".config/nvim" = {
  #    source = ./config/nvim;
  #    recursive = true;
  #  };
  #};
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/cc/etc/profile.d/hm-session-vars.sh
  #
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    colors = {
      bg = "#24273a";
      "bg+" = "#363a4f";
      spinner = "#f4dbd6";
      hl = "#ed8796";
      fg = "#cad3f5";
      header = "#ed8796";
      info = "#c6a0f6";
      pointer = "#f4dbd6";
      marker = "#f4dbd6";
      "fg+" = "#cad3f5";
      prompt = "#c6a0f6";
      "hl+" = "#ed8796";
    };
    defaultOptions = [
      "--bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"
      "--preview 'cat {}'"
    ];
  };

  programs.git = {
    enable = true;
    userName = "chauncey";
    userEmail = "cchauncey@gmail.com";
    aliases = {
      st = "status -sb";
      co = "checkout";
      cob = "checkout -b";
      cot = "checkout --track";
      can = "commit --amend --no-edit";
      unadd = "reset HEAD";
      br = "branch";
      ci = "commit";
      wtf = "!$ZSH/bin/git-wtf";
      clean-merged = "!git branch -r --merged | xargs -n 1 git branch -d";
      show-files = "!git show --pretty='' --name-only";
    };
    lfs = {
      enable = true;
    };
    extraConfig = {
      core = {
        editor = "nvim";
        excludesfile = "./home-config/.gitignore";
        autocrlf = "input";
        init.defaultBranch = "main";
      };
      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
        interative = "auto";
        ui = true;
        pager = true;
      };
      pull = {
        rebase = true;
      };
      push = {
        default = "current";
      };
    };
  };

  xdg.configFile = {
    nvim = {
      source = config.lib.file.mkOutOfStoreSymlink ./home-config/nvim;
      recursive = true;
    };
  };
  
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.cmake
      pkgs.cargo
    ];
    withPython3 = true;
    withNodeJs = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      aws = {
        disabled = true;
      };
      buf = {
        disabled = true;
      };
      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[>](bold red)";
	#ssh_symbol = "⛺︎ ";
      };
      directory = {
        truncate_to_repo = false;
      };
      dotnet = {
        detect_files = [
          "global.json"
          "Directory.Build.props"
          "Directory.Build.targets"
          "Packages.props"
        ];
      };
      git_branch = {
        symbol = " ";
        truncation_length = 18;
      };
      golang = {
        symbol = " ";
      };
      hostname = {
        ssh_symbol = "⛺️ ";
      };
      lua = {
        symbol = " ";
      };
      nix_shell = {
        symbol = " ";
      };
      package = {
        disabled = true;
      };
    };
  };
  
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
  };

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = builtins.readFile ./home-config/wezterm/wezterm.lua;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    initExtra = ''
      ${builtins.readFile ./home-config/zsh/config.zsh}
      ${builtins.readFile ./home-config/zsh/aliases.zsh}
      ${builtins.readFile ./home-config/zsh/completion.zsh}
      ${builtins.readFile ./home-config/zsh/git.zsh}
      ${builtins.readFile ./home-config/zsh/window.zsh}
    '';
    shellAliases = {
      "c" = "clear";
      "vi" = "nvim";
      "dwc" = ''darwin-rebuild check --flake ".#aarch64"'';
      "dwb" = ''darwin-rebuild switch --flake ".#aarch64"'';
      "ks" = "tmux kill-server";
    };
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "z"];
      theme = "robbyrussell";
    };
  };


}
