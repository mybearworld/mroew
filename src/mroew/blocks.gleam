import gleam/list

pub type Blocks =
  List(Block)

pub type Block {
  Block(opcode: String, inputs: List(#(String, Operator, Operator)))
}

pub type Operator {
  OInt(Int)
  OFloat(Float)
  OString(String)
  OComplex(Block)
}

pub fn hat(opcode: String) -> Blocks {
  [Block(opcode: opcode, inputs: [])]
}

pub fn stack(blocks: Blocks, block: Block) -> Blocks {
  list.append(blocks, [block])
}
