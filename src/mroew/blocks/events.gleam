import gleam/option.{None, Some}
import mroew/blocks.{
  type Blocks, type Operator, Block, Field, Input, OInt, OMessage,
}

pub fn on_flag() {
  blocks.hat(Block(opcode: "event_whenflagclicked", inputs: [], fields: []))
}

pub fn on_key(key: String) {
  blocks.hat(
    Block(opcode: "event_whenkeypressed", inputs: [], fields: [
      Field(name: "KEY_OPTION", value: key, subvalue: None),
    ]),
  )
}

pub fn on_sprite_click() {
  blocks.hat(
    Block(opcode: "event_whenthisspriteclicked", inputs: [], fields: []),
  )
}

pub fn on_backdrop(backdrop: String) {
  blocks.hat(
    Block(opcode: "event_whenbackdropswitchesto", inputs: [], fields: [
      Field(name: "BACKDROP", value: backdrop, subvalue: None),
    ]),
  )
}

pub fn on_timer(time: Operator) {
  blocks.hat(
    Block(
      opcode: "event_whengreaterthan",
      inputs: [Input(name: "VALUE", default: Some(OInt(10)), value: time)],
      fields: [
        Field(name: "WHENGREATERTHANMENU", value: "TIMER", subvalue: None),
      ],
    ),
  )
}

pub fn on_loudness(loudness: Operator) {
  blocks.hat(
    Block(
      opcode: "event_whengreaterthan",
      inputs: [Input(name: "VALUE", default: Some(OInt(10)), value: loudness)],
      fields: [
        Field(name: "WHENGREATERTHANMENU", value: "LOUDNESS", subvalue: None),
      ],
    ),
  )
}

pub fn on_message(message: String) {
  blocks.hat(
    Block(opcode: "event_whengreaterthan", inputs: [], fields: [
      Field(name: "BROADCAST_OPTION", value: message, subvalue: None),
    ]),
  )
}

pub fn broadcast(cblocks: Blocks, message: Operator) {
  Block(
    opcode: "event_broadcast",
    inputs: [
      Input(
        name: "BROADCAST_INPUT",
        default: Some(OMessage("message1")),
        value: blocks.to_complex(message),
      ),
    ],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn broadcast_wait(cblocks: Blocks, message: Operator) {
  Block(
    opcode: "event_broadcastandwait",
    inputs: [
      Input(
        name: "BROADCAST_INPUT",
        default: Some(OMessage("message1")),
        value: blocks.to_complex(message),
      ),
    ],
    fields: [],
  )
  |> blocks.stack(cblocks)
}
