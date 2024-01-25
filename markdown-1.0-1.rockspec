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
      markdown = "markdown.lua"
   }
}