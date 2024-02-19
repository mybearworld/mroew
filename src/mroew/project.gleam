import gleam/int
import gleam/float
import gleam/list
import gleam/option.{None, Some}
import gleam/json.{type Json}
import mroew/blocks.{
  type Block, type Blocks, type Operator, BTBlock, BTBlocks, OComplex, OFloat,
  OInt, OList, OMessage, OString, OVar,
}
import mroew/sprite.{type Sprite, Png, Svg}

pub type Project {
  Project(stage: Sprite, sprites: List(Sprite))
}

pub fn project(stage: Sprite) -> Project {
  Project(stage, [])
}

pub fn add_sprite(project: Project, sprite: Sprite) {
  Project(..project, sprites: list.append(project.sprites, [sprite]))
}

pub fn export(project: Project, name: String) {
  let json = project_json(project)

  let archive =
    zip()
    |> file("project.json", json)

  list.map(list.append(project.sprites, [project.stage]), fn(sprite) {
    list.map(sprite.costumes, fn(costume) {
      archive
      |> from_bitarray(
        costume.md5 <> "." <> sprite.image_type_to_string(costume.file_type),
        costume.content,
      )
    })
    list.map(sprite.sounds, fn(sound) {
      archive
      |> from_bitarray(sound.md5 <> "." <> sound.file_type, sound.content)
    })
  })

  archive
  |> out(name)
}

fn project_json(project: Project) {
  json.object([
    #(
      "targets",
      json.preprocessed_array([
        to_target(project.stage, True, 0),
        ..list.map_fold(project.sprites, 1, fn(index, sprite) {
          #(index + 1, to_target(sprite, False, index))
        }).1
      ]),
    ),
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
  |> json.to_string()
}

fn to_target(sprite: Sprite, is_stage: Bool, layer_order: Int) {
  json.object([
    #(
      "blocks",
      json.object(
        {
          sprite.blocks
          |> list.map_fold(0, fn(script_index, script) {
            #(
              script_index
              + 1,
              blocks_to_json(script, int.to_string(script_index) <> "s", True),
            )
          })
        }.1
        |> list.flatten,
      ),
    ),
    #(
      "costumes",
      json.preprocessed_array(
        list.map(sprite.costumes, fn(costume) {
          let file_type_string = sprite.image_type_to_string(costume.file_type)
          json.object([
            #("name", json.string(costume.name)),
            #(
              "bitmapResolution",
              json.int(case costume.file_type {
                Png -> 2
                Svg -> 1
              }),
            ),
            #("dataFormat", json.string(file_type_string)),
            #("assetId", json.string(costume.md5)),
            #("md5ext", json.string(costume.md5 <> "." <> file_type_string)),
            #("rotationCenterX", json.int(costume.width / 2)),
            #("rotationCenterY", json.int(costume.height / 2)),
          ])
        }),
      ),
    ),
    #(
      "sounds",
      json.preprocessed_array(
        list.map(sprite.sounds, fn(sound) {
          json.object([
            #("name", json.string(sound.name)),
            #("assetId", json.string(sound.md5)),
            #("dataFormat", json.string(sound.file_type)),
            #("format", json.string("")),
            #("rate", json.int(0)),
            #("sampleCount", json.int(0)),
            #("md5ext", json.string(sound.md5 <> "." <> sound.file_type)),
          ])
        }),
      ),
    ),
    #(
      "variables",
      json.object(
        list.map(sprite.variables, fn(variable) {
          #(
            "var:"
            <> variable,
            json.preprocessed_array([json.string(variable), json.string("")]),
          )
        }),
      ),
    ),
    #("isStage", json.bool(is_stage)),
    #(
      "name",
      json.string(case is_stage {
        True -> "Stage"
        False -> sprite.name
      }),
    ),
    #("volume", json.int(100)),
    #("layerOrder", json.int(layer_order)),
    #("visible", json.bool(True)),
    #("x", json.int(0)),
    #("y", json.int(0)),
    #("size", json.int(100)),
    #("direction", json.int(90)),
    #("draggable", json.bool(False)),
    #("rotationStyle", json.string("all around")),
  ])
}

fn blocks_to_json(blocks: Blocks, script_prefix: String, top_level: Bool) {
  list.map_fold(blocks, 0, fn(index, block) {
    #(index + 1, case block {
      BTBlocks(main_block, subblocks) ->
        [
          block_to_json(
            block: main_block,
            state: case index == list.length(blocks) - 1 {
              True -> LastSubstackSubstack
              False -> Substack
            },
            id_prefix: script_prefix,
            new_subindex: index,
          ),
          ..[
            blocks_to_json(
              subblocks,
              script_prefix <> int.to_string(index) <> "u",
              False,
            ),
          ]
        ]
        |> list.flatten
      BTBlock(block) ->
        block_to_json(
          block: block,
          state: case top_level {
            True ->
              case index == 0 {
                True -> TopLevel
                False -> Block
              }
            False ->
              case index == list.length(blocks) - 1 {
                True -> LastSubstackBlock
                False -> Block
              }
          },
          id_prefix: script_prefix,
          new_subindex: index,
        )
    })
  }).1
  |> list.flatten
}

