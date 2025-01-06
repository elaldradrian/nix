{ config, lib, ... }:
let
  # onePassPath = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  onePassPath = "~/.1password/agent.sock";
in
{
  config = lib.mkIf config.opt.programs."1password".enable {
    programs.ssh = {
      enable = true;
      extraConfig =
        if config.opt.features.ssh.work-profile.enable then
          ''
            IdentityAgent ${onePassPath}
            User git
            IdentityFile ~/.ssh/work.pub
            IdentitiesOnly yes
          ''
        else
          ''
            IdentityAgent ${onePassPath}
          '';
      matchBlocks.private = {
        host = "private";
        identitiesOnly = true;
        user = "git";
        hostname = "github.com";
        identityFile = "~/.ssh/private.pub";
      };
    };
  };
}
