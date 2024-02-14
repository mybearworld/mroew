# Mröw

Write Scratch projects in Gleam.

```gleam
import mroew/blocks.{OInt, OString}
import mroew/blocks/looks
import mroew/blocks/events
import mroew/project
import mroew/sprite

pub fn main() {
  project.project(stage())
  |> project.add_sprite(sprite1())
  |> project.export("project.sb3")
}

fn stage() {
  sprite.sprite("Stage")
  |> sprite.costume("Blank", "./test/blank.svg")
}

fn sprite1() {
  sprite.sprite("Sprite1")
  |> sprite.costume("Scratch Cat", "./test/scratchCat.svg")
  |> sprite.blocks(
    events.on_flag()
    |> looks.say_timed(OString("Hello, world!"), OInt(2)),
  )
}
```

## Documentation

Coming soon!

## Usage

I don't currently know of a way to install packages from GitHub, and I can't upload this to HexDocs because it requires my email adress. Therefore, the way of using Mröw is a bit convoluted right now:

1. Install Gleam if you haven't already.
2. Clone this repository:
   ```sh
   git clone https://github.com/mybearworld/mroew.git
   ```
3. Edit the file in `./test/mroew_test.gleam` to create your Mröw project.
4. To create the sb3, run:
   ```
   gleam test
   ```
5. You'll have the sb3 file ready!

Again, hopefully this will only be temporary, and a proper way will exist in the future.
