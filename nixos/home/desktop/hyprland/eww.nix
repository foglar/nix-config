{
  lib,
  config,
  pkgs,
  userSettings,
  ...
}: let
  EWW_PATH = ".config/eww/dashboard";
  EWW = "${pkgs.eww}/bin/eww";
  EWW_CACHE = ".cache/eww_launch.dashboard";
in {
  options = {
    program.eww.enable = lib.mkEnableOption "Enable eww";
  };

  config =
    lib.mkIf config.program.eww.enable
    {
      programs.eww = {
        #enable = true;
        #enableBashIntegration =
        #  if userSettings.shell == "bash"
        #  then true
        #  else false;
        #enableZshIntegration =
        #  if userSettings.shell == "zsh"
        #  then true
        #  else false;
        #configDir = EWW_PATH;
      };

      home.file = {
        ".config/eww/dashboard" = {
          enable = true;
          recursive = true;
          source = ./eww/dashboard;
        };

        ".config/eww/dashboard/images/bg.jpg" = {
          enable = true;
          source = ../../../../config/backgrounds/${userSettings.background};
        };

        ".config/eww/dashboard/eww.scss" = {
          enable = true;
          text = ''
            /** Global *******************************************/
            * {
            	all: unset;
            	font-family: JetBrainsMono Nerd Font;
            	font-family: JetBrainsMono Nerd Font;
            }

            /** Background ***************************************/
            .bg {
            	background-image: url("images/bg.jpg");
            	background-color: #474d59;
            	opacity: 1;
            }

            /** Generic window ***********************************/
            .genwin {
            	background-color: #${config.lib.stylix.colors.base00};
            	border-radius: 16px;
            }

            /** Profile ******************************************/
            .face {
            	background-size: 200px;
            	min-height: 200px;
            	min-width: 200px;
            	margin: 65px 0px 0px 0px;
            	border-radius: 100%;
            }

            .fullname {
            	color: #${config.lib.stylix.colors.base16};
            	font-size: 30px;
            	font-weight: bold;
            }

            .username {
            	color: #${config.lib.stylix.colors.base06};
            	font-size: 22px;
            	font-weight: bold;
            	margin: -15px 0px 0px 0px;
            }

            /** System ********************************************/
            .iconcpu,
            .iconmem,
            .iconbright,
            .iconbat {
            	font-size: 32px;
            	font-weight: normal;
            }
            .iconcpu {
            	color: #${config.lib.stylix.colors.base05};
            }
            .iconmem {
            	color: #${config.lib.stylix.colors.base05};
            }
            .iconbright {
            	color: #${config.lib.stylix.colors.base05};
            }
            .iconbat {
            	color: #${config.lib.stylix.colors.base05};
            }

            .cpu_bar,
            .mem_bar,
            .bright_bar,
            .bat_bar,
            scale trough {
            	all: unset;
            	background-color: #${config.lib.stylix.colors.base02};
            	border-radius: 16px;
            	min-height: 28px;
            	min-width: 240px;
            }

            .cpu_bar,
            .mem_bar,
            .bright_bar,
            .bat_bar,
            scale trough highlight {
            	all: unset;
            	border-radius: 16px;
            }

            .cpu_bar scale trough highlight {
            	background-color: #${config.lib.stylix.colors.base09};
            }
            .mem_bar scale trough highlight {
            	background-color: #${config.lib.stylix.colors.base09};
            }
            .bright_bar scale trough highlight {
            	background-color: #${config.lib.stylix.colors.base09};
            }
            .bat_bar scale trough highlight {
            	background-color: #${config.lib.stylix.colors.base09};
            }

            /** Clock ********************************************/
            .time_hour,
            .time_min {
            	color: #${config.lib.stylix.colors.base12};
            	font-size: 70px;
            	font-weight: bold;
            }
            .time_hour {
            	margin: 15px 0px 0px 20px;
            }
            .time_min {
            	margin: 0px 0px 10px 0px;
            }

            .time_mer {
            	color: #${config.lib.stylix.colors.base07};
            	font-size: 40px;
            	font-weight: bold;
            	margin: 20px 0px 0px 0px;
            }

            .time_day {
            	color: #${config.lib.stylix.colors.base02};
            	font-size: 30px;
            	font-weight: normal;
            	margin: 0px 0px 20px -20px;
            }

            /** Uptime ********************************************/
            .icontimer {
            	color: #${config.lib.stylix.colors.base13};
            	font-size: 90px;
            	font-weight: normal;
            }

            .uphour {
            	color: #${config.lib.stylix.colors.base14};
            	font-size: 42px;
            	font-weight: bold;
            }

            .upmin {
            	color: #${config.lib.stylix.colors.base14};
            	font-size: 32px;
            	font-weight: bold;
            }

            /** Music ***************************************/
            .album_art {
            	background-size: 240px;
            	min-height: 240px;
            	min-width: 240px;
            	margin: 20px;
            	border-radius: 14px;
            }

            .song {
            	color: #${config.lib.stylix.colors.base15};
            	font-size: 24px;
            	font-weight: bold;
            	margin: 40px 0px 0px 0px;
            }

            .artist {
            	color: #${config.lib.stylix.colors.base02};
            	font-size: 16px;
            	font-weight: normal;
            	margin: 0px 0px 15px 0px;
            }

            .btn_prev,
            .btn_play,
            .btn_next {
            	font-family: Iosevka Nerd Font;
            }
            .btn_prev {
            	color: #${config.lib.stylix.colors.base02};
            	font-size: 32px;
            	font-weight: normal;
            }
            .btn_play {
            	color: #${config.lib.stylix.colors.base06};
            	font-size: 48px;
            	font-weight: bold;
            }
            .btn_next {
            	color: #${config.lib.stylix.colors.base02};
            	font-size: 32px;
            	font-weight: normal;
            }

            .music_bar scale trough highlight {
            	all: unset;
            	background-color: #${config.lib.stylix.colors.base02};
            	border-radius: 8px;
            }
            .music_bar scale trough {
            	all: unset;
            	background-color: #${config.lib.stylix.colors.base04};
            	border-radius: 8px;
            	min-height: 20px;
            	min-width: 310px;
            	margin: 10px 0px 0px 0px;
            }

            /** Weather ***************************************/
            .iconweather {
            	font-family: Iosevka Nerd Font;
            	font-size: 120px;
            	font-weight: normal;
            	margin: 15px 0px 0px 30px;
            }

            .label_temp {
            	color: #${config.lib.stylix.colors.base00};
            	font-size: 80px;
            	font-weight: bold;
            	margin: -15px 30px 0px 0px;
            }

            .label_stat {
            	color: #${config.lib.stylix.colors.base05};
            	font-size: 38px;
            	font-weight: bold;
            }

            .label_quote {
            	color: #${config.lib.stylix.colors.base10};
            	font-size: 18px;
            	font-weight: normal;
            }

            /** Applications ***************************************/
            .appbox {
            	margin: 15px 0px 0px 25px;
            }

            .app_fox,
            .app_telegram,
            .app_discord,
            .app_terminal,
            .app_files,
            .app_geany,
            .app_code,
            .app_gimp,
            .app_vbox {
            	background-repeat: no-repeat;
            	background-size: 64px;
            	min-height: 64px;
            	min-width: 64px;
            	margin: 8px 8px 0px 8px;
            }

            .app_fox {
            }
            .app_telegram {
            }
            .app_discord {
            }
            .app_terminal {
            }
            .app_files {
            }
            .app_geany {
            }
            .app_code {
            }
            .app_gimp {
            }
            .app_vbox {
            }

            /** Links ***************************************/
            .iconweb,
            .iconmail {
            	color: #${config.lib.stylix.colors.base00};
            	font-family: Iosevka Nerd Font;
            	font-size: 70px;
            	font-weight: normal;
            }
            .iconmail {
            	color: #df584e;
            }

            .github {
            	background-color: #24292e;
            	border-radius: 16px;
            }
            .reddit {
            	background-color: #e46231;
            	border-radius: 16px;
            }
            .twitter {
            	background-color: #61aad6;
            	border-radius: 16px;
            }
            .youtube {
            	background-color: #df584e;
            	border-radius: 16px;
            }
            .mail {
            	background-color: #ffffff;
            	border-radius: 16px;
            }

            .mailbox {
            	background-color: #${config.lib.stylix.colors.base10};
            	border-radius: 10px;
            	margin: 48px 0px 48px 0px;
            }
            .label_mails {
            	color: #404040;
            	font-size: 32px;
            	font-weight: bold;
            	margin: 0px 12px 0px 12px;
            }

            /** Power buttons ***************************************/
            .btn_logout,
            .btn_sleep,
            .btn_reboot,
            .btn_poweroff {
            	font-size: 48px;
            	font-weight: bold;
            }

            .btn_logout {
            	color: #${config.lib.stylix.colors.base05};
            }
            .btn_sleep {
            	color: #${config.lib.stylix.colors.base07};
            }
            .btn_reboot {
            	color: #${config.lib.stylix.colors.base02};
            }
            .btn_poweroff {
            	color: #${config.lib.stylix.colors.base10};
            }

            /** Home folders ***************************************/
            .hddbox {
            	background-color: #${config.lib.stylix.colors.base11};
            	border-radius: 10px;
            	margin: 15px;
            }
            .hddicon {
            	color: #${config.lib.stylix.colors.base12};
            	font-family: Iosevka Nerd Font;
            	font-size: 70px;
            	font-weight: normal;
            	margin: 25px 20px 25px 40px;
            }
            .hdd_label {
            	color: #${config.lib.stylix.colors.base14};
            	font-size: 48px;
            	font-weight: bold;
            	margin: 0px 0px 0px 15px;
            }
            .fs_sep {
            	color: #2e3440;
            	font-size: 36px;
            	font-weight: bold;
            }

            .iconfolder1,
            .iconfolder2,
            .iconfolder3,
            .iconfolder4,
            .iconfolder5,
            .iconfolder6 {
            	font-family: Iosevka Nerd Font;
            	font-size: 32px;
            	font-weight: normal;
            	margin: 0px 0px 0px 75px;
            }
            .iconfolder1 {
            	color: #${config.lib.stylix.colors.base05};
            }
            .iconfolder2 {
            	color: #${config.lib.stylix.colors.base07};
            }
            .iconfolder3 {
            	color: #${config.lib.stylix.colors.base02};
            }
            .iconfolder4 {
            	color: #${config.lib.stylix.colors.base12};
            }
            .iconfolder5 {
            	color: #${config.lib.stylix.colors.base13};
            }
            .iconfolder6 {
            	color: #${config.lib.stylix.colors.base10};
            }

            .label_folder1,
            .label_folder2,
            .label_folder3,
            .label_folder4,
            .label_folder5,
            .label_folder6 {
            	font-size: 22px;
            	font-weight: normal;
            	margin: 0px 0px 0px 30px;
            }
            .label_folder1 {
            	color: #${config.lib.stylix.colors.base05};
            }
            .label_folder2 {
            	color: #${config.lib.stylix.colors.base07};
            }
            .label_folder3 {
            	color: #${config.lib.stylix.colors.base02};
            }
            .label_folder4 {
            	color: #${config.lib.stylix.colors.base12};
            }
            .label_folder5 {
            	color: #${config.lib.stylix.colors.base13};
            }
            .label_folder6 {
            	color: #${config.lib.stylix.colors.base10};
            }

            /** EOF *************************************************/
          '';
        };
      };

      home.packages = with pkgs; [
        brightnessctl

        (writeShellScriptBin "eww-dashboard-toggle" ''
          FILE="$HOME/${EWW_CACHE}"
          CFG="$HOME/${EWW_PATH}"

          ## Run eww daemon if not running already
          if [[ ! $(pidof eww) ]]; then
          	${EWW} daemon
          	sleep 1
          fi

          ## Open widgets
          run_eww() {
          	${EWW} --config "$CFG" open-many \
              background \
          		profile \
          		system \
          		clock \
          		uptime \
          		music
          }

          ## Launch or close widgets accordingly
          if [[ ! -f "$FILE" ]]; then
          	touch "$FILE"
          	run_eww
          else
          	${EWW} --config "$CFG" close \
          		background profile system clock uptime music apps logout sleep reboot poweroff folders
          	rm "$FILE"
          fi
        '')

        (writeShellScriptBin "sys_info" ''
          PREV_TOTAL=0
          PREV_IDLE=0
          cpuFile="/tmp/.cpu_usage"

          ## Get CPU usage
          get_cpu() {
              if [[ -f "''${cpuFile}" ]]; then
                  fileCont=$(cat "''${cpuFile}")
                  PREV_TOTAL=$(echo "''${fileCont}" | head -n 1)
                  PREV_IDLE=$(echo "''${fileCont}" | tail -n 1)
              fi

              read -r _ user nice system idle rest < <(grep '^cpu ' /proc/stat)
              IDLE=''${idle}
              TOTAL=$((user + nice + system + idle))

              if [[ -n "''${PREV_TOTAL}" && -n "''${PREV_IDLE}" ]]; then
                  DIFF_IDLE=$((IDLE - PREV_IDLE))
                  DIFF_TOTAL=$((TOTAL - PREV_TOTAL))
                  DIFF_USAGE=$(((1000 * (DIFF_TOTAL - DIFF_IDLE) / DIFF_TOTAL + 5) / 10))
                  echo "''${DIFF_USAGE}"
              else
                  echo "?"
              fi

              echo "''${TOTAL}" > "''${cpuFile}"
              echo "''${IDLE}" >> "''${cpuFile}"
          }

          ## Get Used memory
          get_mem() {
              free -m | awk '/^Mem:/ {printf "%.0f\n", ($3/$2)*100}'
          }

          ## Execute accordingly
          if [[ "$1" == "--cpu" ]]; then
              get_cpu
          elif [[ "$1" == "--mem" ]]; then
              get_mem
          fi
        '')
      ];
    };
}
