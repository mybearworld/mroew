import gleam/option.{None, Some}
import mroew/blocks.{
  type Blocks, type Operator, Block, Field, Input, OComplex, OInt,
}

pub fn move(cblocks: Blocks, steps: Operator) {
  Block(
    opcode: "motion_movesteps",
    inputs: [Input(name: "STEPS", default: Some(OInt(10)), value: steps)],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn turn(cblocks: Blocks, degrees: Operator) {
  Block(
    opcode: "motion_turnright",
    inputs: [Input(name: "DEGREES", default: Some(OInt(15)), value: degrees)],
    fields: [],
  )
  |> blocks.stack(cblocks)
}

pub fn go(cblocks: Blocks, sprite: Operator) {
  Block(
    opcode: "motion_goto",
    inputs: [
      Input(
        name: "TO",
        default: Some(
          OComplex(
            Block(opcode: "motion_goto_menu", inputs: [], fields: [
              Field(name: "TO", value: "_random_", subvalue: None),
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
