{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.opt.features.devUtils.enable {
    sops.templates.github_token = {
      path = "${config.home.homeDirectory}/.npmrc";
      content = lib.generators.toINIWithGlobalSection { } {
        globalSection = {
          prefix = "${config.home.homeDirectory}/.npm-packages";
          "//npm.pkg.github.com/:_authToken" = config.sops.placeholder.github_token;
          "@bd-b0100:registry" = "https://npm.pkg.github.com";
        };
      };
    };
  };
}
