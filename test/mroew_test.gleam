import mroew/blocks.{OString}
import mroew/blocks/looks
import mroew/blocks/events
import mroew/project
import mroew/sprite

pub fn main() {
  project.project()
  |> project.add_sprite(sprite1())
  |> project.export()
}

fn sprite1() {
  sprite.sprite("Sprite1")
  |> sprite.costume("Scratch Cat", "https://link/to/scratchCat")
  |> sprite.blocks(
    events.on_flag()
    |> looks.say(OString("Hello, world!")),
  )
}
