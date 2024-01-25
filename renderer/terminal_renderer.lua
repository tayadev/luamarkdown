local RESET = "\x1b[0m"
local BOLD = "\x1b[1m"
local BOLD_END = "\x1b[22m"
local FAINT = "\x1b[2m"
local FAINT_END = "\x1b[22m"
local ITALIC = "\x1b[3m"
local ITALIC_END = "\x1b[23m"
local STRIKETHROUGH = "\x1b[9m"
local STRIKETHROUGH_END = "\x1b[29m"
local UNDERLINE = "\x1b[4m"
local UNDERLINE_END = "\x1b[24m"

local FG_BLACK = "\x1b[30m"
local FG_RED = "\x1b[31m"
local FG_GREEN = "\x1b[32m"
local FG_YELLOW = "\x1b[33m"
local FG_BLUE = "\x1b[34m"
local FG_MAGENTA = "\x1b[35m"
local FG_CYAN = "\x1b[36m"
local FG_WHITE = "\x1b[37m"
local FG_BLACK_BRIGHT = "\x1b[90m"
local FG_RED_BRIGHT = "\x1b[91m"
local FG_GREEN_BRIGHT = "\x1b[92m"
local FG_YELLOW_BRIGHT = "\x1b[93m"
local FG_BLUE_BRIGHT = "\x1b[94m"
local FG_MAGENTA_BRIGHT = "\x1b[95m"
local FG_CYAN_BRIGHT = "\x1b[96m"
local FG_WHITE_BRIGHT = "\x1b[97m"
local FG_DEFAULT = "\x1b[39m"

function parseInline(blockBody)
  if type(blockBody) == "string" then
    return blockBody
  end

  local result = ""

  for _, element in ipairs(blockBody) do
    if type(element) == "string" then
      result = result .. element
    elseif element.type == "bold" then
      result = result .. BOLD .. element.body .. BOLD_END
    elseif element.type == "italic" then
      result = result .. ITALIC .. element.body .. ITALIC_END
    elseif element.type == "link" then
      result = result .. UNDERLINE .. FG_BLUE .. element.body .. FG_DEFAULT .. UNDERLINE_END
    elseif element.type == "code" then
      result = result .. FG_GREEN .. element.body .. FG_DEFAULT
    elseif element.type == "strikethrough" then
      result = result .. STRIKETHROUGH .. element.body .. STRIKETHROUGH_END
    elseif element.type == "image" then
      result = result .. FG_MAGENTA .. '[' .. element.alt .. ']' .. FG_DEFAULT
    end
  end

  return result
end

return function(document)

  for _, block in ipairs(document) do
    if block.type == "paragraph" then
      print(parseInline(block.body))
    elseif block.type == "heading" then
      print(FG_CYAN .. parseInline(block.body) .. FG_DEFAULT)
    elseif block.type == "blockquote" then
      print(FG_YELLOW .. '> ' .. parseInline(block.body) .. FG_DEFAULT)
    elseif block.type == "code_block" then
      print(FG_GREEN .. block.body .. FG_DEFAULT)
    elseif block.type == "thematic_break" then
      print(FG_MAGENTA .. '---' .. FG_DEFAULT)
    elseif block.type == "list" then
      for _, item in ipairs(block.items) do
        print(FG_BLUE .. '- ' .. parseInline(item) .. FG_DEFAULT)
      end
    end
  end

end