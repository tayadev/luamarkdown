return {
  name = "heading",
  priority = 1,
  pattern = "^%s*(#+)%s*(.-)%s*\n",
  parse = function(matches)
    return {
      level = #matches[1],
      body = matches[2]
    }
  end
}