{
  self,
  config,
  inputs,
  ...
}:
{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    defaultSopsFile = "${self}/secrets/${config.networking.hostName}/secrets.json";
    defaultSopsFormat = "json";

    age = {
      generateKey = true;
      keyFile = "~/.sops-nix/keys.txt";
    };
  };
}
