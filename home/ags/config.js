import { Bar } from "./widgets/bar/index.js";
import { OSD } from "./widgets/osd/index.js";
import menus from "./widgets/menu/index.js";

const scss = `${App.configDir}/style/style.scss`;
const css = `/tmp/style.css`;
Utils.exec(`sass ${scss} ${css}`);

App.addIcons(`${App.configDir}/assets/`);
App.config({
    style: css,
    windows: [Bar(), Bar(1), OSD(), ...menus],
});
