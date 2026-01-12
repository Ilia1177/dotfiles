
local M = {}

function M.get_root(markers)
  -- Get the directory of the current file, or fall back to cwd
  local start_path = vim.fn.expand("%:p:h")
  if start_path == "" then
    start_path = vim.fn.getcwd()
  end
  
  -- Try to find a marker file
  local found = vim.fs.find(markers, { 
    upward = true,
    path = start_path,
  })[1]
  
  -- If found, get its directory
  if found then
    -- Try vim.fs.dirname first
    local dir = vim.fs.dirname(found)
    if dir and dir ~= "" then
      return dir
    end
    
    -- Fallback to fnamemodify
    dir = vim.fn.fnamemodify(found, ":h")
    if dir and dir ~= "" then
      return dir
    end
  end
  
  -- Ultimate fallback: current working directory
  return vim.fn.getcwd()
end

function M.default_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end

return M  -- ⭐ DON'T FORGET THIS!
