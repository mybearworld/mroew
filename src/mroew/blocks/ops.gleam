import gleam/option.{None, Some}
import mroew/blocks.{type Operator, Block, Input, OComplex, OInt, boolean}

pub fn add(operator: Operator, operator2: Operator) {
  OComplex(
    Block(
      opcode: "add",
      inputs: [
        Input(name: "NUM_1", default: Some(OInt(2)), value: operator),
        Input(name: "NUM_2", default: Some(OInt(2)), value: operator2),
      ],
      fields: [],
    ),
  )
}

pub fn and(operator: Operator, operator2: Operator) {
  OComplex(
    Block(
      opcode: "and",
      inputs: [
        Input(name: "INPUT_1", default: None, value: boolean(operator)),
        Input(name: "INPUT_2", default: None, value: boolean(operator2)),
      ],
      fields: [],
    ),
  )
}
