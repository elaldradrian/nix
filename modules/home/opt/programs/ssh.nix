{
  pkgs,
  config,
  lib,
  ...
}:
let
  onePasswordSock =
    if pkgs.stdenv.isDarwin then
      "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else
      "~/.1password/agent.sock";
in
{
  config = lib.mkIf config.opt.programs."1password".enable {
    programs.ssh = {
      enable = true;
      extraConfig = "IdentityAgent \"${onePasswordSock}\"";

      matchBlocks.private = {
        host = "private";
        hostname = "github.com";
        identityFile = "~/.ssh/private.pub";
      };
      matchBlocks.work = (lib.mkIf config.opt.features.work-machine.enable) {
        host = "github.com";
        identityFile = "~/.ssh/work.pub";
      };
    };
  };
}
