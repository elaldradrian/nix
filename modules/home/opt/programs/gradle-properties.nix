{
  config,
  lib,
  homeDir,
  ...
}:
{
  config = lib.mkIf (config.opt.features.devUtils.enable && config.opt.features.work-machine.enable) {
    sops = {
      secrets.work_email = { };
      secrets.artifactory_token = { };

      templates.gradleProperties = {
        path = "${homeDir}/.gradle/gradle.properties";
        content = lib.generators.toINIWithGlobalSection { } {
          globalSection = {
            "systemProp.gradle.wrapperUser" = config.sops.placeholder.work_email;
            "systemProp.gradle.wrapperPassword" = config.sops.placeholder.artifactory_token;
          };
        };
      };
    };
  };
}
