require'neuron'.setup {
    virtual_titles = true,
    mappings = true,
    run = nil, -- function to run when in neuron dir
    neuron_dir = "/home/anderson/Documents/neuron", -- the directory of all of your notes, expanded by default (currently supports only one directory for notes, find a way to detect neuron.dhall to use any directory)
    leader = "<Leader>z", -- the leader key to for all mappings, remember with 'go zettel'
}
