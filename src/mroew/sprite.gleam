import gleam/list
import mroew/blocks.{type Blocks}

pub type Sprite {
  Sprite(
    name: String,
    blocks: List(Blocks),
    costumes: List(#(String, String)),
    sounds: List(#(String, String)),
  )
}

pub fn sprite(name: String) {
  Sprite(name: name, blocks: [], costumes: [], sounds: [])
}

pub fn costume(sprite: Sprite, name: String, costume: String) {
  Sprite(..sprite, costumes: list.append(sprite.costumes, [#(name, costume)]))
}

pub fn sound(sprite: Sprite, name: String, sound: String) {
  Sprite(..sprite, sounds: list.append(sprite.sounds, [#(name, sound)]))
}

pub fn blocks(sprite: Sprite, new_blocks: Blocks) {
  Sprite(..sprite, blocks: list.append(sprite.blocks, [new_blocks]))
}
