local M = {
  "numToStr/Navigator.nvim",
  event = "VeryLazy",
}

function M.config()
  require("Navigator").setup()
end

return M
