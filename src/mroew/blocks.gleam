import gleam/list

pub type Blocks =
  List(Block)

pub type Block {
  Block(opcode: String)
}

pub fn hat(opcode: String) -> Blocks {
  [Block(opcode: opcode)]
}

pub fn stack(blocks: Blocks, block: Block) -> Blocks {
  list.append(blocks, [block])
}
