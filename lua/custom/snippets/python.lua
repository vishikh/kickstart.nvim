local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

ls.add_snippets('python', {
  -- pr -> print(...)
  s('pr', fmt('print({})', { i(1) })),

  -- prf -> print(f"...")
  s('prf', fmt('print(f"{}")', { i(1) })),
})
