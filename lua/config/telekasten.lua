local home = vim.fn.expand("~/Documents/zettelkasten")

require('telekasten').setup({
    home = home,
    take_over_my_home = true,
    auto_set_filetype = false,

    dailies      = home .. '/' .. 'daily',
    weeklies     = home .. '/' .. 'weekly',
    templates    = home .. '/' .. 'templates',

    image_subdir = "img",
    extension    = ".md",

    new_note_filename = "title",
    uuid_type = "%Y%m%d%H%M",
    uuid_sep = "-",

    follow_creates_nonexisting = true,
    dailies_create_nonexisting = true,
    weeklies_create_nonexisting = true,

    journal_auto_open = false,

    template_new_note = home .. '/' .. 'templates/new_note.md',
    template_new_daily = home .. '/' .. 'templates/daily.md',
    template_new_weekly= home .. '/' .. 'templates/weekly.md',

    image_link_style = "markdown",
    sort = "filename",
    plug_into_calendar = true,
    calendar_opts = {
        weeknm = 4,
        calendar_monday = 1,
        calendar_mark = 'left-fit',
    },

    close_after_yanking = false,
    insert_after_inserting = true,
    tag_notation = "yaml-bare",
    command_palette_theme = "ivy",
    show_tags_theme = "ivy",
    subdirs_in_links = true,
    template_handling = "smart",
    new_note_location = "smart",
    rename_update_links = true,
})

-- color settings

vim.cmd [[
    hi tklink ctermfg=72 guifg=#689d6a cterm=bold,underline gui=bold,underline
    hi tkBrackets ctermfg=gray guifg=gray
    hi tkHighlight ctermbg=214 ctermfg=124 cterm=bold guibg=#fabd2f guifg=#9d0006 gui=bold

    hi link CalNavi CalRuler
    hi tkTagSep ctermfg=gray guifg=gray
    hi tkTag ctermfg=175 guifg=#d3869B
]]

-- mappings

vim.cmd [[
    nnoremap <leader>zf :lua require('telekasten').find_notes()<CR>
    nnoremap <leader>zd :lua require('telekasten').find_daily_notes()<CR>
    nnoremap <leader>zg :lua require('telekasten').search_notes()<CR>
    nnoremap <leader>zz :lua require('telekasten').follow_link()<CR>
    nnoremap <leader>zT :lua require('telekasten').goto_today()<CR>
    nnoremap <leader>zW :lua require('telekasten').goto_thisweek()<CR>
    nnoremap <leader>zw :lua require('telekasten').find_weekly_notes()<CR>
    nnoremap <leader>zn :lua require('telekasten').new_note()<CR>
    nnoremap <leader>zN :lua require('telekasten').new_templated_note()<CR>
    nnoremap <leader>zy :lua require('telekasten').yank_notelink()<CR>
    nnoremap <leader>zc :lua require('telekasten').show_calendar()<CR>
    nnoremap <leader>zC :CalendarT<CR>
    nnoremap <leader>zi :lua require('telekasten').paste_img_and_link()<CR>
    nnoremap <leader>zt :lua require('telekasten').toggle_todo()<CR>
    nnoremap <leader>zb :lua require('telekasten').show_backlinks()<CR>
    nnoremap <leader>zF :lua require('telekasten').find_friends()<CR>
    nnoremap <leader>zI :lua require('telekasten').insert_img_link({ i=true })<CR>
    nnoremap <leader>zp :lua require('telekasten').preview_img()<CR>
    nnoremap <leader>zm :lua require('telekasten').browse_media()<CR>
    nnoremap <leader>za :lua require('telekasten').show_tags()<CR>
    nnoremap <leader># :lua require('telekasten').show_tags()<CR>
    nnoremap <leader>zr :lua require('telekasten').rename_note()<CR>

    " on hesitation, bring up the panel
    nnoremap <leader>z :lua require('telekasten').panel()<CR>

    " we could define [[ in **insert mode** to call insert link
    " inoremap [[ <cmd>:lua require('telekasten').insert_link()<CR>
    " alternatively: leader [
    inoremap <leader>[ <cmd>:lua require('telekasten').insert_link({ i=true })<CR>
    inoremap <leader>zt <cmd>:lua require('telekasten').toggle_todo({ i=true })<CR>
    inoremap <leader># <cmd>lua require('telekasten').show_tags({i = true})<cr>
]]

-- custom mappings

vim.cmd [[
    nnoremap <Space>z :cd ~/Documents/zettelkasten<CR>
]]
