local M = {
  "notjedi/nvim-rooter.lua",
  event = "VeryLazy",
}

function M.config()
  local status_ok, rooter = pcall(require, "nvim-rooter")
  if not status_ok then
    return
  end

  rooter.setup {
    rooter_patterns = { ".git", ".hg", ".svn", "compile_commands.json" },
    trigger_patterns = { "*" },
    manual = false,
    fallback_to_parent = false,
  }
end

return M
