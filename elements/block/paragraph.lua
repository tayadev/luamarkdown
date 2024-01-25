return {
  name = "paragraph",
  priority = -1,
  pattern = "^%s*(.-)%s*\n",
  parse = function(matches)
    return {
      body = matches[1]
    }
  end
}