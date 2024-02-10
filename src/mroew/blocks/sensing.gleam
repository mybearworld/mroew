import gleam/option.{None}
import mroew/blocks.{type Blocks, Block, Field}

pub fn set_draggable(cblocks: Blocks, draggability: String) {
  blocks.stack(
    cblocks,
    Block(opcode: "set_draggable", inputs: [], fields: [
      Field(name: "DRAG_MODE", value: draggability, subvalue: None),
    ]),
  )
}
