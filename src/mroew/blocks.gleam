import gleam/list
import gleam/option.{type Option}

pub type Blocks =
  List(Block)

pub type Block {
  Block(
    opcode: String,
    inputs: List(#(String, Operator, Operator)),
    fields: List(#(String, String, Option(String))),
  )
}

pub type Operator {
  OInt(Int)
  OFloat(Float)
  OString(String)
  OComplex(Block)
}

pub fn hat(opcode: String) -> Blocks {
  [Block(opcode: opcode, inputs: [], fields: [])]
}

pub fn stack(blocks: Blocks, block: Block) -> Blocks {
  list.append(blocks, [block])
}
