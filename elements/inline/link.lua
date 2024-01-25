return {
  name = "link",
  priority = 1,
  pattern = "^%[(.-)%]%((.-)%)",
  parse = function(matches)
    return {
      body = matches[1],
      href = matches[2]
    }
  end
}