import mroew/blocks/looks
import mroew/blocks/events
import mroew/blocks/ops
import mroew/project
import mroew/sprite
import mroew/blocks/vars

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
  |> sprite.variable("my var")
  |> sprite.blocks(
    events.on_flag()
    |> vars.set_var("my var", ops.int(1))
    |> looks.say_timed(vars.get_var("my var"), ops.int(2))
    |> events.broadcast(ops.string("message1")),
  )
  |> sprite.blocks(
    events.on_message("message1")
    |> looks.say_timed(ops.string("Recieved message"), ops.int(2)),
  )
}
