{ inputs, config, lib, pkgs, ... }:

{
  ssh.enable = true;
  ssh.compression = true;
  ssh.extraOptionOverrides = {
    IdentityAgent = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  };
  ssh.includes = [
    "${config.home.homeDirectory}/.ssh/config.d/*.conf"
  ];
  ssh.matchBlocks = {
    "github.com" = {
      hostname = "ssh.github.com";
      user = "git";
      port = 443;
    };
  };
  ssh.serverAliveInterval = 60;
  ssh.serverAliveCountMax = 30;
}
