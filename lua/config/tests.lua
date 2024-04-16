vim.cmd [[
function! InvokeViaTmuxWithFile(cmd, test)
  let l:targetWindow = trim(system('tmux list-windows | grep "test" | cut -f1 -d":" | head -1'))
  if empty(l:targetWindow)
    let l:targetWindow = 3
  endif
  let l:target = "-t " . l:targetWindow . ".1"
  let l:command = "tmux send-keys" . " " . l:target . ' "' . a:cmd . " "  . a:test . '" Enter'
  echom "Running " . a:test . " in window " . l:targetWindow
  let output = system(l:command)
endfunction

function! InvokeViaTmux(cmd)
  let l:targetWindow = trim(system('tmux list-windows | grep "test" | cut -f1 -d":" | head -1'))
  if empty(l:targetWindow)
    let l:targetWindow = 3
  endif
  let l:target = "-t " . l:targetWindow . ".1"
  let l:command = "tmux send-keys" . " " . l:target . ' "' . a:cmd . " "  . '" Enter'
  echom "Running " . a:cmd . " in window " . l:targetWindow
  let output = system(l:command)
endfunction
]]


vim.keymap.set('n', '<leader>t', ':call InvokeViaTmux("carwow run rspec", expand("%"))<CR>', { desc = 'Test file' })
vim.keymap.set('n', '<leader>T', ':call InvokeViaTmux("carwow run rspec", expand("%") . ":" . line("."))<CR>', { desc = 'Test file' })

local aucmd_dict = {
    FileType = {
        {
            pattern = "scss",
            callback = function()
                vim.api.nvim_set_keymap(
                    'n',
                    '<F3>',
                    ':call InvokeViaTmux("carwow run yarn lint:css")<CR>',
                    { desc = 'Run Rubocop' }
                )
            end,
        },
        {
            pattern = "ruby",
            callback = function()
                vim.api.nvim_set_keymap(
                    'n',
                    '<F3>',
                    ':call InvokeViaTmuxWithFile("carwow run rubocop -A", expand("%"))<CR>',
                    { desc = 'Run Rubocop' }
                )
            end,
        },
    },
}

for event, opt_tbls in pairs(aucmd_dict) do
    for _, opt_tbl in pairs(opt_tbls) do
        vim.api.nvim_create_autocmd(event, opt_tbl)
    end
end
