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
  sprite.sprite([])
  |> sprite.blocks(
    events.on_flag()
    |> looks.say(OString("Hello, world!")),
  )
}
