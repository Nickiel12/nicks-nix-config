{ config, lib, pkgs, ... }:

{

  programs.msmtp = {
    enable = true;
    setSendmail = true;
    accounts = {
      default = {
        host = "smtp.gmail.com";
        port = 587;
        tls = true;
        tls_starttls = true;
        auth = true;
        from = "noreply@nickiel.net";
        user = "nickiel.is.a.dev";
        passwordeval = "cat /Aurora/mail.password";
      };
    };
  };
}
