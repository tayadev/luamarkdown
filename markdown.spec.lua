local test = require "luatest"

local md = require "markdown".default()

test("headings", function(t)

  local doc = md:parse([[
    # Heading 1
    ## Heading 2
    ### Heading 3
    #### Heading 4
    ##### Heading 5
    ###### Heading 6
  ]])

  t:is(doc, {
    {
      type = "heading",
      level = 1,
      text = "Heading 1"
    },
    {
      type = "heading",
      level = 2,
      text = "Heading 2"
    },
    {
      type = "heading",
      level = 3,
      text = "Heading 3"
    },
    {
      type = "heading",
      level = 4,
      text = "Heading 4"
    },
    {
      type = "heading",
      level = 5,
      text = "Heading 5"
    },
    {
      type = "heading",
      level = 6,
      text = "Heading 6"
    }
  })
end)

test("Invalid headings", function(t)
  local doc = md:parse([[
    #Heading
    ####### Heading
  ]])

  t:is(doc, {
    {
      type = "paragraph",
      text = "#Heading"
    },
    {
      type = "paragraph",
      text = "####### Heading"
    }
  })
end)

test("Alternative headings", function(t)
  local doc = md:parse([[
    Heading 1
    =========
    Heading 2
    ---------
  ]])

  t:is(doc, {
    {
      type = "heading",
      level = 1,
      text = "Heading 1"
    },
    {
      type = "heading",
      level = 2,
      text = "Heading 2"
    }
  })
end)

test.run()