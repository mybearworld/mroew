import mroew/blocks.{type Operator, Block, Input, OComplex, OInt}

pub fn add(operator: Operator, operator2: Operator) {
  OComplex(
    Block(
      opcode: "add",
      inputs: [
        Input(name: "NUM_1", default: OInt(2), value: operator),
        Input(name: "NUM_2", default: OInt(2), value: operator2),
      ],
      fields: [],
    ),
  )
}
