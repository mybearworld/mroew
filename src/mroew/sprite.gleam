import gleam/string
import gleam/list
import mroew/blocks.{type Blocks}

pub type Sprite {
  Sprite(
    name: String,
    blocks: List(Blocks),
    costumes: List(Costume),
    sounds: List(#(String, String)),
  )
}

pub type Costume {
  Costume(name: String, path: String, file_type: ImageType)
}

pub type ImageType {
  Png
  Svg
}

pub fn image_type_to_string(image_type: ImageType) {
  case image_type {
    Png -> "png"
    Svg -> "svg"
  }
}

pub fn sprite(name: String) {
  Sprite(name: name, blocks: [], costumes: [], sounds: [])
}

pub fn costume(sprite: Sprite, name: String, costume: String) {
  Sprite(
    ..sprite,
    costumes: list.append(sprite.costumes, [
      Costume(name: name, path: costume, file_type: case
        string.ends_with(costume, ".svg")
      {
        True -> Svg
        False -> Png
      }),
    ]),
  )
}

pub fn sound(sprite: Sprite, name: String, sound: String) {
  Sprite(..sprite, sounds: list.append(sprite.sounds, [#(name, sound)]))
}

pub fn blocks(sprite: Sprite, new_blocks: Blocks) {
  Sprite(..sprite, blocks: list.append(sprite.blocks, [new_blocks]))
}
