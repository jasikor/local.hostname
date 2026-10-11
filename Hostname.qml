import QtQuick
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "local.hostname"

  property string hostname: Quickshell.env("HOSTNAME") || ""
  readonly property bool upper: String(root.setting("upper", false)) === "true"
  readonly property string label: root.upper ? root.setting("label", root.hostname).toUpperCase()
                                               : root.setting("label", root.hostname)

  readonly property int pad: Math.max(0, Number(root.setting("pad", 2)))
  readonly property string paddedLabel: " ".repeat(pad) + root.label + " ".repeat(pad)
  readonly property string weightName: String(root.setting("weight", "bold"))
  readonly property int fontWeight: root.weightName === "black" ? Font.Black
    : (root.weightName === "normal" ? Font.Normal : Font.Bold)
  readonly property int fontSize: Number(root.setting("fontSize", Style.font.body))
  // "rotated" (default) or "stacked" (upright letters, vertical bars only).
  readonly property bool stacked: root.vertical && String(root.setting("mode", "rotated")) === "stacked"
  readonly property var chars: root.paddedLabel.split("")

  // Optional colour override, e.g. omarchy bar set local.hostname color "#ffbf00"
  readonly property string colorSetting: String(root.setting("color", ""))
  readonly property color fg: root.colorSetting !== "" ? root.colorSetting : (bar ? bar.barForeground : Color.foreground)
  readonly property string fontFamily: bar ? bar.fontFamily : Style.font.family
  readonly property int barSize: bar ? bar.barSize : Style.bar.sizeHorizontal
  readonly property real margin: Style.spaceReal(8.75)

  FileView {
    path: "/etc/hostname"
    watchChanges: false
    printErrors: false
    onLoaded: root.hostname = String(text() || "").trim()
  }

  implicitWidth: root.vertical
    ? barSize
    : (root.stacked ? stackCol.implicitWidth : labelItem.implicitWidth) + margin * 2
  implicitHeight: root.vertical
    ? (root.stacked ? stackCol.implicitHeight : labelItem.implicitWidth) + margin * 2
    : barSize
  visible: root.paddedLabel.length > 0

  Text {
    id: labelItem
    visible: !root.stacked
    anchors.centerIn: parent
    text: root.paddedLabel
    color: root.fg
    font.family: root.fontFamily
    font.pixelSize: root.fontSize
    font.weight: root.fontWeight
    renderType: Text.NativeRendering
    // Vertical bars are too narrow for horizontal text, so rotate the label
    // (same direction Omarchy's tray uses for vertical items).
    rotation: root.vertical ? 90 : 0
  }

  Column {
    id: stackCol
    visible: root.stacked
    anchors.centerIn: parent

    Repeater {
      model: root.chars

      Text {
        required property string modelData
        text: modelData === "" || modelData === " " ? "\u00A0" : modelData
        color: root.fg
        font.family: root.fontFamily
        font.pixelSize: root.fontSize
        font.weight: root.fontWeight
        renderType: Text.NativeRendering
        horizontalAlignment: Text.AlignHCenter
      }
    }
  }
}
