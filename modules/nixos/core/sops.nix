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
      generateKey = false;
      keyFile = "/home/rune/.config/sops/age/keys.txt";
    };
  };
}
