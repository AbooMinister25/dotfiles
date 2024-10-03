import GLib from 'gi://GLib';

const clock = Variable(GLib.DateTime.new_now_local(), {
    poll: [1000, () => GLib.DateTime.new_now_local()],
})
const time = Utils.derive([clock], (c) => c.format("%a, %I:%M") || "")

export const Date = () => Widget.Box({
    class_name: "bar-applet",
    children: [Widget.Label({
        class_name: "clock_label",
        label: time.bind()
    })]
});
