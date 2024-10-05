const audio = await Service.import("audio");

let count = 0;
function show_bar(revealer) {
    revealer.reveal_child = true;
    count++;

    Utils.timeout(2000, () => {
        count--;

        if (count == 0) revealer.reveal_child = false;
    });
}

let ocount = 0;
function show_osd(window) {
    window.visible = true;
    ocount++;

    Utils.timeout(2000, () => {
        ocount--;

        if (count == 0) window.visible = false;
    });
}

function OSDIcon() {
    return Widget.Icon({
        class_name: "osd-icon",
        setup: (self) => {
            self.hook(
                audio.speaker,
                () => {
                    self.icon =
                        audio.speaker.volume == 0
                            ? "/home/rcyclegar/nixos-config/home/ags/assets/volume-off.svg"
                            : "/home/rcyclegar/nixos-config/home/ags/assets/volume.svg";
                },
                "notify::volume"
            );
        },
    });
}

function OSDLabel() {
    return Widget.Label({
        class_name: "osd-label",
        setup: (self) => {
            self.hook(
                audio.speaker,
                () => {
                    self.label = `${Math.round(audio.speaker.volume * 100)}`;
                },
                "notify::volume"
            );
        },
    });
}

function OSDBar() {
    return Widget.Revealer({
        transition: "crossfade",
        reveal_child: false,
        child: Widget.Box({
            class_name: "osd-container",
            vertical: true,
            children: [
                Widget.LevelBar({
                    class_name: "osd-bar",
                    vertical: true,
                    inverted: true,
                    bar_mode: "continuous",
                    widthRequest: 15,
                    setup: (self) => {
                        self.hook(
                            audio.speaker,
                            () => {
                                self.toggleClassName(
                                    "overflow",
                                    audio.speaker.volume > 1
                                );
                                self.value = audio.speaker.volume;
                            },
                            "notify::volume"
                        );
                    },
                }),
            ],
        }),
        setup: (self) => {
            self.hook(audio.speaker, () => show_bar(self), "notify::volume");
        },
    });
}

export const OSD = () => {
    Widget.Window({
        monitor: 1,
        name: `osd-indicator`,
        class_name: "osd",
        layer: "overlay",
        click_through: true,
        visible: false,
        anchor: ["right"],
        child: Widget.Box({
            vertical: true,
            children: [OSDIcon(), OSDBar(), OSDLabel()],
        }),
        setup: (self) => {
            self.hook(audio.speaker, () => show_osd(self), "notify::volume");
        },
        margins: [10, 10, 0, 10],
    });
};
