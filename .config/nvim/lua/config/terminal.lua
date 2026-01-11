-- Fast terminal toggle configuration
local term_buf = nil
local term_win = nil
local term_job_id = nil

-- Cache window options for faster setup
local win_opts = {
  split = "below",
  height = 10,
}

local function create_terminal()
  -- Create split window with cached options
  vim.cmd("botright 10split")
  
  -- Create terminal without shell command for faster startup
  term_buf = vim.api.nvim_create_buf(false, true)
  term_win = vim.api.nvim_get_current_win()
  
  -- Set buffer in window
  vim.api.nvim_win_set_buf(term_win, term_buf)
  
  -- Start terminal job
  term_job_id = vim.fn.termopen(vim.o.shell, {
    on_exit = function()
      -- Auto-cleanup on terminal exit
      if term_win and vim.api.nvim_win_is_valid(term_win) then
        vim.api.nvim_win_close(term_win, true)
      end
      term_buf = nil
      term_win = nil
      term_job_id = nil
    end
  })
  
  -- Set terminal-specific options for better UX
  vim.bo[term_buf].filetype = "terminal"
  vim.wo[term_win].number = false
  vim.wo[term_win].relativenumber = false
  vim.wo[term_win].cursorline = false
  vim.wo[term_win].signcolumn = "no"
  vim.wo[term_win].foldcolumn = "0"
  vim.wo[term_win].winhl = "Normal:TerminalNormal"
  
  -- Enter insert mode
  vim.cmd("startinsert")
end

local function find_file_window()
  local windows = vim.api.nvim_list_wins()
  for _, win in ipairs(windows) do
    local buf = vim.api.nvim_win_get_buf(win)
    local buftype = vim.bo[buf].buftype
    local filetype = vim.bo[buf].filetype
    
    -- Skip special buffers (terminal, nvim-tree, etc.)
    if buftype == "" and 
       filetype ~= "NvimTree" and 
       filetype ~= "neo-tree" and
       filetype ~= "nvim-tree" and
       filetype ~= "terminal" and
       vim.api.nvim_win_is_valid(win) then
      return win
    end
  end
  return nil
end

local function toggle_terminal()
  -- Fast close if window exists
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, true)
    term_win = nil
    
    -- Find and focus a file window instead of tree
    local file_win = find_file_window()
    if file_win then
      vim.api.nvim_set_current_win(file_win)
    end
    return
  end
  
  -- Fast reopen if buffer exists and job is still running
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) and 
     term_job_id and vim.fn.jobwait({term_job_id}, 0)[1] == -1 then
    
    vim.cmd("botright 10split")
    term_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(term_win, term_buf)
    
    -- Restore window options quickly
    vim.wo[term_win].number = false
    vim.wo[term_win].relativenumber = false
    vim.wo[term_win].cursorline = false
    vim.wo[term_win].signcolumn = "no"
    
    vim.cmd("startinsert")
    return
  end
  
  -- Create new terminal if needed
  create_terminal()
end

-- Enhanced keymaps with Ctrl-x
local keymap = vim.keymap.set
local opts = { desc = "Toggle terminal", silent = true, noremap = true }

-- Normal mode: Ctrl-x
keymap("n", "<C-b>", toggle_terminal, opts)

-- Terminal mode: Ctrl-x (with proper escape)
keymap("t", "<C-b>", function()
  vim.cmd("stopinsert")
  toggle_terminal()
end, opts)

-- Insert mode: Ctrl-x
keymap("i", "<C-b>", function()
  vim.cmd("stopinsert")
  toggle_terminal()
end, opts)

-- Optional: Quick access to last terminal buffer
keymap("n", "<leader>tl", function()
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    vim.api.nvim_set_current_buf(term_buf)
    vim.cmd("startinsert")
  end
end, { desc = "Go to last terminal", silent = true })

-- Optional: Kill terminal process
keymap("n", "<leader>tk", function()
  if term_job_id then
    vim.fn.jobstop(term_job_id)
    term_buf = nil
    term_win = nil
    term_job_id = nil
    print("Terminal killed")
  end
end, { desc = "Kill terminal", silent = true })

-- Auto-cleanup on Neovim exit
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    if term_job_id then
      vim.fn.jobstop(term_job_id)
    end
  end
})
