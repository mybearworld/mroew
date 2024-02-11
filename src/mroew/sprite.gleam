import gleam/list
import mroew/blocks.{type Blocks}

pub type Sprite {
  Sprite(blocks: List(Blocks), costumes: List(#(String, String)))
}

pub fn sprite(costumes: List(#(String, String))) {
  Sprite(blocks: [], costumes: costumes)
}

pub fn blocks(sprite: Sprite, new_blocks: Blocks) {
  Sprite(..sprite, blocks: list.append(sprite.blocks, [new_blocks]))
}
