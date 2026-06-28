{
  config,
  lib,
  homeDir,
  ...
}:
{
  config = lib.mkMerge [
    (lib.mkIf config.opt.features.devUtils.enable {
      sops.templates.npmrc = {
        path = "${homeDir}/.npmrc";
        content = lib.generators.toINIWithGlobalSection { } {
          globalSection.prefix = "${homeDir}/.npm-packages";
        };
      };
    })

    (lib.mkIf config.opt.features.work-machine.enable {
      sops = {
        secrets.artifactory_token = { };
        secrets.artifactory_url = { };

        templates.npmrc = {
          path = "${homeDir}/.npmrc";
          content = lib.generators.toINIWithGlobalSection { } {
            globalSection = {
              prefix = "${homeDir}/.npm-packages";

              "//registry.bankdata.dev/artifactory/api/npm/rel-npm/:_authToken" =
                config.sops.placeholder.artifactory_token;
              "registry" = config.sops.placeholder.artifactory_url;
            };
          };
        };
      };
    })
  ];
}
