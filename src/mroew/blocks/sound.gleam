import gleam/option.{None, Some}
import mroew/blocks.{
  type Blocks, type Operator, Block, Field, Input, OComplex, OInt,
}

pub fn play_wait(cblocks: Blocks, sound: Operator) {
  Block(
    opcode: "sound_playuntildone",
    inputs: [
      Input(
        name: "SOUND_MENU",
        default: sound_menu(),
        value: blocks.to_complex(sound),
      ),
    ],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn play(cblocks: Blocks, sound: Operator) {
  Block(
    opcode: "sound_play",
    inputs: [
      Input(
        name: "SOUND_MENU",
        default: sound_menu(),
        value: blocks.to_complex(sound),
      ),
    ],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

fn sound_menu() {
  Some(
    OComplex(
      Block(opcode: "sound_sounds_menu", inputs: [], fields: [
        Field(name: "SOUND_MENU", value: "Meow", subvalue: None),
      ]),
    ),
  )
}

pub fn stop_all(cblocks: Blocks) {
  Block(opcode: "sound_stopallsounds", inputs: [], fields: [])
  |> blocks.stack(cblocks)
}

pub fn change_effect(cblocks: Blocks, amount: Operator, effect: SoundEffect) {
  Block(
    opcode: "sound_changeeffectby",
    inputs: [Input(name: "VALUE", default: Some(OInt(10)), value: amount)],
    fields: [
      Field(
        name: "EFFECT",
        value: sound_effect_to_string(effect),
        subvalue: None,
      ),
    ],
  )
  |> blocks.stack(cblocks)
}

pub fn set_effect(cblocks: Blocks, amount: Operator, effect: SoundEffect) {
  Block(
    opcode: "sound_seteffectto",
    inputs: [Input(name: "VALUE", default: Some(OInt(10)), value: amount)],
    fields: [
      Field(
        name: "EFFECT",
        value: sound_effect_to_string(effect),
        subvalue: None,
      ),
    ],
  )
  |> blocks.stack(cblocks)
}

pub type SoundEffect {
  Pitch
  Pan
}

fn sound_effect_to_string(sound_effect: SoundEffect) {
  case sound_effect {
    Pitch -> "PITCH"
    Pan -> "PAN"
  }
}

pub fn clear_effects(cblocks: Blocks) {
  Block(opcode: "sound_cleareffects", inputs: [], fields: [])
  |> blocks.stack(cblocks)
}

pub fn change_volume(cblocks: Blocks, volume: Operator) {
  Block(
    opcode: "sound_changevolumeby",
    inputs: [Input(name: "VOLUME", default: Some(OInt(-10)), value: volume)],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn set_volume(cblocks: Blocks, volume: Operator) {
  Block(
    opcode: "sound_setvolumeto",
    inputs: [Input(name: "VOLUME", default: Some(OInt(100)), value: volume)],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn volume() {
  OComplex(Block(opcode: "sound_volume", inputs: [], fields: []))
}
