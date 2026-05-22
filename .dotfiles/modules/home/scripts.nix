{pkgs, ...}: {
  home.packages = [
    # sb-volume: Prints the current volume or 🔇 if muted.
    (pkgs.writeShellScriptBin "sb-volume" ''
      case $BLOCK_BUTTON in
        1) setsid -w -f "$TERMINAL" -e pulsemixer; pkill -RTMIN+10 "''${STATUSBAR:-dwmblocks}" ;;
        2) wpctl set-mute @DEFAULT_SINK@ toggle ;;
        4) wpctl set-volume @DEFAULT_SINK@ 1%+ ;;
        5) wpctl set-volume @DEFAULT_SINK@ 1%- ;;
        3) notify-send "📢 Volume module" "\- Shows volume 🔊, 🔇 if muted.
      - Middle click to mute.
      - Scroll to change." ;;
        6) setsid -f "$TERMINAL" -e "$EDITOR" "$0" ;;
      esac

      vol="$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"

      # If muted, print 🔇 and exit.
      [ "$vol" != "''${vol%\[MUTED\]}" ] && echo 🔇 && exit

      vol="''${vol#Volume: }"

      split() {
        IFS=$2
        set -- $1
        printf '%s' "$@"
      }

      vol="$(printf "%.0f" "$(split "$vol" ".")")"

      case 1 in
        $((vol >= 70)) ) icon="🔊" ;;
        $((vol >= 30)) ) icon="🔉" ;;
        $((vol >= 1)) ) icon="🔈" ;;
        * ) echo 🔇 && exit ;;
      esac

      echo -n "$icon$vol%"
    '')

    # sb-battery: Prints all batteries, their percentage remaining and an emoji status.
    (pkgs.writeShellScriptBin "sb-battery" ''
      case $BLOCK_BUTTON in
        3) notify-send "🔋 Battery module" "🔋: discharging
      🛑: not charging
      ♻: stagnant charge
      🔌: charging
      ⚡: charged
      ❗: battery very low!
      - Scroll to change adjust xbacklight." ;;
        4) xbacklight -inc 10 ;;
        5) xbacklight -dec 10 ;;
        6) setsid -f "$TERMINAL" -e "$EDITOR" "$0" ;;
      esac

      for battery in /sys/class/power_supply/BAT?*; do
        [ -n "''${capacity+x}" ] && printf " "
        case "$(cat "$battery/status" 2>&1)" in
          "Full") status="⚡" ;;
          "Discharging") status="🔋" ;;
          "Charging") status="🔌" ;;
          "Not charging") status="🛑" ;;
          "Unknown") status="♻️" ;;
          *) exit 1 ;;
        esac
        capacity="$(cat "$battery/capacity" 2>&1)"
        [ "$status" = "🔋" ] && [ "$capacity" -le 25 ] && warn="❗"
        printf "%s%s%d%%" "$status" "$warn" "$capacity"; unset warn
      done && printf "\\n"
    '')

    # sb-clock: Formatted date and time with clock icons.
    (pkgs.writeShellScriptBin "sb-clock" ''
      clock=$(date '+%I')

      case "$clock" in
        "00") icon="🕛" ;;
        "01") icon="🕐" ;;
        "02") icon="🕑" ;;
        "03") icon="🕒" ;;
        "04") icon="🕓" ;;
        "05") icon="🕔" ;;
        "06") icon="🕕" ;;
        "07") icon="🕖" ;;
        "08") icon="🕗" ;;
        "09") icon="🕘" ;;
        "10") icon="🕙" ;;
        "11") icon="🕚" ;;
        "12") icon="🕛" ;;
      esac

      case $BLOCK_BUTTON in
        1) notify-send "This Month" "$(cal | sed "s/\<$(date +'%e'|tr -d ' ')\>/<b><span color='red'>&<\/span><\/b>/")" && notify-send "Appointments" "$(calcurse -d3)" ;;
        2) setsid -f "$TERMINAL" -e calcurse ;;
        3) notify-send "📅 Time/date module" "\- Left click to show upcoming appointments for the next three days via \`calcurse -d3\` and show the month via \`cal\`
      - Middle click opens calcurse if installed" ;;
        6) setsid -f "$TERMINAL" -e "$EDITOR" "$0" ;;
      esac

      printf "%s" "$(date "+%d %b %Y (%a) $icon%I:%M%p")"
    '')

    # sb-internet: Wifi, Ethernet and VPN status.
    (pkgs.writeShellScriptBin "sb-internet" ''
      case $BLOCK_BUTTON in
        1) "$TERMINAL" -e nmtui; pkill -RTMIN+4 dwmblocks ;;
        3) notify-send "🌐 Internet module" "\- Click to connect
      ❌: wifi disabled
      📡: no wifi connection
      📶: wifi connection with quality
      ❎: no ethernet
      🌐: ethernet working
      🔒: vpn is active
      " ;;
        6) setsid -f "$TERMINAL" -e "$EDITOR" "$0" ;;
      esac

      # Wifi
      if [ "$(cat /sys/class/net/w*/operstate 2>/dev/null)" = 'up' ] ; then
        wifiicon="$(awk '/^\s*w/ { print "📶", int($3 * 100 / 70) "% " }' /proc/net/wireless)"
      elif [ "$(cat /sys/class/net/w*/operstate 2>/dev/null)" = 'down' ] ; then
        [ "$(cat /sys/class/net/w*/flags 2>/dev/null)" = '0x1003' ] && wifiicon="📡 " || wifiicon="❌ "
      fi

      # Ethernet
      [ "$(cat /sys/class/net/e*/operstate 2>/dev/null)" = 'up' ] && ethericon="🌐" || ethericon="❎"

      # TUN
      [ -n "$(cat /sys/class/net/tun*/operstate 2>/dev/null)" ] && tunicon=" 🔒"

      printf "%s%s%s\\n" "$wifiicon" "$ethericon" "$tunicon"
    '')
  ];
}
