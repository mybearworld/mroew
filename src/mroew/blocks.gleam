import gleam/list
import gleam/option.{type Option, Some}

pub type Blocks {
  Blocks(blocks: List(BlockType), substack_name: Option(String))
}

pub type BlockType {
  BTBlock(Block)
  BTBlocks(Blocks)
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
  OBool(Bool)
  OComplex(Block)
}

pub fn hat(block: Block, substack_name: Option(String)) -> Blocks {
  Blocks([BTBlock(block)], substack_name)
}

pub fn stack(block: Block, blocks: Blocks) -> Blocks {
  Blocks(..blocks, blocks: list.append(blocks.blocks, [BTBlock(block)]))
}

pub fn boolean(operator: Operator) {
  let equals =
    OComplex(
      Block(
        opcode: "operator_equals",
        inputs: [
          Input(name: "OPERAND1", default: Some(OInt(0)), value: operator),
          Input(
            name: "OPERAND2",
            default: Some(OInt(0)),
            value: OString("true"),
          ),
        ],
        fields: [],
      ),
    )
  case operator {
    OBool(_) -> operator
    _ -> equals
  }
}

pub fn c(blocks: Blocks) {
  fn(cblocks: Blocks) {
    Blocks(..cblocks, blocks: list.append(cblocks.blocks, [BTBlocks(blocks)]))
  }
}
