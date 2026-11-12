-- Terminal rapide : split en bas, toggle avec Ctrl-b
local term_buf ---@type integer|nil
local term_win ---@type integer|nil
local term_job_id ---@type integer|nil

---@param id integer|nil
---@return boolean
local function job_running(id)
  if not id then
    return false
  end
  local ok, res = pcall(vim.fn.jobwait, { id }, 0)
  return ok and res[1] == -1
end

---@param win integer
local function apply_window_opts(win)
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].cursorline = false
  vim.wo[win].signcolumn = "no"
  vim.wo[win].foldcolumn = "0"
  vim.wo[win].winhl = "Normal:TerminalNormal"
end

local function create_terminal()
  vim.cmd("botright 10split")

  term_buf = vim.api.nvim_create_buf(false, true)
  term_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(term_win, term_buf)

  term_job_id = vim.fn.termopen(vim.o.shell, {
    on_exit = function()
      if term_win and vim.api.nvim_win_is_valid(term_win) then
        vim.api.nvim_win_close(term_win, true)
      end
      term_buf = nil
      term_win = nil
      term_job_id = nil
    end,
  })

  vim.bo[term_buf].filetype = "terminal"
  apply_window_opts(term_win)
  vim.cmd("startinsert")
end

---@return integer|nil
local function find_file_window()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local filetype = vim.bo[buf].filetype
    if
      vim.bo[buf].buftype == ""
      and filetype ~= "terminal"
      and filetype ~= "NvimTree"
      and vim.api.nvim_win_is_valid(win)
    then
      return win
    end
  end
  return nil
end

local function toggle_terminal()
  -- fermer
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, true)
    term_win = nil
    local file_win = find_file_window()
    if file_win then
      vim.api.nvim_set_current_win(file_win)
    end
    return
  end

  -- rouvrir le buffer existant si le shell tourne encore
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) and job_running(term_job_id) then
    vim.cmd("botright 10split")
    term_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(term_win, term_buf)
    apply_window_opts(term_win)
    vim.cmd("startinsert")
    return
  end

  create_terminal()
end

local keymap = vim.keymap.set
local opts = { desc = "Afficher/masquer le terminal", silent = true }

keymap("n", "<C-b>", toggle_terminal, opts)
keymap("t", "<C-b>", function()
  vim.cmd("stopinsert")
  toggle_terminal()
end, opts)
keymap("i", "<C-b>", function()
  vim.cmd("stopinsert")
  toggle_terminal()
end, opts)

keymap("n", "<leader>tl", function()
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    vim.api.nvim_set_current_buf(term_buf)
    vim.cmd("startinsert")
  end
end, { desc = "Retourner au dernier terminal", silent = true })

keymap("n", "<leader>tk", function()
  if term_job_id then
    vim.fn.jobstop(term_job_id)
    term_buf = nil
    term_win = nil
    term_job_id = nil
    vim.notify("Terminal arrêté", vim.log.levels.INFO)
  end
end, { desc = "Arrêter le terminal", silent = true })

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    if term_job_id then
      vim.fn.jobstop(term_job_id)
    end
  end,
})
