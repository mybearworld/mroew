import gleam/list
import gleam/option.{type Option, None, Some}

pub type Blocks =
  List(BlockType)

pub type BlockType {
  BTBlock(Block)
  BTBlocks(main_block: Block, blocks: Blocks)
}

pub type Block {
  Block(opcode: String, inputs: List(Input), fields: List(Field))
}

pub type Input {
  Input(name: String, default: Option(Operator), value: Operator)
}

pub type Field {
  Field(name: String, value: String, subvalue: Option(String))
}

pub type Operator {
  OInt(Int)
  OFloat(Float)
  OString(String)
  OMessage(String)
  OComplex(Block)
}

pub const true = OComplex(Block(opcode: "operator_not", inputs: [], fields: []))

pub const false = OComplex(Block(opcode: "operator_or", inputs: [], fields: []))

pub fn to_complex(operator: Operator) {
  case operator {
    OComplex(_) -> operator
    other ->
      OComplex(
        Block(opcode: "operator_join", fields: [], inputs: [
          Input(name: "STRING1", default: Some(OString("apple")), value: other),
          Input(name: "STRING2", default: None, value: OString("")),
        ]),
      )
  }
}

pub fn hat(block: Block) -> Blocks {
  [BTBlock(block)]
}

pub fn stack(block: Block, blocks: Blocks) -> Blocks {
  list.append(blocks, [BTBlock(block)])
}

pub fn boolean(operator: Operator) {
  OComplex(
    Block(
      opcode: "operator_equals",
      inputs: [
        Input(name: "OPERAND1", default: Some(OInt(0)), value: operator),
        Input(name: "OPERAND2", default: Some(OInt(0)), value: OString("true")),
      ],
      fields: [],
    ),
  )
}

pub fn c(blocks: Blocks) {
  fn(cblocks: Blocks) {
    let separated_blocks = case list.pop(blocks, fn(_) { True }) {
      Ok(value) -> value
      Error(_) -> panic as "c got an empty array"
    }
    list.append(cblocks, [
      BTBlocks(
        main_block: case separated_blocks.0 {
          BTBlock(value) -> value
          BTBlocks(_, _) -> panic as "main_block of a c call is BTBlocks"
        },
        blocks: separated_blocks.1,
      ),
    ])
  }
}
