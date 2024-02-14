import gleam/string
import gleam/list
import mroew/blocks.{type Blocks}
import filepath

pub type Sprite {
  Sprite(
    name: String,
    blocks: List(Blocks),
    costumes: List(Costume),
    sounds: List(Sound),
  )
}

pub type Costume {
  Costume(name: String, path: String, file_type: ImageType)
}

pub type ImageType {
  Png
  Svg
}

pub type Sound {
  Sound(name: String, path: String, file_type: String)
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
  Sprite(
    ..sprite,
    sounds: list.append(sprite.sounds, [
      Sound(name: name, path: sound, file_type: case filepath.extension(sound) {
        Ok(value) -> value
        Error(_) -> panic as "Sound " <> sound <> " without extension"
      }),
    ]),
  )
}

pub fn blocks(sprite: Sprite, new_blocks: Blocks) {
  Sprite(..sprite, blocks: list.append(sprite.blocks, [new_blocks]))
}
