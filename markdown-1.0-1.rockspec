package = "markdown"
version = "1.0-1"
source = {
   url = "git://github.com/tayadev/luamarkdown",
   tag = "v1.0"
}
description = {
   summary = "Pure Lua markdown parser",
   detailed = "Pure Lua markdown parser",
   homepage = "https://github.com/tayadev/luamarkdown",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1, < 5.5"
}
build = {
   type = "builtin",
   modules = {
      markdown = "markdown.lua",
      ["elements.block.blockquote"] = "elements/block/blockquote.lua",
      ["elements.block.code_block"] = "elements/block/code_block.lua",
      ["elements.block.heading"] = "elements/block/heading.lua",
      ["elements.block.thematic_break"] = "elements/block/thematic_break.lua",
      ["elements.block.list"] = "elements/block/list.lua",
      ["elements.block.paragraph"] = "elements/block/paragraph.lua",
      ["elements.inline.code"] = "elements/inline/code.lua",
      ["elements.inline.image"] = "elements/inline/image.lua",
      ["elements.inline.link"] = "elements/inline/link.lua",
      ["elements.inline.bold"] = "elements/inline/bold.lua",
      ["elements.inline.italic"] = "elements/inline/italic.lua",
      ["elements.inline.strikethrough"] = "elements/inline/strikethrough.lua",
   }
}