{
  pkgs,
  config,
  lib,
  homeDir,
  ...
}:
let
  onePasswordSign =
    if pkgs.stdenv.isDarwin then
      "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
    else
      "${pkgs._1password-gui}/bin/op-ssh-sign";
in
{
  config = {
    sops = {
      secrets = {
        private_email = { };
        private_signingkey = { };
        work_email = lib.mkIf (config.opt.features.work-machine.enable) { };
        work_signingkey = lib.mkIf (config.opt.features.work-machine.enable) { };
      };

      templates = {
        # Private PC
        private-git-config.content = lib.generators.toINI { } {
          user = {
            email = config.sops.placeholder.private_email;
            name = "Rune Dahl Billeskov";
            signingkey = config.sops.placeholder.private_signingkey;
          };
          commit.gpgsign = true;
          gpg.format = "ssh";
          "gpg \"ssh\"".program = onePasswordSign;
        };

        # Work PC
        work-git-config = lib.mkIf (config.opt.features.work-machine.enable) {
          content = lib.generators.toINI { } {
            user = {
              email = config.sops.placeholder.work_email;
              name = "Rune Dahl Billeskov";
              signingkey = config.sops.placeholder.work_signingkey;
            };
            commit.gpgsign = true;
            gpg.format = "ssh";
            "gpg \"ssh\"".program = onePasswordSign;
          };
        };
      };
    };

    programs.git = {
      enable = true;
      includes = (
        if config.opt.features.work-machine.enable then
          [
            # Private
            {
              path = config.sops.templates.private-git-config.path;
              condition = "gitdir:${homeDir}/private/";
            }
            # Work
            {
              path = config.sops.templates.work-git-config.path;
              condition = "gitdir:${homeDir}/work/";
            }
          ]
        else
          [
            # Private
            {
              path = config.sops.templates.private-git-config.path;
              condition = "gitdir:${homeDir}/private/";
            }
          ]
      );
    };
  };
}
