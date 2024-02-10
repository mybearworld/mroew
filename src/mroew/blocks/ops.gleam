import mroew/blocks.{type Operator, Block, OComplex, OInt}

pub fn add(operator: Operator, operator2: Operator) {
  OComplex(
    Block(opcode: "add", inputs: [
      #("NUM_1", OInt(2), operator),
      #("NUM_2", OInt(2), operator2),
    ]),
  )
}
