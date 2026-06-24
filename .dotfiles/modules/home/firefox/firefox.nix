{pkgs, ...}: let
  lock = v: {
    Value = v;
    Status = "locked";
  };
in {
  programs.firefox = {
    enable = true;
    languagePacks = ["en-US"];

    policies = {
      /*
      ─────────────────────────────
      BASIC PRIVACY BASELINE
      ─────────────────────────────
      */
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DontCheckDefaultBrowser = true;

      /*
      ─────────────────────────────
      PRIVACY PROTECTION (LIBREWOLF-LIKE)
      ─────────────────────────────
      */
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      /*
      ─────────────────────────────
      CLEAN UI / NO BLOAT
      ─────────────────────────────
      */
      DisablePocket = true;
      DisableFirefoxScreenshots = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";

      DisplayBookmarksToolbar = "never";
      DisplayMenuBar = "default-off";
      SearchBar = "unified";

      /*
      ─────────────────────────────
      EXTENSIONS (YOUR REAL STACK)
      ─────────────────────────────
      */
      ExtensionSettings = {
        "*" = {
          installation_mode = "blocked";
        };

        # uBlock Origin (core)
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };

        # Bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };

        # ClearURLs
        "{74145f27-f039-47ce-a470-a662b129930a}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
          installation_mode = "force_installed";
        };

        # I still don't care about cookies
        "jid1-KKzOGWgsW3Ao4Q@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/istilldontcareaboutcookies/latest.xpi";
          installation_mode = "force_installed";
        };

        # Tridactyl (your real config dependency)
        "tridactyl.vim@cmcaine.co.uk" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tridactyl-vim/latest.xpi";
          installation_mode = "force_installed";
        };
      };

      /*
      ─────────────────────────────
      PREFERENCES (MATCHING YOUR PREFS.JS BEHAVIOR)
      ─────────────────────────────
      */
      Preferences = {
        # Strict content blocking
        "browser.contentblocking.category" = lock "strict";

        # HTTPS-only
        "dom.security.https_only_mode" = lock true;

        # Tracking / fingerprinting hardening
        "privacy.trackingprotection.enabled" = lock true;
        "privacy.trackingprotection.socialtracking.enabled" = lock true;
        "privacy.trackingprotection.fingerprinting.enabled" = lock true;

        # Query stripping (you already use it)
        "privacy.query_stripping.enabled" = lock true;
        "privacy.query_stripping.enabled.pbmode" = lock true;

        # Bounce tracking protection
        "privacy.bounceTrackingProtection.mode" = lock 1;

        # Reduce data leakage
        "network.prefetch-next" = lock false;
        "network.dns.disablePrefetch" = lock true;
        "network.http.speculative-parallel-limit" = lock 0;

        # URL bar privacy
        "browser.search.suggest.enabled" = lock false;
        "browser.search.suggest.enabled.private" = lock false;
        "browser.urlbar.suggest.searches" = lock false;
        "browser.urlbar.suggest.history" = lock false;
        "browser.urlbar.suggest.topsites" = lock false;

        # New tab cleanup
        "browser.newtabpage.enabled" = lock false;
        "browser.newtabpage.activity-stream.showSponsored" = lock false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock false;
        "browser.newtabpage.activity-stream.feeds.snippets" = lock false;

        # Pocket removal
        "extensions.pocket.enabled" = lock false;

        # Form history (you had similar behavior)
        "browser.formfill.enable" = lock false;

        # Safer defaults
        "security.tls.enable_0rtt_data" = lock false;
      };
    };
  };
}
