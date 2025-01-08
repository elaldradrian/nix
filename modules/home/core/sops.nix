{
  self,
  config,
  hostname,
  inputs,
  ...
}:
{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    defaultSopsFile = "${self}/secrets/${hostname}/secrets.json";
    defaultSopsFormat = "json";

    age = {
      generateKey = false;
      keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    };

    secrets.github_token = { };
  };
}
