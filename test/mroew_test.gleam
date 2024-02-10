import gleam/io
import mroew/blocks.{true}
import mroew/blocks/events
import mroew/blocks/motion
import mroew/blocks/ops

pub fn main() {
  io.debug(
    events.on_flag()
    |> motion.go(
      true
      |> ops.and(true),
    ),
  )
}
