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

  -- add newlines to the end of the file, to fix a weird bug
  source = source .. "\n"

  while #source > 0 do
    local match = false
    for _, element in ipairs(self.block_elements) do
      if source:match(element.pattern) then
        local matches = { source:match(element.pattern) }
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
      local line = source:match("^[^\n]*\n")
      if line then
        source = source:gsub('^[^\n]*\n', '')
      else
        -- if no line, then we are at the end of the file
        source = ""
      end
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
          local matches = { source:match(element.pattern) }
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

    if #result == 1 and type(result[1]) == "string" then
      result = result[1]
    end
    block.body = result

    ::continue::
  end

  return document
end

local thisFolder = (...):match("(.-)[^%.]+$")

function Markdown.default()
  local parser = Markdown:new()

  parser:add_block_element(require(thisFolder .. "elements.block.heading"))    -- add === --- style heading
  parser:add_block_element(require(thisFolder .. "elements.block.blockquote"))
  parser:add_block_element(require(thisFolder .. "elements.block.paragraph"))  -- add lazy continuation
  parser:add_block_element(require(thisFolder .. "elements.block.list"))       -- add 1) style ordered lists, DOESNT WORK CURRENTLY
  parser:add_block_element(require(thisFolder .. "elements.block.thematic_break"))
  parser:add_block_element(require(thisFolder .. "elements.block.code_block")) -- add indent style code blocks

  parser:add_inline_element(require(thisFolder .. "elements.inline.bold"))
  parser:add_inline_element(require(thisFolder .. "elements.inline.italic"))
  parser:add_inline_element(require(thisFolder .. "elements.inline.strikethrough"))
  parser:add_inline_element(require(thisFolder .. "elements.inline.image")) -- also test linked images
  parser:add_inline_element(require(thisFolder .. "elements.inline.link"))  -- add reference style links
  parser:add_inline_element(require(thisFolder .. "elements.inline.code"))

  return parser
end

return Markdown
