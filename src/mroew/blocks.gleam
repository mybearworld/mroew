import gleam/list

pub type Blocks =
  List(Block)

pub type Block {
  Block(opcode: String)
}

pub fn hat(opcode: String) -> Blocks {
  [Block(opcode: opcode)]
}

pub fn stack(opcode: String) -> fn(Blocks) -> Blocks {
  fn(blocks: Blocks) { list.append(blocks, [Block(opcode: opcode)]) }
}
