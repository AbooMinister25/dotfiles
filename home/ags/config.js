import { applauncher } from "./applauncher.js"
import { Bar } from "./widgets/bar/index.js"


const scss = `${App.configDir}/style/style.scss`;
const css = `/tmp/style.css`;
Utils.exec(`sass ${scss} ${css}`)

App.config({
  style: css,
  windows: [
    applauncher,
    Bar(),
    Bar(1)
  ]
})
