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

pub fn export(project: Project) {
  io.debug(project)
}
