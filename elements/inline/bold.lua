return {
  name = "bold",
  priority = 1,
  pattern = "^[_*][_*](.-)[_*][_*]",
  parse = function(matches)
    return {
      body = matches[1]
    }
  end
}