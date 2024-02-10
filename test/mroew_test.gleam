import gleam/io
import mroew/blocks.{OString, c, true}
import mroew/blocks/control
import mroew/blocks/events
import mroew/blocks/motion
import mroew/blocks/ops

pub fn main() {
  io.debug(
    events.on_flag()
    |> motion.go_sprite(
      true
      |> ops.and(true),
    )
    |> c(
      control.cond(true)
      |> events.broadcast(OString("message")),
    ),
  )
}
