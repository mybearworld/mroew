import gleam/io
import mroew/blocks.{OFloat, OInt}
import mroew/blocks/events
import mroew/blocks/looks
import mroew/blocks/ops

pub fn main() {
  io.debug(
    events.on_flag()
    |> looks.set_size(
      OInt(1)
      |> ops.add(OInt(5))
      |> ops.add(OInt(-2))
      |> ops.add(OFloat(2.23)),
    ),
  )
}
