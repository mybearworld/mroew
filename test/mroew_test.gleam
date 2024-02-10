import gleam/io
import mroew/blocks.{OInt}
import mroew/blocks/events
import mroew/blocks/looks
import mroew/blocks/ops
import mroew/blocks/sensing

pub fn main() {
  io.debug(
    events.on_flag()
    |> looks.set_size(
      OInt(1)
      |> ops.and(OInt(2)),
    )
    |> sensing.set_draggable("draggable"),
  )
}
