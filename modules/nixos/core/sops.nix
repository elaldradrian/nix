{
  self,
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
      keyFile = "/home/rune/.config/sops/age/keys.txt";
    };

    secrets.k3s-token = {
      sopsFile = "${self}/secrets/k3s/secrets.json";
    };
  };
}
