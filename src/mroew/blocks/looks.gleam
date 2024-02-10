import mroew/blocks.{type Blocks, type Operator, Block, Input, OInt}

pub fn show(cblocks: Blocks) {
  blocks.stack(cblocks, Block(opcode: "show", inputs: [], fields: []))
}

pub fn set_size(cblocks: Blocks, size: Operator) {
  blocks.stack(
    cblocks,
    Block(
      opcode: "set_size",
      inputs: [Input(name: "SIZE", default: OInt(100), value: size)],
      fields: [],
    ),
  )
}
