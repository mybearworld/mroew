import gleam/string
import gleam/list
import mroew/blocks.{type Blocks}
import filepath
import simplifile

pub type Sprite {
  Sprite(
    name: String,
    blocks: List(Blocks),
    costumes: List(Costume),
    sounds: List(Sound),
  )
}

pub type Costume {
  Costume(
    name: String,
    path: String,
    file_type: ImageType,
    content: BitArray,
    md5: String,
  )
}

pub type ImageType {
  Png
  Svg
}

pub type Sound {
  Sound(
    name: String,
    path: String,
    file_type: String,
    content: BitArray,
    md5: String,
  )
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
  let #(content, md5) = get_content_md5(costume)

  Sprite(
    ..sprite,
    costumes: list.append(sprite.costumes, [
      Costume(name: name, path: costume, content: content, md5: md5, file_type: case
        string.ends_with(costume, ".svg")
      {
        True -> Svg
        False -> Png
      }),
    ]),
  )
}

pub fn sound(sprite: Sprite, name: String, sound: String) {
  let #(content, md5) = get_content_md5(sound)
  Sprite(
    ..sprite,
    sounds: list.append(sprite.sounds, [
      Sound(name: name, path: sound, content: content, md5: md5, file_type: case
        filepath.extension(sound)
      {
        Ok(value) -> value
        Error(_) -> panic as "Sound " <> sound <> " without extension"
      }),
    ]),
  )
}

fn get_content_md5(file_path: String) {
  let assert Ok(content) = simplifile.read_bits(file_path)
  #(content, md5(content))
}

pub fn blocks(sprite: Sprite, new_blocks: Blocks) {
  Sprite(..sprite, blocks: list.append(sprite.blocks, [new_blocks]))
}

@external(javascript, "../ffi.mjs", "md5")
fn md5(bit_array: BitArray) -> String
