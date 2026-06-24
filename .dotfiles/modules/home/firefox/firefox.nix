{config, ...}: {
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    profiles.default = {
      isDefault = true;

      settings = {
        "browser.contentblocking.category" = "strict";

        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;

        "privacy.query_stripping.enabled" = true;
        "privacy.query_stripping.enabled.pbmode" = true;

        "dom.security.https_only_mode" = true;

        "privacy.resistFingerprinting" = true;
        "privacy.resistFingerprinting.letterboxing" = true;

        "toolkit.telemetry.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;

        "browser.ping-centre.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;

        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;

        "network.prefetch-next" = false;
        "network.http.speculative-parallel-limit" = 0;

        "browser.send_pings" = false;
        "beacon.enabled" = false;

        "network.captive-portal-service.enabled" = false;
        "network.connectivity-service.enabled" = false;

        "network.http.referer.XOriginPolicy" = 2;

        "media.peerconnection.ice.no_host" = true;

        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.suggest.engines" = false;

        "browser.search.suggest.enabled" = false;
        "browser.urlbar.suggest.searches" = false;

        "browser.formfill.enable" = false;
        "signon.rememberSignons" = false;

        "network.cookie.cookieBehavior" = 4;

        "privacy.sanitize.sanitizeOnShutdown" = true;

        "privacy.clearOnShutdown.history" = true;
        "privacy.clearOnShutdown.cache" = true;
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.offlineApps" = true;

        "extensions.pocket.enabled" = false;
        "identity.fxaccounts.enabled" = false;

        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      userChrome = builtins.readFile ./userChrome.css;
    };

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;

      PasswordManagerEnabled = false;
      OfferToSaveLogins = false;
    };
  };
}
