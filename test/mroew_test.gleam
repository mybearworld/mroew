import gleam/io
import mroew/blocks.{OString}
import mroew/blocks/looks
import mroew/blocks/events
import mroew/sprite

pub fn main() {
  io.debug(
    sprite.sprite([])
    |> sprite.blocks(
      events.on_flag()
      |> looks.say(OString("Hello, world!")),
    ),
  )
}
