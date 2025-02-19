{
  config,
  lib,
  homeDir,
  ...
}:
{
  config = {
    sops = {
      secrets = {
        private_email = { };
        work_email = lib.mkIf (config.opt.features.work-machine.enable) { };
      };

      templates = {
        # Private PC
        private-git-config.content = lib.generators.toINI { } {
          user = {
            email = config.sops.placeholder.private_email;
            name = "Rune Dahl Billeskov";
          };
        };

        # Work PC
        work-git-config = lib.mkIf (config.opt.features.work-machine.enable) {
          content = lib.generators.toINI { } {
            user = {
              email = config.sops.placeholder.work_email;
              name = "Rune Dahl Billeskov";
            };
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
