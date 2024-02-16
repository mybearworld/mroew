import gleam/option.{None, Some}
import mroew/blocks.{
  type Blocks, type Operator, Block, Field, Input, OComplex, OInt, OString,
  boolean,
}

pub fn wait(cblocks: Blocks, seconds: Operator) {
  Block(
    opcode: "control_wait",
    inputs: [Input(name: "DURATION", default: Some(OInt(1)), value: seconds)],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn repeat(times: Operator) {
  Block(
    opcode: "control_repeat",
    inputs: [Input(name: "TIMES", default: Some(OInt(10)), value: times)],
    fields: [],
  )
  |> blocks.hat
}

pub fn forever() {
  Block(opcode: "control_forever", inputs: [], fields: [])
  |> blocks.hat
}

pub fn cond(condition: Operator) {
  Block(
    opcode: "control_if",
    inputs: [Input(name: "CONDITION", default: None, value: boolean(condition))],
    fields: [],
  )
  |> blocks.hat
}

pub fn wait_until(cblocks: Blocks, condition: Operator) {
  Block(opcode: "control_wait_until", fields: [], inputs: [
    Input(name: "CONDITION", default: None, value: boolean(condition)),
  ])
  |> blocks.stack(cblocks)
}

pub fn repeat_until(condition: Operator) {
  Block(opcode: "control_repeat_until", fields: [], inputs: [
    Input(name: "CONDITION", default: None, value: boolean(condition)),
  ])
  |> blocks.hat
}

pub fn stop(cblocks: Blocks, stop_action: StopAction) {
  Block(opcode: "control_stop", inputs: [], fields: [
    Field(
      name: "STOP_OPTION",
      value: stop_action_to_string(stop_action),
      subvalue: None,
    ),
  ])
  |> blocks.stack(cblocks)
}

pub type StopAction {
  All
  Script
  OtherScripts
}

fn stop_action_to_string(stop_action: StopAction) {
  case stop_action {
    All -> "all"
    Script -> "this script"
    OtherScripts -> "other scripts in sprite"
  }
}

pub fn clone_sprite(cblocks: Blocks, sprite: Operator) {
  Block(
    opcode: "control_create_clone_of",
    inputs: [
      Input(
        name: "CLONE_OPTION",
        default: Some(
          OComplex(
            Block(opcode: "control_create_clone_of_menu", inputs: [], fields: [
              Field(name: "CLONE_OPTION", value: "_myself_", subvalue: None),
            ]),
          ),
        ),
        value: blocks.to_complex(sprite),
      ),
    ],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn clone_myself(cblocks: Blocks) {
  clone_sprite(cblocks, OString("_myself_"))
}

pub fn delete_clone(cblocks: Blocks) {
  Block(opcode: "control_delete_this_clone", inputs: [], fields: [])
  |> blocks.stack(cblocks)
}

pub fn on_clone() {
  Block(opcode: "control_start_as_clone", inputs: [], fields: [])
  |> blocks.hat
}
