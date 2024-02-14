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
  |> sprite.costume("Blank", "./assets/blank.svg")
}

fn sprite1() {
  sprite.sprite("Sprite1")
  |> sprite.costume("Scratch Cat", "./assets/scratchCat.svg")
  |> sprite.blocks(
    events.on_flag()
    |> looks.say_timed(OString("Hello, world!"), OInt(2)),
  )
}
```

## Documentation

Coming soon!

## Usage

1. Install Gleam and Git if you haven't already.
2. Create a Gleam project:
   ```sh
   gleam new my-scratch-project
   ```
3. Delete the `.github` and `test` folders.
4. Add Mröw as a submodule:
   ```sh
   git submodule add https://github.com/mybearworld/mroew.git
   ```
5. Replace the `[dependencies]` and `[dev-dependencies]` in `gleam.toml` with:
   ```toml
   [dependencies]
   gleam_stdlib = "~> 0.34 or ~> 1.0"
   mroew = { path = "./mroew" }
   ```
6. Create your Mröw project in `src/my-scratch-project.gleam`!
7. To create the sb3 file, run `gleam run`.
8. (Recommended) Add sb3 files to the gitignore:
   ```ignore
   *.sb3
   ```

## To do

- Variables/lists
- Custom blocks - for now you can just make a function
- Proper rotation center for costumes
