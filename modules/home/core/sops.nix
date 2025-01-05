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
      generateKey = true;
      keyFile = "${config.home.homeDirectory}/.sops-nix/keys.txt";
    };
  };
}
