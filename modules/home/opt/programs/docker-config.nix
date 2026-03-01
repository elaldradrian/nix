{
  config,
  lib,
  homeDir,
  ...
}:
{
  config = lib.mkIf (config.opt.features.devUtils.enable && config.opt.features.work-machine.enable) {
    sops = {
      secrets.artifactory_basic_auth = { };

      templates.dockerConfig = {
        path = "${homeDir}/.docker/config.json";
        content = lib.generators.toJSON { } {
          auths = {
            "registry.bankdata.dev" = {
              "auth" = "${config.sops.placeholder.artifactory_basic_auth}";
            };
          };
          currentContext = "colima";
        };
      };
    };
  };
}
