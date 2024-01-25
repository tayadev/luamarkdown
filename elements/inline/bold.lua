return {
  name = "bold",
  priority = 2,
  pattern = "^[_*][_*](.-)[_*][_*]",
  parse = function(matches)
    return {
      body = matches[1]
    }
  end
}