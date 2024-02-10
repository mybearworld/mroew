import gleam/option.{None}
import mroew/blocks.{type Blocks, Block}

pub fn set_draggable(cblocks: Blocks, draggability: String) {
  blocks.stack(
    cblocks,
    Block(opcode: "set_draggable", inputs: [], fields: [
      #("DRAG_MODE", draggability, None),
    ]),
  )
}
