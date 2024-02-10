import gleam/io
import mroew/blocks.{OInt}
import mroew/blocks/events
import mroew/blocks/looks

pub fn main() {
  io.debug(
    events.on_flag()
    |> looks.show()
    |> looks.set_size(OInt(1))
    |> looks.show(),
  )
}
