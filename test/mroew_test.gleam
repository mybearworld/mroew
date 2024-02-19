import mroew/blocks.{c}
import mroew/blocks/control
import mroew/blocks/looks
import mroew/blocks/events
import mroew/blocks/ops
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
        control.cond(ops.bool(True))
        |> looks.say_timed(ops.string("Hi"), ops.int(2)),
      ),
    ),
  )
}