fn block_to_json(
  block block: Block,
  id_prefix id_prefix: String,
  new_subindex new_subindex: Int,
  state state: BlockState,
) -> List(#(String, Json)) {
  let block_id = id_prefix <> int.to_string(new_subindex)

  let inputs =
    list.map_fold(block.inputs, 0, fn(input_index, input) {
      let default_blocks = case input.default {
        Some(OComplex(block)) ->
          block_to_json(
            block: block,
            state: Menu,
            id_prefix: block_id <> "d",
            new_subindex: input_index,
          )
        _ -> []
      }
      let default_value = case input.default {
        Some(OComplex(_)) ->
          Some(json.string(block_id <> "d" <> int.to_string(input_index)))
        Some(default) -> Some(repr_of_noncomplex_o(default))
        None -> None
      }
      let is_var_list = case input.value {
        OVar(_) -> True
        OList(_) -> True
        _ -> False
      }
      #(input_index + 1, case input.value {
        OComplex(complex_block) -> #(
          block_to_json(
            block: complex_block,
            state: Operator(block_id),
            id_prefix: block_id <> "o",
            new_subindex: input_index,
          )
          |> list.append(default_blocks),
          #(
            input.name,
            json.preprocessed_array(case default_value {
              Some(default) -> [
                json.int(3),
                json.string(block_id <> "o" <> int.to_string(input_index)),
                default,
              ]
              None -> [
                json.int(2),
                json.string(block_id <> "o" <> int.to_string(input_index)),
              ]
            }),
          ),
        )
        _ ->
          case is_var_list {
            True -> #(default_blocks, #(
              input.name,
              json.preprocessed_array(case default_value {
                Some(default) -> [
                  json.int(3),
                  repr_of_noncomplex_o(input.value),
                  default,
                ]
                None -> [json.int(2), repr_of_noncomplex_o(input.value)]
              }),
            ))
            False -> #([], #(
              input.name,
              json.preprocessed_array([
                json.int(1),
                repr_of_noncomplex_o(input.value),
              ]),
            ))
          }
      })
    }).1

  let input_array =
    inputs
    |> list.map(fn(input) { input.1 })

  let input_object = json.object(input_array)

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

  let substack_object =
    json.object([
      #(
        "SUBSTACK",
        json.preprocessed_array([json.int(2), json.string(block_id <> "u0")]),
      ),
      ..input_array
    ])

  [
    #(
      block_id,
      json.object(
        [
          #("parent", case state {
            Operator(parent) -> json.string(parent)
            _ -> json.null()
          }),
          #("next", case state {
            Operator(_) -> json.null()
            LastSubstackBlock -> json.null()
            LastSubstackSubstack -> json.null()
            _ -> json.string(id_prefix <> int.to_string(new_subindex + 1))
          }),
          #("opcode", json.string(block.opcode)),
          #("topLevel", json.bool(state == TopLevel || state == Menu)),
          #("x", json.int(0)),
          #("y", json.int(0)),
          #("inputs", case state {
            Substack -> substack_object
            LastSubstackSubstack -> substack_object
            _ -> input_object
          }),
          #("fields", fields),
        ]
        |> list.append(case state {
          Menu -> [#("shadow", json.bool(True))]
          _ -> []
        }),
      ),
    ),
    ..{
      inputs
      |> list.map(fn(input) { input.0 })
      |> list.flatten
    }
  ]
}

type BlockState {
  TopLevel
  Block
  Menu
  Substack
  Operator(parent: String)
  LastSubstackBlock
  LastSubstackSubstack
}

fn repr_of_noncomplex_o(operator: Operator) {
  json.preprocessed_array(case operator {
    OString(string) -> [json.int(10), json.string(string)]
    OInt(number) -> [json.int(4), json.string(int.to_string(number))]
    OFloat(number) -> [json.int(4), json.string(float.to_string(number))]
    OMessage(message) -> [
      json.int(11),
      json.string(message),
      json.string("msg:" <> message),
    ]
    OVar(name) -> [json.int(12), json.string(name), json.string("var:" <> name)]
    OList(name) -> [
      json.int(13),
      json.string(name),
      json.string("list:" <> name),
    ]
    OComplex(_) -> panic as "In repr_of_noncomplex_o, operator is OComplex."
  })
}

type Zip

@external(javascript, "../ffi.mjs", "zip")
fn zip() -> Zip

@external(javascript, "../ffi.mjs", "file")
fn file(zip: Zip, file_name: String, data: String) -> Zip

@external(javascript, "../ffi.mjs", "fromFile")
fn from_bitarray(zip: Zip, file_name: String, data: BitArray) -> Zip

@external(javascript, "../ffi.mjs", "out")
fn out(zip: Zip, file_name: String) -> Nil
