return {
  name = "thematic_break",
  priority = 1,
  pattern = "^%s*[-*][-*][-*]+%s*\n",
  parse = function()
    return {}
  end
}