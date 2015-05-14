#lang ragg

json: number | string

    | array  | object

number: NUMBER

string: STRING

array: "[" [json ("," json)*] "]"

object: "{" [kvpair ("," kvpair)*] "}"

kvpair: STRING ":" json