return {
  name = "image",
  priority = 2,
  pattern = "^!%[(.-)%]%((.-)%)",
  parse = function(matches)
    return {
      alt = matches[1],
      src = matches[2]
    }
  end
}