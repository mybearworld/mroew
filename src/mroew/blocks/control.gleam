import gleam/option.{None}
import mroew/blocks.{type Operator, Block, Input, boolean}

pub fn repeat_until(condition: Operator) {
  blocks.hat(
    Block(
      opcode: "repeat_until",
      inputs: [
        Input(name: "CONDITION", default: None, value: boolean(condition)),
      ],
      fields: [],
    ),
  )
}
