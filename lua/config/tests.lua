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


vim.keymap.set('n', '<leader>t', ':call InvokeViaTmux("carwow run rspec", expand("%"))<CR>', { desc = 'Test file' })
vim.keymap.set('n', '<leader>T', ':call InvokeViaTmux("carwow run rspec", expand("%") . ":" . line("."))<CR>', { desc = 'Test file' })
