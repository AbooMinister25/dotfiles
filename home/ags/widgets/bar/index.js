import { Launcher } from "./launcher.js"
import { Workspaces } from "./workspaces.js";
import { Date } from "./date.js"

export const Bar = (monitor = 0) => {
    Widget.Window({
        monitor,
        name: `bar${monitor}`,
        anchor: ["top", "left", "right"],
        child: Widget.CenterBox({
            startWidget: Widget.Box({
                hexpand: true,
                children: [
                    Launcher(),
                    Workspaces(monitor),
                ],
                css: "margin-left: 1rem;"
            }),
            centerWidget: Widget.Box({
                hexpand: true,
                children: []
            }),
            endWidget: Widget.Box({
                hpack: "end",
                hexpand: true,
                children: [Date()],
                css: "margin-right: 1rem;"
            })
        }),
        class_name: "bar",
        exclusivity: "exclusive",
        margins: [10, 10, 0, 10]
    });
}
