import mroew/blocks.{OInt, OString, c, true}
import mroew/blocks/control
import mroew/blocks/looks
import mroew/blocks/events
import mroew/project
import mroew/sprite

pub fn main() {
  project.project(stage())
  |> project.add_sprite(sprite1())
  |> project.export("project.sb3")
}

fn stage() {
  sprite.sprite("Stage")
  |> sprite.costume("Blank", "./test/blank.svg", 0, 0)
}

fn sprite1() {
  sprite.sprite("Sprite1")
  |> sprite.costume("Scratch Cat", "./test/scratchCat.svg", 80, 91)
  |> sprite.sound("Blank", "./test/blank.wav")
  |> sprite.blocks(
    events.on_flag()
    |> c(
      control.forever()
      |> c(
        control.cond(true)
        |> looks.say_timed(OString("Hi"), OInt(2)),
      ),
    ),
  )
}
