import gleam/option.{None}
import mroew/blocks.{type Blocks, Block, Field, OComplex}

pub fn set_draggable(cblocks: Blocks, draggability: String) {
  Block(opcode: "set_draggable", inputs: [], fields: [
    Field(name: "DRAG_MODE", value: draggability, subvalue: None),
  ])
  |> blocks.stack(cblocks)
}

pub fn mouse_down() {
  OComplex(Block(opcode: "mouse_down", fields: [], inputs: []))
}
