
local M = {}
-- Your custom mappings
M.abc = {
  i = {
     ["jk"] = { "<ESC>", "escape insert mode" , opts = { nowait = true }},
    -- ...
  }
}

return M
