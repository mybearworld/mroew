import gleam/option.{None}
import mroew/blocks.{type Blocks, Block, Field, OComplex}

pub fn set_draggable(cblocks: Blocks, draggability: String) {
  blocks.stack(
    cblocks,
    Block(opcode: "set_draggable", inputs: [], fields: [
      Field(name: "DRAG_MODE", value: draggability, subvalue: None),
    ]),
  )
}

pub fn mouse_down() {
  OComplex(Block(opcode: "mouse_down", fields: [], inputs: []))
}
