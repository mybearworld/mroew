import mroew/blocks.{type Blocks, Block}

pub fn show(cblocks: Blocks) {
  blocks.stack(cblocks, Block(opcode: "show"))
}
