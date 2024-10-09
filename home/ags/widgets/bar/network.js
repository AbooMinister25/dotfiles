const network = await Service.import("network");

function set_icon(icon, internet, state, device) {
    icon.toggleClassName("nw-disconnected", false);
    icon.toggleClassName("nw-connecting", false);
    icon.toggleClassName("nw-alert", false);
    icon.toggleClassName("nw-connected", false);

    if (internet == "connected") {
        icon.icon = `${device}-symbolic`;
        icon.toggleClassName("nw-connected", true);
    } else if (internet == "connecting") {
        icon.icon = `${device}-symbolic`;
        icon.toggleClassName("nw-connecting", true);
    } else if (state == "failed") {
        icon.icon = `${device}-alert-symbolic`;
        icon.toggleClassName("nw-alert", true);
    } else {
        icon.icon = `${device}-off-symbolic`;
        icon.toggleClassName("nw-disconnected", true);
    }
}

export const Network = () =>
    Widget.Box({
        class_name: "bar-applet",
        children: [
            Widget.Button({
                child: Widget.Box({
                    class_name: "network-applet-container",
                    children: [
                        Widget.Icon({
                            class_name: "bar-button-icon",
                            setup: (self) => {
                                Utils.merge(
                                    [
                                        network.bind("primary"),
                                        network.bind("wifi"),
                                        network.bind("wired"),
                                    ],
                                    (primary, wifi, wired) => {
                                        if (primary == "wired") {
                                            set_icon(
                                                self,
                                                wired.internet,
                                                wired.state,
                                                "wired"
                                            );
                                            return;
                                        }

                                        set_icon(
                                            self,
                                            wifi.internet,
                                            wifi.state,
                                            "wifi"
                                        );
                                    }
                                );
                            },
                        }),
                        Widget.Label({
                            class_name: "bar-button-label",
                            label: Utils.merge(
                                [network.bind("primary"), network.bind("wifi")],
                                (primary, wifi) => {
                                    if (primary == "wired") {
                                        return "Wired";
                                    }

                                    if (wifi.internet == "disconnected") {
                                        return "Disconnected";
                                    }
                                    return wifi.ssid;
                                }
                            ),
                        }),
                    ],
                }),
                class_name: "bar-button",
                onClicked: () => App.toggleWindow("dropdown-1-network")
            }),
        ],
    });
