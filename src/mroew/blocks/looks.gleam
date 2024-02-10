import mroew/blocks.{type Blocks, type Operator, Block, OInt}

pub fn show(cblocks: Blocks) {
  blocks.stack(cblocks, Block(opcode: "show", inputs: []))
}

pub fn set_size(cblocks: Blocks, size: Operator) {
  blocks.stack(
    cblocks,
    Block(opcode: "set_size", inputs: [#("SIZE", OInt(100), size)]),
  )
}
