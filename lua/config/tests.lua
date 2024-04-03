vim.cmd [[
function! InvokeViaTmux(cmd, test)
  let l:targetWindow = trim(system('tmux list-windows | grep "test" | cut -f1 -d":" | head -1'))
  if empty(l:targetWindow)
    let l:targetWindow = 3
  endif
  let l:target = "-t " . l:targetWindow . ".1"
  let l:command = "tmux send-keys" . " " . l:target . ' "' . a:cmd . " "  . a:test . '" Enter'
  echom "Running " . a:test . " in window " . l:targetWindow
  let output = system(l:command)
endfunction
]]


-- F3 to run rubocop
vim.keymap.set('n', '<F3>', ':call InvokeViaTmux("carwow run rubocop -a", expand("%"))<CR>', { desc = 'Run Rubocop' })

vim.keymap.set('n', '<leader>t', ':call InvokeViaTmux("carwow run rspec", expand("%"))<CR>', { desc = 'Test file' })
vim.keymap.set('n', '<leader>T', ':call InvokeViaTmux("carwow run rspec", expand("%") . ":" . line("."))<CR>', { desc = 'Test file' })
