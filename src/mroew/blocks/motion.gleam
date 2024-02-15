import gleam/option.{None, Some}
import mroew/blocks.{
  type Blocks, type Operator, Block, Field, Input, OComplex, OInt, OString,
}

pub type Location {
  Mouse
  Random
}

fn location_to_string(location: Location) {
  case location {
    Mouse -> "_mouse_"
    Random -> "_random_"
  }
}

pub fn move(cblocks: Blocks, steps: Operator) {
  Block(
    opcode: "motion_movesteps",
    inputs: [Input(name: "STEPS", default: Some(OInt(10)), value: steps)],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn turn(cblocks: Blocks, degrees: Operator) {
  Block(
    opcode: "motion_turnright",
    inputs: [Input(name: "DEGREES", default: Some(OInt(15)), value: degrees)],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn go_sprite(cblocks: Blocks, sprite: Operator) {
  Block(
    opcode: "motion_goto",
    inputs: [
      Input(
        name: "TO",
        default: Some(
          OComplex(
            Block(opcode: "motion_goto_menu", inputs: [], fields: [
              Field(name: "TO", value: "_random_", subvalue: None),
            ]),
          ),
        ),
        value: blocks.to_complex(sprite),
      ),
    ],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn go(cblocks: Blocks, location: Location) {
  go_sprite(cblocks, OString(location_to_string(location)))
}

pub fn position(cblocks: Blocks, x: Operator, y: Operator) {
  Block(opcode: "motion_gotoxy", fields: [], inputs: [
    Input(name: "X", default: Some(OInt(0)), value: x),
    Input(name: "Y", default: Some(OInt(0)), value: y),
  ])
  |> blocks.stack(cblocks)
}

pub fn glide_sprite(cblocks: Blocks, seconds: Operator, sprite: Operator) {
  Block(
    opcode: "motion_glideto",
    inputs: [
      Input(name: "SECS", default: Some(OInt(1)), value: seconds),
      Input(
        name: "TO",
        default: Some(
          OComplex(
            Block(opcode: "motion_glideto_menu", inputs: [], fields: [
              Field(name: "TO", value: "_random_", subvalue: None),
            ]),
          ),
        ),
        value: blocks.to_complex(sprite),
      ),
    ],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn glide_to(cblocks: Blocks, seconds: Operator, location: Location) {
  glide_sprite(cblocks, seconds, OString(location_to_string(location)))
}

pub fn glide(cblocks: Blocks, seconds: Operator, x: Operator, y: Operator) {
  Block(opcode: "motion_glidesecstoxy", fields: [], inputs: [
    Input(name: "SECS", default: Some(OInt(1)), value: seconds),
    Input(name: "X", default: Some(OInt(0)), value: x),
    Input(name: "y", default: Some(OInt(0)), value: y),
  ])
  |> blocks.stack(cblocks)
}

pub fn set_direction(cblocks: Blocks, direction: Operator) {
  Block(opcode: "motion_pointindirection", fields: [], inputs: [
    Input(name: "DIRECTION", default: Some(OInt(90)), value: direction),
  ])
  |> blocks.stack(cblocks)
}

pub fn point_to_sprite(cblocks: Blocks, sprite: Operator) {
  Block(
    opcode: "motion_pointtowards",
    inputs: [
      Input(
        name: "TOWARDS",
        default: Some(
          OComplex(
            Block(opcode: "motion_pointtowards_menu", inputs: [], fields: [
              Field(name: "TOWARDS", value: "_random_", subvalue: None),
            ]),
          ),
        ),
        value: blocks.to_complex(sprite),
      ),
    ],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn point_to(cblocks: Blocks, location: Location) {
  point_to_sprite(cblocks, OString(location_to_string(location)))
}

pub fn change_x(cblocks: Blocks, dx: Operator) {
  Block(opcode: "motion_changexby", fields: [], inputs: [
    Input(name: "DX", default: Some(OInt(10)), value: dx),
  ])
  |> blocks.stack(cblocks)
}

pub fn set_x(cblocks: Blocks, x: Operator) {
  Block(opcode: "motion_setx", fields: [], inputs: [
    Input(name: "X", default: Some(OInt(0)), value: x),
  ])
  |> blocks.stack(cblocks)
}

pub fn change_y(cblocks: Blocks, dy: Operator) {
  Block(opcode: "motion_changeyby", fields: [], inputs: [
    Input(name: "DY", default: Some(OInt(10)), value: dy),
  ])
  |> blocks.stack(cblocks)
}

pub fn set_y(cblocks: Blocks, y: Operator) {
  Block(opcode: "motion_sety", fields: [], inputs: [
    Input(name: "Y", default: Some(OInt(0)), value: y),
  ])
  |> blocks.stack(cblocks)
}

pub fn bounce_on_edge(cblocks: Blocks) {
  Block(opcode: "motion_ifonedgebounce", fields: [], inputs: [])
  |> blocks.stack(cblocks)
}

pub fn rotation_style(cblocks: Blocks, style: RotationStyle) {
  Block(
    opcode: "motion_ifonedgebounce",
    fields: [
      Field(
        name: "STYLE",
        value: rotation_style_to_string(style),
        subvalue: None,
      ),
    ],
    inputs: [],
  )
  |> blocks.stack(cblocks)
}

pub type RotationStyle {
  LeftRight
  AllAround
  DontRotate
}

fn rotation_style_to_string(style: RotationStyle) {
  case style {
    LeftRight -> "left-right"
    AllAround -> "all around"
    DontRotate -> "don't rotate"
  }
}

pub fn x() {
  Block(opcode: "motion_xposition", inputs: [], fields: [])
  |> OComplex
}

pub fn y() {
  Block(opcode: "motion_yposition", inputs: [], fields: [])
  |> OComplex
}

pub fn direction() {
  Block(opcode: "motion_direction", inputs: [], fields: [])
  |> OComplex
}
