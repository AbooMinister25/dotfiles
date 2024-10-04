import GLib from 'gi://GLib';
import { DropdownMenu } from "../dropdown.js";

const clock = Variable(GLib.DateTime.new_now_local(), {
    poll: [1000, () => GLib.DateTime.new_now_local()],
})
const time = Utils.derive([clock], (c) => c.format("%I:%M") || "")
const period = Utils.derive([clock], (c) => c.format("%p") || "")

const TimeWidget = () => {
    return Widget.Box({
        class_name: 'date-menu-item-container',
        hpack: 'fill',
        vpack: 'fill',
        expand: true,
        child: Widget.Box({
            class_name: "menu-container-box",
            expand: true,
            hpack: 'center',
            vpack: 'fill',
            class_name: 'clock-box',
            children: [
                Widget.Label({
                    hpack: 'center',
                    class_name: "clock-time",
                    label: time.bind()
                }),
                Widget.Label({
                    hpack: 'center',
                    vpack: 'end',
                    class_name: "clock-period",
                    label: period.bind()
                })
            ],
        }),
    });
}

const CalendarWidget = () => {
    return Widget.Box({
        class_name: 'date-menu-item-container',
        hpack: 'fill',
        vpack: 'fill',
        expand: true,
        child: Widget.Box({
            class_name: 'menu-container-box',
            child: Widget.Calendar({
                expand: true,
                hpack: 'fill',
                vpack: 'fill',
                class_name: 'calendar',
                showDayNames: true,
                showDetails: false,
                showHeading: true,
            }),
        }),
    });
};

export const DateMenu = () => DropdownMenu({
    widget_name: "date",
    child: Widget.Box({
        class_name: 'calendar-menu-content',
        vertical: true,
        children: [
            TimeWidget(),
            CalendarWidget(),
        ]
    }),
    monitor: 1
})