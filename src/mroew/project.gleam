import gleam/io
import gleam/list
import mroew/sprite.{type Sprite}

pub type Project =
  List(Sprite)

pub fn project() -> Project {
  []
}

pub fn add_sprite(project: Project, sprite: Sprite) {
  list.append(project, [sprite])
}

pub fn export(project: Project, name: String) {
  zip()
  |> file("project.json", "{}")
  |> out(name)
  io.debug(project)
}

type Zip

@external(javascript, "../zip.mjs", "zip")
fn zip() -> Zip

@external(javascript, "../zip.mjs", "file")
fn file(zip: Zip, file_name: String, data: String) -> Zip

@external(javascript, "../zip.mjs", "out")
fn out(zip: Zip, file_name: String) -> Zip
