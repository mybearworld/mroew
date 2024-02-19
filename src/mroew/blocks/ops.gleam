import gleam/option.{type Option, None, Some}
import mroew/blocks.{
  type Operator, Block, Field, Input, OComplex, OFloat, OInt, OString, boolean,
}

pub fn add(operator: Operator, operator2: Operator) {
  binary(
    operator,
    operator2,
    "operator_add",
    #(#("NUM1", Some(OInt(2))), #("NUM2", Some(OInt(2)))),
  )
}

pub fn sub(operator: Operator, operator2: Operator) {
  binary(
    operator,
    operator2,
    "operator_subtract",
    #(#("NUM1", Some(OInt(2))), #("NUM2", Some(OInt(2)))),
  )
}

pub fn mul(operator: Operator, operator2: Operator) {
  binary(
    operator,
    operator2,
    "operator_multiply",
    #(#("NUM1", Some(OInt(2))), #("NUM2", Some(OInt(2)))),
  )
}

pub fn div(operator: Operator, operator2: Operator) {
  binary(
    operator,
    operator2,
    "operator_divide",
    #(#("NUM1", Some(OInt(2))), #("NUM2", Some(OInt(2)))),
  )
}

pub fn random(operator: Operator, operator2: Operator) {
  binary(
    operator,
    operator2,
    "operator_random",
    #(#("FROM", Some(OInt(2))), #("TO", Some(OInt(5)))),
  )
}

pub fn gt(operator: Operator, operator2: Operator) {
  binary(
    operator,
    operator2,
    "operator_gt",
    #(#("OPERAND1", Some(OInt(2))), #("OPERAND2", Some(OInt(5)))),
  )
}

pub fn lt(operator: Operator, operator2: Operator) {
  binary(
    operator,
    operator2,
    "operator_lt",
    #(#("OPERAND1", Some(OInt(2))), #("OPERAND2", Some(OInt(5)))),
  )
}

pub fn eq(operator: Operator, operator2: Operator) {
  binary(
    operator,
    operator2,
    "operator_equals",
    #(#("OPERAND1", Some(OInt(2))), #("OPERAND2", Some(OInt(5)))),
  )
}

pub fn and(operator: Operator, operator2: Operator) {
  binary(
    boolean(operator),
    boolean(operator2),
    "operator_and",
    #(#("OPERAND1", None), #("OPERAND2", None)),
  )
}

pub fn or(operator: Operator, operator2: Operator) {
  binary(
    boolean(operator),
    boolean(operator2),
    "operator_or",
    #(#("OPERAND1", None), #("OPERAND2", None)),
  )
}

pub fn not(operator: Operator) {
  Block(
    opcode: "operator_not",
    inputs: [Input(name: "OPERAND", default: None, value: operator)],
    fields: [],
  )
  |> OComplex
}

pub fn join(operator: Operator, operator2: Operator) {
  binary(
    operator,
    operator2,
    "operator_join",
    #(#("STRING1", None), #("STRING2", None)),
  )
}

pub fn letter_of(string: Operator, index: Operator) {
  binary(
    index,
    string,
    "operator_letter_of",
    #(#("LETTER", None), #("STRING", None)),
  )
}

pub fn len(operator: Operator) {
  Block(
    opcode: "operator_length",
    inputs: [
      Input(name: "STRING", default: Some(OString("apple")), value: operator),
    ],
    fields: [],
  )
  |> OComplex
}

pub fn contains(haystack: Operator, needle: Operator) {
  binary(
    haystack,
    needle,
    "operator_contains",
    #(#("STRING1", None), #("STRING2", None)),
  )
}

pub fn mod(operator: Operator, operator2: Operator) {
  binary(
    operator,
    operator2,
    "operator_contains",
    #(#("NUM1", None), #("NUM2", None)),
  )
}

pub fn round(operator: Operator) {
  Block(
    opcode: "operator_round",
    inputs: [Input(name: "NUM", default: Some(OFloat(7.6)), value: operator)],
    fields: [],
  )
  |> OComplex
}

pub fn operation(operator: Operator, operation: Operation) {
  Block(
    opcode: "operator_mathop",
    inputs: [Input(name: "NUM", default: Some(OInt(1)), value: operator)],
    fields: [
      Field(
        name: "OPERATOR",
        value: operation_to_string(operation),
        subvalue: None,
      ),
    ],
  )
  |> OComplex
}

pub type Operation {
  Abs
  Floor
  Ceil
  Sqrt
  Sin
  Cos
  Tan
  Asin
  Acos
  Atan
  Ln
  Log
  ETo
  TenTo
}

fn operation_to_string(operation: Operation) {
  case operation {
    Abs -> "abs"
    Floor -> "floor"
    Ceil -> "ceiling"
    Sqrt -> "sqrt"
    Sin -> "sin"
    Cos -> "cos"
    Tan -> "tan"
    Asin -> "asin"
    Acos -> "acos"
    Atan -> "atan"
    Ln -> "ln"
    Log -> "log"
    ETo -> "e ^"
    TenTo -> "10 ^"
  }
}

fn binary(
  operator: Operator,
  operator2: Operator,
  opcode: String,
  templates: #(#(String, Option(Operator)), #(String, Option(Operator))),
) {
  Block(
    opcode: opcode,
    inputs: [
      Input(
        name: { templates.0 }.0,
        default: { templates.0 }.1,
        value: operator,
      ),
      Input(
        name: { templates.1 }.0,
        default: { templates.1 }.1,
        value: operator2,
      ),
    ],
    fields: [],
  )
  |> OComplex
}

pub fn int(int: Int) {
  OInt(int)
}

pub fn float(float: Float) {
  OFloat(float)
}

pub fn string(string: String) {
  OString(string)
}

pub fn bool(bool: Bool) {
  case bool {
    True -> OComplex(Block(opcode: "operator_not", inputs: [], fields: []))
    False -> OComplex(Block(opcode: "operator_or", inputs: [], fields: []))
  }
}
