const initRender = Variable(true);

setTimeout(() => {
    initRender.value = false;
}, 2000);

export const DropdownMenu = ({ widget_name, child, monitor = 0 }) => {
    return Widget.Window({
        monitor,
        class_name: "dropdown",
        setup: (w) => w.keybind('Escape', () => App.closeWindow(`dropdown-${monitor}-${widget_name}`)),
        name: `dropdown-${monitor}-${widget_name}`,
        layer: "top",
        anchor: ["top", "right"],
        visible: initRender.bind('value'),
        child: Widget.Revealer({
            transitionDuration: 500,
            transition: "crossfade",
            setup: self => self.hook(App, (_, wname, visible) => {
                if (wname === `dropdown-${monitor}-${widget_name}`)
                    self.reveal_child = visible
            }),
            child: Widget.Box({
                class_name: "popup-window-content",
                children: [ child ],
            })
        }),
        margins: [10, 10, 0, 10]
    })
}