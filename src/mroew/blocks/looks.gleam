import gleam/option.{Some}
import mroew/blocks.{type Blocks, type Operator, Block, Input, OInt}

pub fn show(cblocks: Blocks) {
  Block(opcode: "show", inputs: [], fields: [])
  |> blocks.stack(cblocks)
}

pub fn set_size(cblocks: Blocks, size: Operator) {
  Block(
    opcode: "set_size",
    inputs: [Input(name: "SIZE", default: Some(OInt(100)), value: size)],
    fields: [],
  )
  |> blocks.stack(cblocks)
}
