import { Bar } from "./widgets/bar/index.js"
import menus from "./widgets/menu/index.js";


const scss = `${App.configDir}/style/style.scss`;
const css = `/tmp/style.css`;
Utils.exec(`sass ${scss} ${css}`)

App.config({
  style: css,
  windows: [
    Bar(),
    Bar(1),
    ...menus,
  ]
})
