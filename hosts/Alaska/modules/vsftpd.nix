{ ... }:

let 

in
{
  services.vsftpd = {
    enable = true;
    localUsers = true;
    writeEnable = true;
  };
}
