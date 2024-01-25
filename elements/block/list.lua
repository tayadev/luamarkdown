return {
  name = "list",
  priority = 1,
  pattern = "(([%-%*%d%c]+)%s+(.-)*(\n|$))+",
  parse = function(matches)

    print("list")

    for i, match in ipairs(matches) do
      print(i, match)
    end

    return {}
  end
}