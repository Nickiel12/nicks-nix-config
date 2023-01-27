{ pkgs, lib, ... }:
let

  configRepoUrl = "https://github.com/Nickiel12/Nicks-Doom";
  git = "${pkgs.git}/bin/git";

in
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
  };
  services.emacs.enable = true;
    home.activation.doom = lib.hm.dag.entryAfter["writeBoundary"] ''
    if [ ! -d .emacs.d ]; then
       ${git} clone --depth 1 https://github.com/doomemacs/doomemacs .emacs.d
    fi
    mkdir -p .doom.d
    ${git} clone ${configRepoUrl} .doom.d
  '';

  home.packages = with pkgs; [
    # Doom Emacs fonts, manually installed with
    # M-x all-the-icons-install-fonts
    emacs-all-the-icons-fonts
  ];
}
