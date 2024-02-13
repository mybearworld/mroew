import gleam/io
import gleam/int
import gleam/float
import gleam/list
import gleam/option.{None, Some}
import gleam/json.{type Json}
import mroew/blocks.{
  type Block, type Blocks, BTBlock, BTBlocks, OComplex, OFloat, OInt, OMessage,
  OString,
}
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
    #("extensions", json.preprocessed_array([])),
    #("monitors", json.preprocessed_array([])),
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
            False,
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
  isolated: Bool,
) -> #(Int, List(#(String, Json))) {
  let new_subindex = last_block_index + 1
  let block_id = id_prefix <> int.to_string(new_subindex)

  let inputs =
    list.map_fold(block.inputs, 1, fn(input_index, input) {
      #(input_index + 1, case input.value {
        OComplex(complex_block) -> #(
          block_to_json(
            complex_block,
            False,
            block_id <> "::",
            input_index - 1,
            True,
          ).1,
          #(
            input.name,
            json.preprocessed_array([
              json.int(3),
              json.string(block_id <> "::" <> int.to_string(input_index)),
            ]),
          ),
        )
        _ -> #([], #(
          input.name,
          json.preprocessed_array([
            json.int(case input.default {
              None -> 2
              Some(_) -> 1
            }),
            json.preprocessed_array(case input.value {
              OString(string) -> [json.int(10), json.string(string)]
              OInt(number) -> [json.int(4), json.string(int.to_string(number))]
              OFloat(number) -> [
                json.int(4),
                json.string(float.to_string(number)),
              ]
              OMessage(message) -> [
                json.int(11),
                json.string(message),
                json.null(),
              ]
              OComplex(_) ->
                panic as "In non-OComplex arm, but value is OComplex"
            }),
          ]),
        ))
      })
    }).1

  let input_object =
    inputs
    |> list.map(fn(input) { input.1 })
    |> json.object

  let fields =
    json.object(
      list.map(block.fields, fn(field) {
        #(
          field.name,
          json.preprocessed_array([
            json.string(field.value),
            case field.subvalue {
              Some(subvalue) -> json.string(subvalue)
              None -> json.null()
            },
          ]),
        )
      }),
    )

  io.debug(
    inputs
    |> list.map(fn(input) { input.0 })
    |> list.flatten,
  )
  #(new_subindex, [
    #(
      block_id,
      json.object([
        #("next", case isolated {
          True -> json.null()
          False -> json.string(id_prefix <> int.to_string(new_subindex + 1))
        }),
        #("opcode", json.string(block.opcode)),
        #("topLevel", json.bool(toplevel)),
        #("x", json.int(0)),
        #("y", json.int(0)),
        #("inputs", input_object),
        #("fields", fields),
      ]),
    ),
    ..{
      inputs
      |> list.map(fn(input) { input.0 })
      |> list.flatten
    }
  ])
}

type Zip

@external(javascript, "../zip.mjs", "zip")
fn zip() -> Zip

@external(javascript, "../zip.mjs", "file")
fn file(zip: Zip, file_name: String, data: String) -> Zip

@external(javascript, "../zip.mjs", "out")
fn out(zip: Zip, file_name: String) -> Zip
