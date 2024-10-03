const hyprland = await Service.import("hyprland")

const dispatch = ws => hyprland.messageAsync(`dispatch workspace ${ws}`);
export const Workspaces = (monitor = 0) => Widget.EventBox({
    onScrollUp: () => dispatch('r+1'),
    onScrollDown: () => dispatch('r-1'),
    child: Widget.Box({
        children: Array.from({ length: 10 }, (_, i) => i + (monitor == 0 ? 1 : 11)).map(i => Widget.Button({
            attribute: {
                id: i,
                isUrgent: false
            },
            onClicked: () => dispatch(i),
            setup: (self) => {
                self.hook(hyprland, () => {
                    if (hyprland.active.monitor.id == monitor) {
                        self.toggleClassName("active", hyprland.active.workspace.id == i)

                        if (hyprland.active.workspace.id == i) {
                            self.toggleClassName("occupied", false)
                            self.attribute.isUrgent = false
                            self.toggleClassName("urgent", self.attribute.isUrgent)
                        } else {
                            self.toggleClassName("occupied", (hyprland.getWorkspace(i)?.windows || 0) > 0)
                        }
                    }
                })
                self.hook(hyprland, (_, address) => {
                    if (hyprland.getClient(address).workspace.id == self.attribute.id) {
                        self.attribute.isUrgent = true
                        self.toggleClassName("urgent", self.attribute.isUrgent)
                    }
                }, "urgent-window")
            },
            class_name: "workspace-button"
        })),
        class_names: ["workspaces-box", "bar-applet"]
    }),
    class_name: "workspaces",
})
