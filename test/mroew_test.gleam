import gleam/io
import mroew/blocks.{OString, true}
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
    |> events.broadcast(OString("message")),
  )
}
