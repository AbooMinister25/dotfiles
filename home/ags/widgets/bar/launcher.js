export const Launcher = () => Widget.Box({
    class_name: "bar-applet",
    children: [Widget.Button({
        child: Widget.Icon({
            icon: "/home/rcyclegar/nixos-config/home/ags/assets/nix-snowflake-symbolic.svg",
            class_name: "launcher-icon",
        }),
        onClicked: () => Utils.execAsync("rofi -show drun -modi 'exp:~/.config/rofi/scripts/expand.sh' -kb-custom-1 'ctrl+x' -theme ~/.config/rofi/style-6.rasi"),
        class_name: "launcher-button",
    })],
});
