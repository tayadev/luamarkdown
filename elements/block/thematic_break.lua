return {
  name = "thematic_break",
  priority = 2,
  pattern = "^%s*[-*][-*][-*]+%s*\n",
  parse = function()
    return {}
  end
}