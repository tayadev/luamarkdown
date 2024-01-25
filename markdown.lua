
---@class Markdown
---@field block_elements table
---@field inline_elements table
local Markdown = {}

function Markdown:new()
  self.__index = self
  local o = setmetatable({}, self)

  o.block_elements = {}
  o.inline_elements = {}

  return o
end

---@param element {name: string, priority: number, pattern: string, parse: function}
function Markdown:add_block_element(element)
  table.insert(self.block_elements, element)
  table.sort(self.block_elements, function(a, b)
    return a.priority > b.priority
  end)
end

---@param element {name: string, priority: number, pattern: string, parse: function}
function Markdown:add_inline_element(element)
  table.insert(self.inline_elements, element)
  table.sort(self.inline_elements, function(a, b)
    return a.priority > b.priority
  end)
end

function Markdown:parse(source)
  local document = {}

  print("Start Parse")

  while #source > 0 do
    local match = false
    for _, element in ipairs(self.block_elements) do
      if source:match(element.pattern) then
        local matches = {source:match(element.pattern)}
        local parsed = element.parse(matches)
        if parsed then
          parsed.type = element.name
          table.insert(document, parsed)
          source = source:gsub(element.pattern, "", 1)
          match = true
          break
        end
      end
    end
    -- handle if no match
    if not match then
      print("Skipping line, since no element matches: " .. source:match("^%s*(.-)%s*\n"))
      source = source:gsub("^%s*(.-)%s*\n", "", 1)
    end
  end

  -- parse inline elements
  for _, block in ipairs(document) do
    local source = block.body
    if not source then
      goto continue
    end
    local result = {}
    while #source > 0 do
      local match = false
      for _, element in ipairs(self.inline_elements) do
        if source:match(element.pattern) then
          local matches = {source:match(element.pattern)}
          local parsed = element.parse(matches)
          if parsed then
            parsed.type = element.name
            table.insert(result, parsed)
            source = source:gsub(element.pattern, "", 1)
            match = true
            break
          end
        end
      end

      if not match then
        -- consume one character

        if type(result[#result]) == "string" then
          result[#result] = result[#result] .. source:sub(1, 1)
        else
          table.insert(result, source:sub(1, 1))
        end
        source = source:sub(2)
      end
    end

    block.body = result

    ::continue::
  end

  return document

end

function Markdown.default()
  local parser = Markdown:new()

  parser:add_block_element(require "elements.block.heading") -- add === --- style heading
  parser:add_block_element(require "elements.block.blockquote")
  parser:add_block_element(require "elements.block.paragraph") -- add lazy continuation
  parser:add_block_element(require "elements.block.list") -- add 1) style ordered lists
  parser:add_block_element(require "elements.block.thematic_break")
  parser:add_block_element(require "elements.block.code_block") -- add indent style code blocks

  parser:add_inline_element(require "elements.inline.bold")
  parser:add_inline_element(require "elements.inline.italic")
  parser:add_inline_element(require "elements.inline.strikethrough")
  parser:add_inline_element(require "elements.inline.image") -- also test linked images
  parser:add_inline_element(require "elements.inline.link") -- add reference style links
  parser:add_inline_element(require "elements.inline.code")

  return parser
end

return Markdown