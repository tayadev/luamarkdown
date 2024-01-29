return {
  name = "list",
  priority = 1,
  pattern = "^%s*[%-%*%+%d%.?]+%s*.-\n\n",
  parse = function(matches)

    local source = matches[1]

    local items = {}

    local prefix = source:match("^%s*([%-%*%+%d%.?]+)%s*.-\n\n")

    for item in source:gmatch("([^\n]+)") do
      items[#items + 1] = {
        type = "list_item",
        body = item:match("^%s*[%-%*%+%d%.?]+%s*(.-)%s*$")
      }
    end

    return {
      body = items,
      list_type = prefix:match("^%d+%.") and "ordered" or "unordered"
    }
  end
}