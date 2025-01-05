{
  self,
  config,
  hostname,
  inputs,
  ...
}:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = "${self}/secrets/${hostname}/secrets.json";
    defaultSopsFormat = "json";

    age = {
      generateKey = true;
      keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    };

    secrets.k3s-token = {
      sopsFile = "${self}/secrets/k3s/secret.json";
    };
  };
}
