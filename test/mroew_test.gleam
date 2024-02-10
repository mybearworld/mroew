import gleam/io
import mroew/blocks/events
import mroew/blocks/looks

pub fn main() {
  io.debug(
    events.on_flag()
    |> looks.show(),
  )
}
