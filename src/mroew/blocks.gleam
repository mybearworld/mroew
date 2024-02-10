import gleam/list
import gleam/option.{type Option, Some}

pub type Blocks =
  List(Block)

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

pub fn hat(opcode: String) -> Blocks {
  [Block(opcode: opcode, inputs: [], fields: [])]
}

pub fn stack(blocks: Blocks, block: Block) -> Blocks {
  list.append(blocks, [block])
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
