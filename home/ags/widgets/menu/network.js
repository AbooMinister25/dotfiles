import { DropdownMenu } from "../dropdown.js";

const network = await Service.import("network");

const Ethernet = () => {
    return Widget.Box({
        class_name: "network-menu-item-container",
        hpack: "fill",
        vpack: "fill",
        expand: true,
        vertical: true,
        children: [
            Widget.Box({
                class_name: "network-menu-label",
                hpack: "fill",
                child: Widget.Label({
                    class_name: "menu-label",
                    hexpand: true,
                    hpack: "start",
                    label: "Ethernet",
                }),
            }),
            Widget.Box({
                class_name: "network-menu-items",
                vertical: true,
                child: Widget.Box({
                    class_name: "network-menu-listing",
                    vertical: true,
                    setup: (self) => {
                        self.hook(network, () => {
                            return (self.child = Widget.Box({
                                class_name: "network-menu-item",
                                child: Widget.Box({
                                    hpack: "start",
                                    children: [
                                        Widget.Icon({
                                            class_name: "network-icon",
                                            tooltip_text:
                                                network.wired.internet,
                                            icon: "wired-symbolic",
                                        }),
                                        Widget.Box({
                                            class_name: "network-container",
                                            vertical: true,
                                            children: [
                                                Widget.Label({
                                                    class_name:
                                                        "active-connection",
                                                    hpack: "start",
                                                    truncate: "end",
                                                    wrap: true,
                                                    label: `Ethernet Connection ${
                                                        network.wired.state !==
                                                            "unknown" &&
                                                        typeof network.wired
                                                            .speed === "number"
                                                            ? `(${
                                                                  network.wired
                                                                      ?.speed /
                                                                  1000
                                                              } Gbps)`
                                                            : ""
                                                    }`,
                                                }),
                                                Widget.Label({
                                                    hpack: "start",
                                                    class_name:
                                                        "connection-status",
                                                    label:
                                                        network.wired.internet
                                                            .charAt(0)
                                                            .toUpperCase() +
                                                        network.wired.internet.slice(
                                                            1
                                                        ),
                                                }),
                                            ],
                                        }),
                                    ],
                                }),
                            }));
                        });
                    },
                }),
            }),
        ],
    });
};

const WiFi = () => {
    return Widget.Box({
        class_name: "network-menu-item-container",
        hpack: "fill",
        vpack: "fill",
        expand: true,
        vertical: true,
        children: [
            Widget.Box({
                class_name: "network-menu-label",
                hpack: "fill",
                children: [
                    Widget.Label({
                        class_name: "menu-label",
                        hexpand: true,
                        hpack: "start",
                        label: "Wifi",
                    }),
                    Widget.Button({
                        vpack: "center",
                        hpack: "end",
                        class_name: "menu-icon-button",
                        child: Widget.Icon({
                            icon: "view-refresh-symbolic",
                        }),
                        on_clicked: () => {
                            network.wifi.enabled = true;
                            network.wifi.scan();
                        },
                    }),
                ],
            }),
            Widget.Box({
                class_name: "network-menu-items",
                vertical: true,
                setup: (self) => {
                    self.bssid = "";
                    const entry = Widget.Entry({
                        visible: true,
                        placeholder_text: "Enter Password: ",
                        visibility: false,
                        onAccept: (inp) => {
                            Utils.execAsync(
                                `nmcli device wifi connect ${self.bssid} password ${inp.text}`
                            );
                        },
                    });
                    self.hook(
                        network,
                        () =>
                            (self.children = network.wifi.access_points
                                .sort((a, b) => b.strength - a.strength)
                                .slice(0, 10)
                                .map((ap) =>
                                    Widget.Button({
                                        on_clicked: () => {
                                            self.bssid = ap.bssid;
                                            Utils.execAsync(
                                                `nmcli device wifi connect ${ap.bssid}`
                                            ).catch(
                                                (err) => (entry.visible = true)
                                            );
                                            self.bssid = "";
                                        },
                                        child: Widget.Box({
                                            children: [
                                                Widget.Icon({
                                                    icon: "wifi-symbolic",
                                                    class_name: "network-icon",
                                                }),
                                                Widget.Label({
                                                    class_name:
                                                        "active-connection",
                                                    label: ap.ssid || "",
                                                }),
                                                Widget.Icon({
                                                    icon: "check-symbolic",
                                                    hexpand: true,
                                                    hpack: "end",
                                                    setup: (self) =>
                                                        Utils.idle(() => {
                                                            if (
                                                                !self.is_destroyed
                                                            )
                                                                self.visible =
                                                                    ap.active;
                                                        }),
                                                }),
                                            ],
                                        }),
                                    })
                                ))
                    );
                },
                // children: [
                //     Widget.Box({
                //         class_name: "wap-stating",
                //         setup: (self) => {
                //             // renderWapStaging(self, network);
                //         },
                //     }),
                //     Widget.Box({
                //         class_name: "available-waps",
                //         vertical: true,
                //         setup: (self) => {
                //             // renderWAPs(self, network, Staging, Connecting);
                //         },
                //     }),
                // ],
            }),
        ],
    });
};

export const NetworkMenu = () =>
    DropdownMenu({
        widget_name: "network",
        child: Widget.Box({
            class_name: "network-menu-content",
            vertical: true,
            children: [Ethernet(), WiFi()],
        }),
        monitor: 1,
    });
