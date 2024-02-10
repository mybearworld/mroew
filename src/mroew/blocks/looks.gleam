//// TODO: Costume blocks

import gleam/option.{None, Some}
import mroew/blocks.{
  type Blocks, type Operator, Block, Field, Input, OComplex, OInt, OString,
}

pub fn say_timed(cblocks: Blocks, content: Operator, time: Operator) {
  Block(
    opcode: "looks_sayforsecs",
    inputs: [
      Input(name: "MESSAGE", default: Some(OString("Hello!")), value: content),
      Input(name: "SECS", default: Some(OInt(1)), value: time),
    ],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn say(cblocks: Blocks, content: Operator) {
  Block(
    opcode: "looks_say",
    inputs: [
      Input(name: "MESSAGE", default: Some(OString("Hello!")), value: content),
    ],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn think_timed(cblocks: Blocks, content: Operator, time: Operator) {
  Block(
    opcode: "looks_thinkforsecs",
    inputs: [
      Input(name: "MESSAGE", default: Some(OString("Hmm...")), value: content),
      Input(name: "SECS", default: Some(OInt(1)), value: time),
    ],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn think(cblocks: Blocks, content: Operator) {
  Block(
    opcode: "looks_think",
    inputs: [
      Input(name: "MESSAGE", default: Some(OString("Hmm...")), value: content),
    ],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn next_costume(cblocks: Blocks) {
  Block(opcode: "looks_nextcostume", inputs: [], fields: [])
  |> blocks.stack(cblocks)
}

pub fn next_backdrop(cblocks: Blocks) {
  Block(opcode: "looks_nextbackdrop", inputs: [], fields: [])
  |> blocks.stack(cblocks)
}

pub fn change_size(cblocks: Blocks, size: Operator) {
  Block(
    opcode: "looks_changesizeby",
    inputs: [Input(name: "CHANGE", default: Some(OInt(10)), value: size)],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn set_size(cblocks: Blocks, size: Operator) {
  Block(
    opcode: "looks_setsizeto",
    inputs: [Input(name: "SIZE", default: Some(OInt(100)), value: size)],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn change_effect(cblocks: Blocks, effect: Effect, difference: Operator) {
  Block(
    opcode: "looks_changeeffectby",
    inputs: [Input(name: "VALUE", default: Some(OInt(25)), value: difference)],
    fields: [
      Field(name: "EFFECT", value: effect_to_string(effect), subvalue: None),
    ],
  )
  |> blocks.stack(cblocks)
}

pub fn set_effect(cblocks: Blocks, effect: Effect, value: Operator) {
  Block(
    opcode: "looks_seteffectto",
    inputs: [Input(name: "VALUE", default: Some(OInt(25)), value: value)],
    fields: [
      Field(name: "EFFECT", value: effect_to_string(effect), subvalue: None),
    ],
  )
  |> blocks.stack(cblocks)
}

pub type Effect {
  Color
  Fisheye
  Whirl
  Pixelate
  Mosaic
  Brightness
  Ghost
}

fn effect_to_string(effect: Effect) {
  case effect {
    Color -> "COLOR"
    Fisheye -> "FISHEYE"
    Whirl -> "WHIRL"
    Pixelate -> "PIXELATE"
    Mosaic -> "MOSAIC"
    Brightness -> "BRIGHTNESS"
    Ghost -> "GHOST"
  }
}

pub fn clear_effects(cblocks: Blocks) {
  Block(opcode: "looks_cleargraphiceffects", inputs: [], fields: [])
  |> blocks.stack(cblocks)
}

pub fn show(cblocks: Blocks) {
  Block(opcode: "looks_show", inputs: [], fields: [])
  |> blocks.stack(cblocks)
}

pub fn hide(cblocks: Blocks) {
  Block(opcode: "looks_hide", inputs: [], fields: [])
  |> blocks.stack(cblocks)
}

pub fn extreme_layer(cblocks: Blocks, position: FrontBack) {
  Block(opcode: "looks_gotofrontback", inputs: [], fields: [
    Field(
      name: "FRONT_BACK",
      value: front_back_to_string(position),
      subvalue: None,
    ),
  ])
  |> blocks.stack(cblocks)
}

pub fn set_layer(cblocks: Blocks, layer: Operator, position: FrontBack) {
  Block(
    opcode: "looks_goforwardbackwardlayers",
    inputs: [Input(name: "NUM", default: Some(OInt(1)), value: layer)],
    fields: [
      Field(
        name: "FRONT_BACK",
        value: front_back_to_fw_string(position),
        subvalue: None,
      ),
    ],
  )
  |> blocks.stack(cblocks)
}

pub type FrontBack {
  Front
  Back
}

fn front_back_to_string(front_back: FrontBack) {
  case front_back {
    Front -> "front"
    Back -> "back"
  }
}

fn front_back_to_fw_string(front_back: FrontBack) {
  case front_back {
    Front -> "forward"
    Back -> "backward"
  }
}

pub fn costume_number() {
  OComplex(
    Block(opcode: "looks_costumenumbername", inputs: [], fields: [
      Field(name: "NUMBER_NAME", value: "number", subvalue: None),
    ]),
  )
}

pub fn costume_name() {
  OComplex(
    Block(opcode: "looks_costumenumbername", inputs: [], fields: [
      Field(name: "NUMBER_NAME", value: "name", subvalue: None),
    ]),
  )
}

pub fn backdrop_number() {
  OComplex(
    Block(opcode: "looks_backdropnumbername", inputs: [], fields: [
      Field(name: "NUMBER_NAME", value: "number", subvalue: None),
    ]),
  )
}

pub fn backdrop_name() {
  OComplex(
    Block(opcode: "looks_backdropnumbername", inputs: [], fields: [
      Field(name: "NUMBER_NAME", value: "name", subvalue: None),
    ]),
  )
}

pub fn size() {
  OComplex(Block(opcode: "looks_size", inputs: [], fields: []))
}
