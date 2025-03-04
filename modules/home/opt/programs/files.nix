{
  config,
  lib,
  homeDir,
  ...
}:
{
  config = lib.mkIf (config.opt.features.devUtils.enable && config.opt.features.work-machine.enable) {
    sops = {
      secrets.github_token = { };
      secrets.work_email = { };
      secrets.work_email = { };
      secrets.artifactory_token = { };

      templates.github_token = {
        path = "${homeDir}/.npmrc";
        content = lib.generators.toINIWithGlobalSection { } {
          globalSection = {
            prefix = "${homeDir}/.npm-packages";
            "//npm.pkg.github.com/:_authToken" = config.sops.placeholder.github_token;
            "@bd-b0100:registry" = "https://npm.pkg.github.com/";

            "always-auth" = "true";
            "email" = config.sops.placeholder.artifactory_email;

            "//registry.bankdata.dev/artifactory/api/npm/rel-npm/:_authToken" =
              config.sops.placeholder.artifactory_token;
            "registry" = "https://registry.bankdata.dev/artifactory/api/npm/rel-npm/";
          };
        };
      };
    };
  };
}
