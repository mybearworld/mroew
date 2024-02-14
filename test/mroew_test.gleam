import mroew/blocks.{OString, c}
import mroew/blocks/looks
import mroew/blocks/control
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
  |> sprite.costume("Scratch Cat", "./test/scratchCat.svg")
  |> sprite.sound("Blank", "./test/blank.wav")
  |> sprite.blocks(
    events.on_flag()
    |> looks.say(
      OString("H")
      |> ops.join(OString("e"))
      |> ops.join(OString("l"))
      |> ops.join(OString("l"))
      |> ops.join(OString("!")),
    )
    |> c(
      control.forever()
      |> looks.say(OString("Hi :)")),
    ),
  )
}
