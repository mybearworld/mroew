import mroew/blocks.{OInt, OString}
import mroew/blocks/looks
import mroew/blocks/events
import mroew/blocks/ops
import mroew/project
import mroew/sprite

pub fn main() {
  project.project()
  |> project.add_sprite(sprite1())
  |> project.export("project.sb3")
}

fn sprite1() {
  sprite.sprite("Sprite1")
  |> sprite.costume("Scratch Cat", "https://link/to/scratchCat")
  |> sprite.blocks(
    events.on_flag()
    |> looks.say_timed(
      OString("Hello, ")
      |> ops.join(OString("world!")),
      OInt(1)
      |> ops.add(OInt(2)),
    ),
  )
}
