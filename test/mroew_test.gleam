import gleam/io
import mroew/blocks.{OBool, OInt}
import mroew/blocks/events
import mroew/blocks/motion
import mroew/blocks/ops

pub fn main() {
  io.debug(
    events.on_flag()
    |> motion.go(
      OBool(True)
      |> ops.and(OBool(False)),
    ),
  )
}
