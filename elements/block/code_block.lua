return {
  name = "code_block",
  priority = 1,
  pattern = "^%s*```(.-)\n%s*(.-)%s*```%s*\n",
  parse = function(matches)
    return {
      language = matches[1],
      body = matches[2]
    }
  end
}     