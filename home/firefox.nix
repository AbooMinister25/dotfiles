{ inputs, ... }: { config, pkgs, ... }:

{
  home.file."firefox-gnome-theme" = {
    target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
    source = inputs.firefox-gnome-theme;
  };
  # home.file.".mozilla/firefox/default/chrome/firefox-gnome-theme/colors/everforest.css" = {
  #   source = ./firefox/everforest.css;
  # };
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        isDefault = true;
        settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
#         userChrome = ''
# @import "firefox-gnome-theme/userChrome.css";

# #sidebar-header {
#   display: none;
# }

# #TabsToolbar {
#   display: none;
# }

# #sidebar-box{
#   --uc-sidebar-width: 50px;
#   --uc-sidebar-hover-width: 300px;
#   --uc-autohide-sidebar-delay: 125ms; /* Wait 0.6s before hiding sidebar */
#   --uc-autohide-transition-duration: 115ms;
#   --uc-autohide-transition-type: linear;
#   position: relative;
#   min-width: var(--uc-sidebar-width) !important;
#   width: var(--uc-sidebar-width) !important;
#   max-width: var(--uc-sidebar-width) !important;
#   z-index:1;
# }

# #sidebar-box[positionend]{ direction: rtl }
# #sidebar-box[positionend] > *{ direction: ltr }

# #sidebar-box[positionend]:-moz-locale-dir(rtl){ direction: ltr }
# #sidebar-box[positionend]:-moz-locale-dir(rtl) > *{ direction: rtl }

# #main-window[sizemode="fullscreen"] #sidebar-box{ --uc-sidebar-width: 1px; }

# #sidebar-splitter {
#   border: none !important;
#   background: transparent !important;
#   width: 1px !important;
# }


# #sidebar-header{
#   overflow: hidden;
#   color: var(--chrome-color, inherit) !important;
#   padding-inline: 0 !important;
# }

# #sidebar-header::before,
# #sidebar-header::after{
#   content: "";
#   display: flex;
#   padding-left: 8px;
# }

# #sidebar-header,
# #sidebar{
#   transition: min-width var(--uc-autohide-transition-duration) var(--uc-autohide-transition-type) var(--uc-autohide-sidebar-delay) !important;
#   min-width: var(--uc-sidebar-width) !important;
#   will-change: min-width;
# }
# #sidebar-box:hover > #sidebar-header,
# #sidebar-box:hover > #sidebar{
#   min-width: var(--uc-sidebar-hover-width) !important;
#   transition-delay: 0ms !important;
# }

# .sidebar-panel{
#   background-color: transparent !important;
#   color: var(--newtab-text-primary-color) !important;
# }

# .sidebar-panel #search-box{
#   -moz-appearance: none !important;
#   background-color: rgba(249,249,250,0.1) !important; 
#   color: inherit !important;
# }

# /* Add sidebar divider and give it background */

# #sidebar,
# #sidebar-header{
#   background-color: inherit !important;
#   border-inline: 1px solid rgb(80,80,80);
#   border-inline-width: 0px 1px;
# }

# #sidebar-box:not([positionend]) > :-moz-locale-dir(rtl),
# #sidebar-box[positionend] > *{
#   border-inline-width: 1px 0px;
# }

# /* Move statuspanel to the other side when sidebar is hovered so it doesn't get covered by sidebar */

# #sidebar-box:not([positionend]):hover ~ #appcontent #statuspanel{
#   inset-inline: auto 0px !important;
# }
# #sidebar-box:not([positionend]):hover ~ #appcontent #statuspanel-label{
#   margin-inline: 0px !important;
#   border-left-style: solid !important; 
# }
#         '';
#         userContent = ''
#         @import "firefox-gnome-theme/userContent.css";
#         '';
      };
    };
  };
}