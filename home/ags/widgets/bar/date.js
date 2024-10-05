import GLib from "gi://GLib";

const clock = Variable(GLib.DateTime.new_now_local(), {
    poll: [1000, () => GLib.DateTime.new_now_local()],
});
const time = Utils.derive([clock], (c) => c.format("%a, %I:%M") || "");

export const Date = () =>
    Widget.Box({
        class_name: "bar-applet",
        children: [
            Widget.Button({
                child: Widget.Label({
                    class_name: "bar-button-label",
                    label: time.bind(),
                }),
                onClicked: () => App.toggleWindow("dropdown-1-date"),
                class_name: "bar-button",
            }),
        ],
    });
