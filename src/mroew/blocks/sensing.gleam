import gleam/option.{None, Some}
import mroew/blocks.{
  type Blocks, type Operator, Block, Field, Input, OComplex, OString,
}

fn touching_sprite(cblocks: Blocks, sprite: Operator) {
  Block(
    opcode: "sensing_touchingobject",
    inputs: [
      Input(
        name: "TOUCHINGOBJECTMENU",
        default: Some(
          OComplex(
            Block(opcode: "sensing_touchingobjectmenu", inputs: [], fields: [
              Field(name: "TOUCHINGOBJECTMENU", value: "_edge_", subvalue: None),
            ]),
          ),
        ),
        value: sprite,
      ),
    ],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn touching_mouse(cblocks: Blocks) {
  touching_sprite(cblocks, OString("_mouse_"))
}

pub fn touching_edge(cblocks: Blocks) {
  touching_sprite(cblocks, OString("_edge_"))
}

pub fn touching_color(color: Operator) {
  Block(opcode: "sensing_touchingcolor", fields: [], inputs: [
    Input(name: "COLOR", default: Some(OString("#666666")), value: color),
  ])
  |> OComplex
}

pub fn color_touching_color(color: Operator, color2: Operator) {
  Block(opcode: "sensing_touchingcolor", fields: [], inputs: [
    Input(name: "COLOR1", default: Some(OString("#666666")), value: color),
    Input(name: "COLOR2", default: Some(OString("#666666")), value: color2),
  ])
  |> OComplex
}

pub fn distance_sprite(cblocks: Blocks, sprite: Operator) {
  Block(
    opcode: "sensing_distanceto",
    inputs: [
      Input(
        name: "DISTANCETOMENU",
        default: Some(
          OComplex(
            Block(opcode: "sensing_distanceto_menu", inputs: [], fields: [
              Field(name: "DISTANCETOMENU", value: "_mouse_", subvalue: None),
            ]),
          ),
        ),
        value: sprite,
      ),
    ],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn distance_mouse(cblocks: Blocks) {
  distance_sprite(cblocks, OString("_mouse_"))
}

pub fn ask(cblocks: Blocks, question: Operator) {
  Block(
    opcode: "sensing_askandwait",
    inputs: [
      Input(
        name: "QUESTION",
        default: Some(OString("Whats your name?")),
        value: question,
      ),
    ],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn answer() {
  OComplex(Block(opcode: "sensing_answer", fields: [], inputs: []))
}

pub fn key(cblocks: Blocks, key: Operator) {
  Block(
    opcode: "sensing_keypressed",
    inputs: [
      Input(
        name: "KEY_OPTION",
        default: Some(
          OComplex(
            Block(opcode: "sensing_keyoptions", inputs: [], fields: [
              Field(name: "KEY_OPTION", value: "any", subvalue: None),
            ]),
          ),
        ),
        value: key,
      ),
    ],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn mouse_down() {
  Block(opcode: "sensing_mousedown", fields: [], inputs: [])
  |> OComplex
}

pub fn mouse_x() {
  Block(opcode: "sensing_mousex", fields: [], inputs: [])
  |> OComplex
}

pub fn mouse_y() {
  Block(opcode: "sensing_mousey", fields: [], inputs: [])
  |> OComplex
}

pub fn set_draggable(cblocks: Blocks, draggability: Bool) {
  Block(opcode: "sensing_setdragmode", inputs: [], fields: [
    Field(
      name: "DRAG_MODE",
      value: case draggability {
        True -> "draggable"
        False -> "not draggable"
      },
      subvalue: None,
    ),
  ])
  |> blocks.stack(cblocks)
}

pub fn loduness() {
  Block(opcode: "sensing_loudness", fields: [], inputs: [])
  |> OComplex
}

pub fn timer() {
  Block(opcode: "sensing_timer", fields: [], inputs: [])
  |> OComplex
}

pub fn reset_timer(cblocks: Blocks) {
  Block(opcode: "sensing_resettimer", inputs: [], fields: [])
  |> blocks.stack(cblocks)
}

pub fn property_sprite(property: SpriteProperty, sprite: Operator) {
  base_property(sprite_property_to_string(property), sprite)
}

pub type SpriteProperty {
  XPos
  YPos
  Direction
  CostumeNumber
  CostumeName
  Size
  Volume
}

fn sprite_property_to_string(sprite_property: SpriteProperty) {
  case sprite_property {
    XPos -> "x position"
    YPos -> "y position"
    Direction -> "direction"
    CostumeNumber -> "costume #"
    CostumeName -> "costume name"
    Size -> "size"
    Volume -> "volume"
  }
}

pub fn property_stage(property: StageProperty, sprite: Operator) {
  base_property(stage_property_to_string(property), sprite)
}

pub type StageProperty {
  BackdropNumber
  BackdropName
  StageVolume
}

fn stage_property_to_string(stage_property: StageProperty) {
  case stage_property {
    BackdropNumber -> "backdrop #"
    BackdropName -> "backdrop name"
    StageVolume -> "volume"
  }
}

fn base_property(property: String, sprite: Operator) {
  Block(
    opcode: "sensing_of",
    inputs: [
      Input(
        name: "OBJECT",
        default: Some(
          OComplex(
            Block(opcode: "sensing_of_object_menu", inputs: [], fields: [
              Field(name: "OBJECT", value: "_stage_", subvalue: None),
            ]),
          ),
        ),
        value: sprite,
      ),
    ],
    fields: [Field(name: "PROPERTY", value: property, subvalue: None)],
  )
  |> OComplex
}

pub fn current(time: Time) {
  Block(opcode: "sensing_current", inputs: [], fields: [
    Field(name: "CURRENTMENU", value: time_to_string(time), subvalue: None),
  ])
  |> OComplex
}

pub type Time {
  Year
  Month
  Date
  Weekday
  Hour
  Minute
  Second
}

fn time_to_string(time: Time) {
  case time {
    Year -> "YEAR"
    Month -> "MONTH"
    Date -> "DATE"
    Weekday -> "DAYOFWEEK"
    Hour -> "HOUR"
    Minute -> "MINUTE"
    Second -> "SECOND"
  }
}

pub fn days_since_2000() {
  Block(opcode: "sensing_dayssince2000", fields: [], inputs: [])
  |> OComplex
}

pub fn username() {
  Block(opcode: "sensing_username", fields: [], inputs: [])
  |> OComplex
}
