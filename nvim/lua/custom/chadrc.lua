---@type ChadrcConfig
local M = {}

M.ui = { 
  theme = 'tokyonight',
  transparency = true
}

M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"

M.copilot = {
  -- Possible configurable fields can be found on:
  -- https://github.com/zbirenbaum/copilot.lua#setup-and-configuration
  suggestion = {
    enable = false,
  },
  panel = {
    enable = false,
  },
}

return M
