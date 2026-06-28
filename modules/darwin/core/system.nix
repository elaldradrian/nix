{ self, user, ... }:
{
  system = {
    primaryUser = user;
    stateVersion = 6;
    configurationRevision = self.rev or self.dirtyRev or null;
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    defaults = {
      dock.autohide = true;
      dock.mru-spaces = false;
      dock.show-recents = false;
      finder.AppleShowAllExtensions = true;
      finder.FXPreferredViewStyle = "clmv";
      NSGlobalDomain.AppleInterfaceStyle = "Dark";
      ".GlobalPreferences"."com.apple.mouse.scaling" = -1.0;
      NSGlobalDomain.NSScrollAnimationEnabled = false;
      screensaver.askForPasswordDelay = 10;
      loginwindow.PowerOffDisabledWhileLoggedIn = true;
      CustomUserPreferences."com.apple.symbolichotkeys".AppleSymbolicHotKeys = {
        # Mirror of `defaults read com.apple.symbolichotkeys AppleSymbolicHotKeys`
        # captured from the live state. Writing this dict via `defaults write`
        # replaces the entire dictionary, so every key must be present here to
        # preserve state across `darwin-rebuild switch`. To re-sync, run:
        #   defaults read com.apple.symbolichotkeys AppleSymbolicHotKeys
        # and translate the output into this attrset.

        "7" = {
          enabled = false;
        };
        "8" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              99
              8650752
            ];
          };
        };
        "9" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              118
              8650752
            ];
          };
        };
        "10" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              96
              8650752
            ];
          };
        };
        "11" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              97
              8650752
            ];
          };
        };
        "12" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              122
              8650752
            ];
          };
        };
        "13" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              98
              8650752
            ];
          };
        };
        "21" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              56
              28
              1835008
            ];
          };
        };
        "25" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              46
              47
              1835008
            ];
          };
        };
        "26" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              44
              43
              1835008
            ];
          };
        };
        "27" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              96
              50
              1048576
            ];
          };
        };
        "28" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              51
              20
              1179648
            ];
          };
        };
        "29" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              51
              20
              1441792
            ];
          };
        };
        "30" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              52
              21
              1179648
            ];
          };
        };
        "31" = {
          enabled = true;
          value = {
            type = "standard";
            parameters = [
              52
              21
              1310720
            ];
          };
        };
        "32" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              126
              8650752
            ];
          };
        };
        "33" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              125
              8650752
            ];
          };
        };
        "36" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              103
              8388608
            ];
          };
        };
        "52" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              100
              2
              1572864
            ];
          };
        };
        "57" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              100
              8650752
            ];
          };
        };
        "59" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              96
              9437184
            ];
          };
        };
        "60" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              32
              49
              262144
            ];
          };
        };
        "61" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              32
              49
              786432
            ];
          };
        };
        "64" = {
          enabled = false;
        };
        "65" = {
          enabled = false;
        };
        "66" = {
          enabled = false;
        };
        "68" = {
          enabled = false;
        };
        "71" = {
          enabled = false;
        };
        "82" = {
          enabled = false;
        };
        "83" = {
          enabled = false;
        };
        "84" = {
          enabled = false;
        };
        "91" = {
          enabled = false;
        };
        "92" = {
          enabled = false;
        };
        "93" = {
          enabled = false;
        };
        "94" = {
          enabled = false;
        };
        "95" = {
          enabled = false;
        };
        "96" = {
          enabled = false;
        };
        "97" = {
          enabled = false;
        };
        "98" = {
          enabled = false;
        };
        "99" = {
          enabled = false;
        };
        "100" = {
          enabled = false;
        };
        "105" = {
          enabled = false;
        };
        "106" = {
          enabled = false;
        };
        "107" = {
          enabled = false;
        };
        "108" = {
          enabled = false;
        };
        "109" = {
          enabled = false;
        };
        "110" = {
          enabled = false;
        };
        "111" = {
          enabled = false;
        };
        "112" = {
          enabled = false;
        };
        "113" = {
          enabled = false;
        };
        "114" = {
          enabled = false;
        };
        "115" = {
          enabled = false;
        };
        "116" = {
          enabled = false;
        };
        "117" = {
          enabled = false;
        };
        "118" = {
          enabled = false;
        };
        "119" = {
          enabled = false;
        };
        "120" = {
          enabled = false;
        };
        "121" = {
          enabled = false;
        };
        "122" = {
          enabled = false;
        };
        "123" = {
          enabled = false;
        };
        "124" = {
          enabled = false;
        };
        "125" = {
          enabled = false;
        };
        "126" = {
          enabled = false;
        };
        "127" = {
          enabled = false;
        };
        "128" = {
          enabled = false;
        };
        "129" = {
          enabled = false;
        };
        "130" = {
          enabled = false;
        };
        "131" = {
          enabled = false;
        };
        "132" = {
          enabled = false;
        };
        "133" = {
          enabled = false;
        };
        "134" = {
          enabled = false;
        };
        "135" = {
          enabled = false;
        };
        "136" = {
          enabled = false;
        };
        "137" = {
          enabled = false;
        };
        "138" = {
          enabled = false;
        };
        "139" = {
          enabled = false;
        };
        "140" = {
          enabled = false;
        };
        "141" = {
          enabled = false;
        };
        "142" = {
          enabled = false;
        };
        "143" = {
          enabled = false;
        };
        "150" = {
          enabled = false;
        };
        "152" = {
          enabled = false;
        };
        "153" = {
          enabled = false;
        };
        "154" = {
          enabled = false;
        };
        "155" = {
          enabled = false;
        };
        "156" = {
          enabled = false;
        };
        "157" = {
          enabled = false;
        };
        "158" = {
          enabled = false;
        };
        "159" = {
          enabled = false;
        };
        "160" = {
          enabled = false;
        };
        "161" = {
          enabled = false;
        };
        "162" = {
          enabled = false;
        };
        "163" = {
          enabled = false;
        };
        "175" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "179" = {
          enabled = false;
        };
        "180" = {
          enabled = false;
        };
        "181" = {
          enabled = false;
        };
        "182" = {
          enabled = false;
        };
        "183" = {
          enabled = false;
        };
        "184" = {
          enabled = false;
        };
        "185" = {
          enabled = false;
        };
        "186" = {
          enabled = false;
        };
        "187" = {
          enabled = false;
        };
        "188" = {
          enabled = false;
        };
        "189" = {
          enabled = false;
        };
        "190" = {
          enabled = false;
        };
        "191" = {
          enabled = false;
        };
        "192" = {
          enabled = false;
        };
        "193" = {
          enabled = false;
        };
        "194" = {
          enabled = false;
        };
        "195" = {
          enabled = false;
        };
        "196" = {
          enabled = false;
        };
        "197" = {
          enabled = false;
        };
        "198" = {
          enabled = false;
        };
        "199" = {
          enabled = false;
        };
        "200" = {
          enabled = false;
        };
        "201" = {
          enabled = false;
        };
        "202" = {
          enabled = false;
        };
        "203" = {
          enabled = false;
        };
        "204" = {
          enabled = false;
        };
        "205" = {
          enabled = false;
        };
        "206" = {
          enabled = false;
        };
        "207" = {
          enabled = false;
        };
        "215" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "216" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "217" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "218" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "219" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "222" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "223" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "224" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "225" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "226" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "227" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "228" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "229" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "230" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "231" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "232" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "233" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              109
              46
              1048576
            ];
          };
        };
        "235" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "237" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              102
              3
              8650752
            ];
          };
        };
        "238" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              99
              8
              8650752
            ];
          };
        };
        "239" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              114
              15
              8650752
            ];
          };
        };
        "240" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              123
              8650752
            ];
          };
        };
        "241" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              124
              8650752
            ];
          };
        };
        "242" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              126
              8650752
            ];
          };
        };
        "243" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              125
              8650752
            ];
          };
        };
        "244" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "245" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "246" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "247" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "248" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              123
              8781824
            ];
          };
        };
        "249" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              124
              8781824
            ];
          };
        };
        "250" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              126
              8781824
            ];
          };
        };
        "251" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              125
              8781824
            ];
          };
        };
        "256" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "257" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "258" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              65535
              0
            ];
          };
        };
        "260" = {
          enabled = false;
          value = {
            type = "standard";
            parameters = [
              65535
              53
              1048576
            ];
          };
        };
      };
    };
    activationScripts.postActivation.text = ''
      if /usr/bin/mdutil -s / | grep -q "Indexing enabled"; then
        /usr/bin/mdutil -i off -a || true
      fi
    '';
  };
}
