import gleam/option.{None, Some}
import mroew/blocks.{
  type Blocks, type Operator, Block, Field, Input, OComplex, OInt, OString,
}

pub fn set_var(cblocks: Blocks, var: String, value: Operator) {
  Block(
    opcode: "data_setvariableto",
    inputs: [Input(name: "VALUE", default: Some(OInt(0)), value: value)],
    fields: [Field(name: "VARIABLE", value: var, subvalue: None)],
  )
  |> blocks.stack(cblocks)
}

pub fn change_var(cblocks: Blocks, var: String, value: Operator) {
  Block(
    opcode: "data_changevariableby",
    inputs: [Input(name: "VALUE", default: Some(OInt(0)), value: value)],
    fields: [Field(name: "VARIABLE", value: var, subvalue: None)],
  )
  |> blocks.stack(cblocks)
}

pub fn show_var(cblocks: Blocks, var: String) {
  Block(opcode: "data_showvariable", inputs: [], fields: [
    Field(name: "VARIABLE", value: var, subvalue: None),
  ])
  |> blocks.stack(cblocks)
}

pub fn hide_var(cblocks: Blocks, var: String) {
  Block(opcode: "data_hidevariable", inputs: [], fields: [
    Field(name: "VARIABLE", value: var, subvalue: None),
  ])
  |> blocks.stack(cblocks)
}

pub fn push_list(cblocks: Blocks, list: String, value: Operator) {
  Block(
    opcode: "data_addtolist",
    inputs: [Input(name: "ITEM", default: Some(OString("thing")), value: value)],
    fields: [Field(name: "LIST", value: list, subvalue: None)],
  )
  |> blocks.stack(cblocks)
}

pub fn pop_list(cblocks: Blocks, list: String, index: Operator) {
  Block(
    opcode: "data_deleteoflist",
    inputs: [Input(name: "INDEX", default: Some(OInt(1)), value: index)],
    fields: [Field(name: "LIST", value: list, subvalue: None)],
  )
  |> blocks.stack(cblocks)
}

pub fn clear_list(cblocks: Blocks, list: String) {
  Block(opcode: "data_deleteoflist", inputs: [], fields: [
    Field(name: "LIST", value: list, subvalue: None),
  ])
  |> blocks.stack(cblocks)
}

pub fn insert_list(
  cblocks: Blocks,
  list: String,
  index: Operator,
  item: Operator,
) {
  Block(
    opcode: "data_insertatlist",
    inputs: [
      Input(name: "INDEX", default: Some(OInt(1)), value: index),
      Input(name: "ITEM", default: Some(OString("thing")), value: item),
    ],
    fields: [Field(name: "LIST", value: list, subvalue: None)],
  )
  |> blocks.stack(cblocks)
}

pub fn replace_list(
  cblocks: Blocks,
  list: String,
  index: Operator,
  item: Operator,
) {
  Block(
    opcode: "data_replaceitemoflist",
    inputs: [
      Input(name: "INDEX", default: Some(OInt(1)), value: index),
      Input(name: "ITEM", default: Some(OString("thing")), value: item),
    ],
    fields: [Field(name: "LIST", value: list, subvalue: None)],
  )
  |> blocks.stack(cblocks)
}

pub fn index_list(list: String, index: Operator) {
  Block(
    opcode: "data_itemoflist",
    inputs: [Input(name: "INDEX", default: Some(OInt(1)), value: index)],
    fields: [Field(name: "LIST", value: list, subvalue: None)],
  )
  |> OComplex
}

pub fn index_of_item_list(list: String, item: Operator) {
  Block(
    opcode: "data_itemoflist",
    inputs: [Input(name: "ITEM", default: Some(OString("thing")), value: item)],
    fields: [Field(name: "LIST", value: list, subvalue: None)],
  )
  |> OComplex
}

pub fn len_list(list: String) {
  Block(opcode: "data_lengthoflist", inputs: [], fields: [
    Field(name: "LIST", value: list, subvalue: None),
  ])
  |> OComplex
}

pub fn contains_list(list: String, item: Operator) {
  Block(
    opcode: "data_listcontainsitem",
    inputs: [Input(name: "ITEM", default: Some(OString("thing")), value: item)],
    fields: [Field(name: "LIST", value: list, subvalue: None)],
  )
  |> OComplex
}

pub fn show_list(cblocks: Blocks, list: String) {
  Block(opcode: "data_showlist", inputs: [], fields: [
    Field(name: "LIST", value: list, subvalue: None),
  ])
  |> blocks.stack(cblocks)
}

pub fn hide_list(cblocks: Blocks, list: String) {
  Block(opcode: "data_hidelist", inputs: [], fields: [
    Field(name: "LIST", value: list, subvalue: None),
  ])
  |> blocks.stack(cblocks)
}
