local md = require "markdown".default()
local html = require "renderer.html_renderer"

-- custom extension
md:add_block_element{
  name = "livecode",
  priority = 2,
  pattern = "^%s*```(%w-)%[live%]%s*(.-)%s*```%s*",
  parse = function(matches)
    return {
      lang = matches[1],
      body = matches[2],
    }
  end
}

local doc = md:parse([[
# Heading 1
## Heading 2

Heyo

---

> Blockquote

```lua
print("Hello World")
```

- List item 1
- List item 2
- List item 3

Text with **Bold** words in it
# **Bold Heading**
Alternative way for __bold__

Two ways for *italic* _italic_ text

~~Strikethrough~~

[link text](https://example.com)
![alt text](https://example.com/image.png)

Inline `code`

```lua[live]
print("Hello World")
```

]])

-- print(html(doc))

-- local terminal = require "terminal_renderer"

-- terminal(doc)