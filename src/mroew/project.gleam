import gleam/io
import gleam/int
import gleam/list
import gleam/json
import mroew/blocks.{type Block, type Blocks, BTBlock, BTBlocks}
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
  let json = project_json(project)

  zip()
  |> file("project.json", "{}")
  |> out(name)
  io.debug(project)
  io.print(
    json
    |> json.to_string,
  )
}

fn project_json(project: Project) {
  json.object([
    #("targets", json.preprocessed_array(list.map(project, to_target))),
    #("extensions", json.array([], json.string)),
    #("monitors", json.array([], json.string)),
    #(
      "meta",
      json.object([
        #("semver", json.string("3.0.0")),
        #("vm", json.string("2.1.1")),
        #("agent", json.string("Mröw")),
      ]),
    ),
  ])
}

fn to_target(sprite: Sprite) {
  json.object([
    #(
      "blocks",
      json.preprocessed_array(
        {
          sprite.blocks
          |> list.map_fold(0, fn(script_index, script) {
            #(script_index + 1, blocks_to_json(script, script_index))
          })
        }.1,
      ),
    ),
    #("isStage", json.bool(False)),
    #("name", json.string(sprite.name)),
    #("volume", json.int(100)),
    #("layerOrder", json.int(1)),
    #("visible", json.bool(True)),
    #("x", json.int(0)),
    #("y", json.int(0)),
    #("size", json.int(100)),
    #("direction", json.int(90)),
    #("draggable", json.bool(False)),
    #("rotationStyle", json.string("all around")),
  ])
  // todo: the stage exists
}

fn blocks_to_json(blocks: Blocks, script_index: Int) {
  let items =
    list.map_fold(blocks, 0, fn(index, block) {
      let return = case block {
        BTBlocks(_blocks) -> #(index + 1, [])
        // to do
        BTBlock(block) ->
          block_to_json(
            block,
            index == 0,
            int.to_string(script_index) <> "::" <> int.to_string(index) <> "::",
            index,
          )
      }

      return
    }).1
    |> list.flatten
  json.object(items)
}

fn block_to_json(
  block: Block,
  toplevel: Bool,
  id_prefix: String,
  last_block_index: Int,
) {
  let new_subindex = last_block_index + 1
  #(new_subindex, [
    #(
      id_prefix
      <> int.to_string(new_subindex),
      json.object([
        #("next", json.string(id_prefix <> int.to_string(new_subindex + 1))),
        #("opcode", json.string(block.opcode)),
        #("topLevel", json.bool(toplevel)),
        #("x", json.int(0)),
        #("y", json.int(0)),
        #("inputs", json.preprocessed_array([])),
        #("fields", json.preprocessed_array([])),
      ]),
    ),
  ])
}

type Zip

@external(javascript, "../zip.mjs", "zip")
fn zip() -> Zip

@external(javascript, "../zip.mjs", "file")
fn file(zip: Zip, file_name: String, data: String) -> Zip

@external(javascript, "../zip.mjs", "out")
fn out(zip: Zip, file_name: String) -> Zip
