{
  self,
  homeDir,
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
      keyFile = "${homeDir}/.config/sops/age/keys.txt";
    };
  };
}
