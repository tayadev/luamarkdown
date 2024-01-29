# Lua Markdown Parser

Parses markdown into a table, that then can be rendered into HTML or other formats.

Goal is to implement the CommonMark spec, but currently only a subset of it is implemented.

# TODO:
- maybe clean up structure, and add formal types
  because what we have rn is cool, but is starting to get messy
  and certain things seem hard to implement with current structure

# Return Format

document: Block[]

Block
 - type: string
 - body?: string|InlineBlock|InlineBlock[]
 - level?: number
 - language?: string
 - list_type?: string

InlineBlock
 - type: string
 - body?: string|InlineBlock|InlineBlock[]
 - href?: string
 - alt?: string
 - src?: string