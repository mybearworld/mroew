import gleam/list
import mroew/blocks.{type Blocks}

pub type Sprite {
  Sprite(name: String, blocks: List(Blocks), costumes: List(#(String, String)))
}

pub fn sprite(name: String, costumes: List(#(String, String))) {
  Sprite(name: name, blocks: [], costumes: costumes)
}

pub fn blocks(sprite: Sprite, new_blocks: Blocks) {
  Sprite(..sprite, blocks: list.append(sprite.blocks, [new_blocks]))
}
