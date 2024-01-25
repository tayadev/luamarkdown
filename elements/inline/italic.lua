return {
  name = "italic",
  priority = 1,
  pattern = "^[_*](.-)[_*]",
  parse = function(matches)
    return {
      body = matches[1]
    }
  end
}