local md = require "markdown".default()
local pprint = require "pprint"
local html = require "html_renderer"

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

]])

pprint(doc)

print(html(doc))