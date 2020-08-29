[
  .[] | (.position.value) as $id |
  [.position.label]+(.alias|split("\n")) |.[] |
  { value:$id, key:(.|ascii_downcase) }
] | from_entries

