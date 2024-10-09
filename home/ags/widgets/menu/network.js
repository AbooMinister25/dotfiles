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
                        // child: Widget.Icon({
                        //     icon: "view-refresh-symbolic",
                        // }),
                    }),
                ],
            }),
            Widget.Box({
                class_name: "network-menu-items",
                vertical: true,
                children: [
                    Widget.Box({
                        class_name: "wap-stating",
                        setup: (self) => {
                            // renderWapStaging(self, network);
                        },
                    }),
                    Widget.Box({
                        class_name: "available-waps",
                        vertical: true,
                        setup: (self) => {
                            // renderWAPs(self, network, Staging, Connecting);
                        },
                    }),
                ],
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
