local M = {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>ow", "<cmd>Neorg workspace work<cr>", desc = "open neorg work workspace" },
        { "<leader>oh", "<cmd>Neorg workspace home<cr>", desc = "open neorg home workspace" },
        { "<leader>or", "<cmd>Neorg return<cr>", desc = "close all neorg buffer" },
    },
    cmd = "Neorg",
    ft = "norg",
    priority = 30,
}

function M.config ()

    local status_ok, neorg = pcall(require, "neorg")
    if not status_ok then
        return
    end
    print("neorg setting up!")
    neorg.setup {
        load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {},
            ["core.completion"] = {
                config = {
                    engine = "nvim-cmp",
                    name = "[Neorg]",
                }
            },
            ["core.keybinds"] = {
                config = {
                    default_keybinds = false,
                    hook = function(keybinds)
                    -- Unmaps any Neorg key from the `norg` mode
                    -- keybinds.unmap("norg", "n", "gtd")

                    -- Binds the `gtd` key in `norg` mode to execute `:echo 'Hello'`
                    -- keybinds.map("norg", "n", "gtd", "<cmd>echo 'Hello!'<CR>")
                    keybinds.map("norg", "n", "<Leader>mn", "<cmd>Neorg mode norg<CR>")
                    keybinds.map("norg", "n", "<Leader>mt", "<cmd>Neorg mode traverse-heading<CR>")

                    -- Remap unbinds the current key then rebinds it to have a different action
                    -- associated with it.
                    -- The following is the equivalent of the `unmap` and `map` calls you saw above:
                    -- keybinds.remap("norg", "n", "gtd", "<cmd>echo 'Hello!'<CR>")
                    -- keybinds.remap("norg", "n", "gtd", "<cmd>echo 'Hello!'<CR>")

                    -- Sometimes you may simply want to rebind the Neorg action something is bound to
                    -- versus remapping the entire keybind. This remap is essentially the same as if you
                    -- did `keybinds.remap("norg", "n", "<C-Space>, "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_done<CR>")
                    keybinds.remap_event("norg", "n", "<Leader>td", "core.qol.todo_items.todo.task_done")
                    keybinds.remap_event("norg", "n", "<Leader>tp", "core.qol.todo_items.todo.task_pending")
                    keybinds.remap_event("norg", "n", "<Leader>tn", "core.qol.todo_items.todo.task_undone")

                    -- Want to move one keybind into the other? `remap_key` moves the data of the
                    -- first keybind to the second keybind, then unbinds the first keybind.
                    -- keybinds.remap_key("norg", "n", "<C-Space>", "<Leader>t")
                    end,
                }
            },
            ["core.dirman"] = {
                config = {
                    workspaces = {
                        work = "~/Dachau/note/work",
                        home = "~/notes/note/home",
                    }
                }
            }
        }
    }
end

return M
