{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.opt.programs.steam.enable {
    programs.steam = {
      enable = true;
      extraPackages = with pkgs; [
        intel-vaapi-driver # VA-API hardware video decode (Intel)
        libva # VA-API runtime
        vulkan-loader # Vulkan ICD loader
      ];
      extraCompatPackages = with pkgs; [
        proton-ge-bin # Proton-GE, worth trying for D2R
      ];
    };
  };
}
