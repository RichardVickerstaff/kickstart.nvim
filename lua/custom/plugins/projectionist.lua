local projectionist_config = function ()
  vim.cmd [[
  let g:projectionist_heuristics ={
  \  "spec/*.rb": {
  \     "app/*.rb":                   { "alternate": "spec/{}_spec.rb",                                     "type": "source"},
  \     "lib/*.rb":                   { "alternate": "spec/lib/{}_spec.rb",                                 "type": "source"},
  \     "spec/*_spec.rb":             { "alternate": ["app/{}.rb","{}.rb"],                                 "type": "test"},
  \  },
  \}
]]
end

return {
  -- Map tools and actions based on the project
  {
    "tpope/vim-projectionist",
    config = projectionist_config,
        event = "VeryLazy",
  },
}
