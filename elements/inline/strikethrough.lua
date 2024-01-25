return {
  name = "strikethrough",
  priority = 1,
  pattern = "^~~(.-)~~",
  parse = function(matches)
    return {
      body = matches[1]
    }
  end
}