" Dark Vim/Neovim color scheme.
"
" URL:     github.com/bluz71/vim-moonflyCustom-colors
" License: MIT (https://opensource.org/licenses/MIT)

" Clear highlights and reset syntax.
highlight clear
if exists('syntax_on')
    syntax reset
endif
let g:colors_name='moonflyCustom'

" By default do not color the cursor.
let g:moonflyCustomCursorColor = get(g:, 'moonflyCustomCursorColor', v:false)

" By default do use italics in GUI versions of Vim.
let g:moonflyCustomItalics = get(g:, 'moonflyCustomItalics', v:true)

" By default do not use a customized 'NormalFloat' highlight group (for Neovim
" floating windows).
let g:moonflyCustomNormalFloat = get(g:, 'moonflyCustomNormalFloat', v:false)

" By default use the moonflyCustom color palette in the `:terminal`
let g:moonflyCustomTerminalColors = get(g:, 'moonflyCustomTerminalColors', v:true)

" By default do not use a transparent background in GUI versions of Vim.
let g:moonflyCustomTransparent = get(g:, 'moonflyCustomTransparent', v:false)

" By default do use undercurls in GUI versions of Vim, including terminal Vim
" with termguicolors set.
let g:moonflyCustomUndercurls = get(g:, 'moonflyCustomUndercurls', v:true)

" By default do not underline matching parentheses.
let g:moonflyCustomUnderlineMatchParen = get(g:, 'moonflyCustomUnderlineMatchParen', v:false)

" By default do display vertical split columns.
let g:moonflyCustomWinSeparator = get(g:, 'moonflyCustomWinSeparator', 1)

" Background and foreground
let s:black     = 'NONE' "'#080808'
let s:white     = '#c6c6c6'
" Variations of charcoal-grey
let s:grey0     = '#323437'
let s:grey254   = '#e4e4e4'
let s:grey249   = '#b2b2b2'
let s:grey247   = '#9e9e9e'
let s:grey246   = '#949494'
let s:grey244   = '#808080'
let s:grey241   = '#626262'
let s:grey239   = '#4e4e4e'
let s:grey238   = '#444444'
let s:grey237   = '#3a3a3a'
let s:grey236   = '#303030'
let s:grey235   = '#262626'
let s:grey234   = '#1c1c1c'
let s:grey233   = '#121212'
" Core theme colors
let s:khaki     = '#c2c292'
let s:yellow    = '#e3c78a'
let s:orange    = '#de935f'
let s:coral     = '#f09479'
let s:orchid    = '#e196a2'
let s:lime      = '#85dc85'
let s:green     = '#8cc85f'
let s:emerald   = '#36c692'
let s:blue      = '#80a0ff'
let s:sky       = '#74b2ff'
let s:turquoise = '#79dac8'
let s:purple    = '#ae81ff'
let s:cranberry = '#e65e72'
let s:violet    = '#cf87e8'
let s:crimson   = '#ff5189'
let s:red       = '#ff5454'
" Extra colors
let s:spring    = '#00875f'

" Specify the colors used by the inbuilt terminal of Neovim and Vim
if g:moonflyCustomTerminalColors
    if has('nvim')
        let g:terminal_color_0  = s:grey0
        let g:terminal_color_1  = s:red
        let g:terminal_color_2  = s:green
        let g:terminal_color_3  = s:yellow
        let g:terminal_color_4  = s:blue
        let g:terminal_color_5  = s:violet
        let g:terminal_color_6  = s:turquoise
        let g:terminal_color_7  = s:white
        let g:terminal_color_8  = s:grey246
        let g:terminal_color_9  = s:crimson
        let g:terminal_color_10 = s:emerald
        let g:terminal_color_11 = s:khaki
        let g:terminal_color_12 = s:sky
        let g:terminal_color_13 = s:purple
        let g:terminal_color_14 = s:lime
        let g:terminal_color_15 = s:grey254
    else
        let g:terminal_ansi_colors = [
                    \ s:grey0, s:red, s:green, s:yellow,
                    \ s:blue, s:violet, s:turquoise, s:white,
                    \ s:grey246, s:crimson, s:emerald, s:khaki,
                    \ s:sky, s:purple, s:lime, s:grey254
                    \]
    endif
endif

" Background and text
if g:moonflyCustomTransparent
    exec 'highlight Normal guibg=NONE guifg=' . s:white
else
    exec 'highlight Normal guibg=' . s:black . ' guifg=' . s:white
endif

" Custom moonflyCustom highlight groups
exec 'highlight moonflyCustomReset guifg=fg'
exec 'highlight moonflyCustomVisual guibg=' . s:grey0
exec 'highlight moonflyCustomWhite guifg=' . s:white
exec 'highlight moonflyCustomGrey0 guifg=' . s:grey0
exec 'highlight moonflyCustomGrey254 guifg=' . s:grey254
exec 'highlight moonflyCustomGrey249 guifg=' . s:grey249
exec 'highlight moonflyCustomGrey247 guifg=' . s:grey247
exec 'highlight moonflyCustomGrey246 guifg=' . s:grey246
exec 'highlight moonflyCustomGrey241 guifg=' . s:grey241
exec 'highlight moonflyCustomGrey239 guifg=' . s:grey239
exec 'highlight moonflyCustomGrey238 guifg=' . s:grey238
exec 'highlight moonflyCustomGrey236 guifg=' . s:grey236
exec 'highlight moonflyCustomGrey235 guifg=' . s:grey235
exec 'highlight moonflyCustomKhaki guifg=' . s:khaki
exec 'highlight moonflyCustomYellow guifg=' . s:yellow
exec 'highlight moonflyCustomOrange guifg=' . s:orange
exec 'highlight moonflyCustomCoral guifg=' . s:coral
exec 'highlight moonflyCustomOrchid guifg=' . s:orchid
exec 'highlight moonflyCustomLime guifg=' . s:lime
exec 'highlight moonflyCustomGreen guifg=' . s:green
exec 'highlight moonflyCustomEmerald guifg=' . s:emerald
exec 'highlight moonflyCustomBlue guifg=' . s:blue
exec 'highlight moonflyCustomSky guifg=' . s:sky
exec 'highlight moonflyCustomTurquoise guifg=' . s:turquoise
exec 'highlight moonflyCustomPurple guifg=' . s:purple
exec 'highlight moonflyCustomCranberry guifg=' . s:cranberry
exec 'highlight moonflyCustomViolet guifg=' . s:violet
exec 'highlight moonflyCustomCrimson guifg=' . s:crimson
exec 'highlight moonflyCustomRed guifg=' . s:red
exec 'highlight moonflyCustomWhiteAlert guibg=bg guifg=' . s:white
exec 'highlight moonflyCustomYellowAlert guibg=bg guifg=' . s:yellow
exec 'highlight moonflyCustomCoralAlert guibg=bg guifg=' . s:coral
exec 'highlight moonflyCustomEmeraldAlert guibg=bg guifg=' . s:emerald
exec 'highlight moonflyCustomPurpleAlert guibg=bg guifg=' . s:purple
exec 'highlight moonflyCustomSkyAlert guibg=bg guifg=' . s:sky
exec 'highlight moonflyCustomRedAlert guibg=bg guifg=' . s:red
exec 'highlight moonflyCustomUnderline gui=underline'
exec 'highlight moonflyCustomNoCombine gui=nocombine'
" Statusline helper colors
exec 'highlight moonflyCustomBlueMode guibg=' . s:blue . ' guifg=' . s:grey234
exec 'highlight moonflyCustomEmeraldMode guibg=' . s:emerald . ' guifg=' . s:grey234
exec 'highlight moonflyCustomPurpleMode guibg=' . s:purple . ' guifg=' . s:grey234
exec 'highlight moonflyCustomCrimsonMode guibg=' . s:crimson . ' guifg=' . s:grey234
exec 'highlight moonflyCustomYellowMode guibg=' . s:yellow . ' guifg=' . s:grey234
exec 'highlight moonflyCustomTurquoiseMode guibg=' . s:turquoise . ' guifg=' . s:grey234
" Generic line helper colors
exec 'highlight moonflyCustomBlueLine guibg=' . s:grey236 . ' guifg=' . s:blue
exec 'highlight moonflyCustomEmeraldLine guibg=' . s:grey236 . ' guifg=' . s:emerald
exec 'highlight moonflyCustomGrey246Line guibg=' . s:grey234 . ' guifg=' . s:grey246
exec 'highlight moonflyCustomWhiteLineActive guibg=' . s:grey238 . ' guifg=' . s:grey254
exec 'highlight moonflyCustomYellowLine guibg=' . s:grey234 . ' guifg=' . s:yellow
exec 'highlight moonflyCustomYellowLineActive guibg=' . s:grey238 . ' guifg=' . s:yellow
exec 'highlight moonflyCustomCrimsonLine guibg=' . s:grey236 . ' guifg=' . s:crimson
" Diagnostic helper colors
exec 'highlight moonflyCustomDiagnosticUndercurlError gui=undercurl guisp=' . s:red
exec 'highlight moonflyCustomDiagnosticUndercurlWarn gui=undercurl guisp=' . s:yellow
exec 'highlight moonflyCustomDiagnosticUndercurlInfo gui=undercurl guisp=' . s:sky
exec 'highlight moonflyCustomDiagnosticUndercurlHint gui=undercurl guisp=' . s:white
exec 'highlight moonflyCustomDiagnosticUnderlineError gui=underline guisp=' . s:red
exec 'highlight moonflyCustomDiagnosticUnderlineWarn gui=underline guisp=' . s:blue
exec 'highlight moonflyCustomDiagnosticUnderlineInfo gui=underline guisp=' . s:yellow
exec 'highlight moonflyCustomDiagnosticUnderlineHint gui=underline guisp=' . s:sky

"-----------------------------------------------------------------------
" Core styling
"-----------------------------------------------------------------------

" Color of mode text, -- INSERT --
exec 'highlight ModeMsg guifg=' . s:grey247 . ' gui=none'

" Comments
if g:moonflyCustomItalics
    exec 'highlight Comment guifg=' . s:grey246 . ' gui=italic'
else
    exec 'highlight Comment guifg=' . s:grey246
endif

" Functions
highlight! link Function moonflyCustomSky

" Strings
highlight! link String moonflyCustomKhaki

" Booleans
highlight! link Boolean moonflyCustomCranberry

" Identifiers
exec 'highlight Identifier guifg=' . s:turquoise

" Color of titles
exec 'highlight Title guifg=' . s:orange . ' gui=none'

" const, static
highlight! link StorageClass moonflyCustomCoral

" void, intptr_t
exec 'highlight Type guifg=' . s:emerald . ' gui=none'

" Numbers
highlight! link Constant moonflyCustomOrange

" Character constants
highlight! link Character moonflyCustomPurple

" Exceptions
highlight! link Exception moonflyCustomCrimson

" ifdef/endif
highlight! link PreProc moonflyCustomCranberry

" case in switch statement
highlight! link Label moonflyCustomTurquoise

" end-of-line '$', end-of-file '~'
exec 'highlight NonText guifg=' . s:grey241 . ' gui=none'

" sizeof
highlight! link Operator moonflyCustomCranberry

" for, while
highlight! link Repeat moonflyCustomViolet

" Search
exec 'highlight Search cterm=none guibg=' . s:grey241 . ' guifg=' . s:grey254 . ' gui=none'
exec 'highlight CurSearch cterm=none guibg=' . s:coral . ' guifg=bg gui=none'
exec 'highlight IncSearch cterm=none guibg=' . s:yellow . ' guifg=bg gui=none'

" '\n' sequences
highlight! link Special moonflyCustomCranberry

" if, else
exec 'highlight Statement guifg=' . s:violet . ' gui=none'

" struct, union, enum, typedef
highlight! link Structure moonflyCustomBlue

" Status, split and tab lines
exec 'highlight StatusLine cterm=none guibg=' . s:grey236 . ' guifg=' . s:white . ' gui=none'
exec 'highlight StatusLineNC cterm=none guibg=' . s:grey236 . ' guifg=' . s:grey247 . ' gui=none'
exec 'highlight Tabline cterm=none guibg=' . s:grey236 . ' guifg=' . s:grey247 . ' gui=none'
exec 'highlight TablineSel cterm=none guibg=' . s:grey234 . ' guifg=' . s:blue . ' gui=none'
exec 'highlight TablineSelSymbol cterm=none guibg=' . s:grey234 . ' guifg=' . s:emerald . ' gui=none'
exec 'highlight TablineFill cterm=none guibg=' . s:grey236 . ' guifg=' . s:grey236 . ' gui=none'
exec 'highlight StatusLineTerm cterm=none guibg=' . s:grey236 . ' guifg=' . s:white . ' gui=none'
exec 'highlight StatusLineTermNC cterm=none guibg=' . s:grey236 . ' guifg=' . s:grey247 . ' gui=none'
if g:moonflyCustomWinSeparator == 0
    exec 'highlight VertSplit cterm=none guibg=' . s:black . ' guifg=' . s:black . ' gui=none'
elseif g:moonflyCustomWinSeparator == 1
    exec 'highlight VertSplit cterm=none guibg=' . s:grey236 . ' guifg=' . s:grey236 . ' gui=none'
else
    exec 'highlight VertSplit guibg=NONE guifg=' . s:grey236 . ' gui=none'
end

" Visual selection
highlight! link Visual moonflyCustomVisual
exec 'highlight VisualNOS guibg=' . s:grey0 . ' guifg=fg gui=none'
exec 'highlight VisualInDiff guibg=' . s:grey0 . ' guifg=' . s:white

" Errors, warnings and whitespace-eol
exec 'highlight Error guibg=bg guifg=' . s:red
exec 'highlight ErrorMsg guibg=bg guifg=' . s:red
exec 'highlight WarningMsg guibg=bg guifg=' . s:orange

" Auto-text-completion menu
exec 'highlight Pmenu guibg=' . s:grey235 . ' guifg=fg'
exec 'highlight PmenuSel guibg=' . s:spring . ' guifg=' . s:grey254
exec 'highlight PmenuSbar guibg=' . s:grey235
exec 'highlight PmenuThumb guibg=' . s:grey244
exec 'highlight WildMenu guibg=' . s:spring . ' guifg=' . s:grey254

" Spelling errors
if g:moonflyCustomUndercurls
    exec 'highlight SpellBad ctermbg=NONE cterm=underline guibg=NONE gui=undercurl guisp=' . s:red
    exec 'highlight SpellCap ctermbg=NONE cterm=underline guibg=NONE gui=undercurl guisp=' . s:blue
    exec 'highlight SpellRare ctermbg=NONE cterm=underline guibg=NONE gui=undercurl guisp=' . s:yellow
    exec 'highlight SpellLocal ctermbg=NONE cterm=underline guibg=NONE gui=undercurl guisp=' . s:sky
else
    exec 'highlight SpellBad ctermbg=NONE cterm=underline guibg=NONE guifg=' . s:red . ' gui=underline guisp=' . s:red
    exec 'highlight SpellCap ctermbg=NONE cterm=underline guibg=NONE guifg=' . s:blue . ' gui=underline guisp=' . s:blue
    exec 'highlight SpellRare ctermbg=NONE cterm=underline guibg=NONE guifg=' . s:yellow . ' gui=underline guisp=' . s:yellow
    exec 'highlight SpellLocal ctermbg=NONE cterm=underline guibg=NONE guifg=' . s:sky . ' gui=underline guisp=' . s:sky
endif

" Misc
exec 'highlight Question guifg=' . s:lime . ' gui=none'
exec 'highlight MoreMsg guifg=' . s:red . ' gui=none'
exec 'highlight LineNr guibg=bg guifg=' . s:grey241 . ' gui=none'
if g:moonflyCustomCursorColor
    exec 'highlight Cursor guifg=bg guibg=' . s:blue
else
    exec 'highlight Cursor guifg=bg guibg=' . s:grey247
endif
exec 'highlight lCursor guifg=bg guibg=' . s:grey247
exec 'highlight CursorLineNr cterm=none guibg=' . s:grey234 . ' guifg=' . s:blue . ' gui=none'
exec 'highlight CursorColumn guibg=' . s:grey234
exec 'highlight CursorLine cterm=none guibg=' . s:grey234
exec 'highlight Folded guibg=' . s:grey234 . ' guifg='. s:lime
exec 'highlight FoldColumn guibg=' . s:grey236 . ' guifg=' . s:lime
exec 'highlight SignColumn guibg=bg guifg=' . s:lime
exec 'highlight Todo guibg=' . s:grey235 . ' guifg=' . s:yellow
exec 'highlight SpecialKey guibg=bg guifg=' . s:sky
if g:moonflyCustomUnderlineMatchParen
    exec 'highlight MatchParen guibg=bg gui=underline'
else
    highlight! link MatchParen moonflyCustomVisual
endif
exec 'highlight Ignore guifg=' . s:sky
exec 'highlight Underlined guifg=' . s:emerald . ' gui=none'
exec 'highlight QuickFixLine guibg=' . s:grey237
highlight! link Delimiter moonflyCustomWhite
highlight! link qfFileName moonflyCustomEmerald

" Color column (after line 80)
exec 'highlight ColorColumn guibg=' . s:grey233

" Conceal color
exec 'highlight Conceal guibg=NONE guifg=' . s:grey249

" vimdiff/nvim -d
exec 'highlight DiffAdd guibg=' . s:emerald . ' guifg=' . s:black
exec 'highlight DiffChange guibg=' . s:grey236
exec 'highlight DiffDelete guibg=' . s:grey236 . ' guifg=' . s:grey241 ' gui=none'
exec 'highlight DiffText guibg=' . s:blue . ' guifg=' . s:black . ' gui=none'

" Neovim-only core highlight groups
if has('nvim-0.8')
    lua require("moonflyCustom").core()
elseif has('nvim-0.7')
    exec 'highlight Whitespace guifg=' . s:grey0
    exec 'highlight TermCursor guibg=' . s:grey247 . ' guifg=bg gui=none'
    if g:moonflyCustomNormalFloat
        exec 'highlight NormalFloat guibg=bg guifg=' . s:grey249
    else
        exec 'highlight NormalFloat guibg=' . s:grey234 . ' guifg=fg'
    endif
    exec 'highlight FloatBorder guibg=bg guifg=' . s:grey236
    highlight! link WinSeparator VertSplit

    " Neovim Treesitter
    highlight! link TSAnnotation moonflyCustomViolet
    highlight! link TSAttribute moonflyCustomSky
    highlight! link TSConstant moonflyCustomTurquoise
    highlight! link TSConstBuiltin moonflyCustomGreen
    highlight! link TSConstMacro moonflyCustomViolet
    highlight! link TSConstructor moonflyCustomEmerald
    highlight! link TSDanger Todo
    highlight! link TSFuncBuiltin moonflyCustomSky
    highlight! link TSFuncMacro moonflyCustomSky
    highlight! link TSInclude moonflyCustomCranberry
    highlight! link TSKeywordOperator moonflyCustomViolet
    highlight! link TSNamespace moonflyCustomTurquoise
    highlight! link TSParameter moonflyCustomWhite
    highlight! link TSPunctSpecial moonflyCustomCranberry
    highlight! link TSSymbol moonflyCustomPurple
    highlight! link TSTag moonflyCustomBlue
    highlight! link TSTagDelimiter moonflyCustomLime
    highlight! link TSVariableBuiltin moonflyCustomLime
    " Language specific overrides.
    highlight! link bashTSParameter moonflyCustomTurquoise
    highlight! link cssTSPunctDelimiter moonflyCustomCranberry
    highlight! link cssTSType moonflyCustomBlue
    highlight! link scssTSPunctDelimiter moonflyCustomCranberry
    highlight! link scssTSType moonflyCustomBlue
    highlight! link scssTSVariable moonflyCustomTurquoise
    highlight! link vimTSVariable moonflyCustomTurquoise
    highlight! link vimTSVariableBuiltin moonflyCustomEmerald
    highlight! link yamlTSField moonflyCustomSky
    highlight! link yamlTSPunctDelimiter moonflyCustomCranberry

    " Neovim Diagnostic
    highlight! link DiagnosticError moonflyCustomRed
    highlight! link DiagnosticWarn moonflyCustomYellow
    highlight! link DiagnosticInfo moonflyCustomSky
    highlight! link DiagnosticHint moonflyCustomWhite
    if g:moonflyCustomUndercurls
        highlight! link DiagnosticUnderlineError moonflyCustomDiagnosticUndercurlError
        highlight! link DiagnosticUnderlineWarn moonflyCustomDiagnosticUndercurlWarn
        highlight! link DiagnosticUnderlineInfo moonflyCustomDiagnosticUndercurlInfo
        highlight! link DiagnosticUnderlineHint moonflyCustomDiagnosticUndercurlHint
    else
        highlight! link DiagnosticUnderlineError moonflyCustomDiagnosticUnderlineError
        highlight! link DiagnosticUnderlineWarn moonflyCustomDiagnosticUnderlineWarn
        highlight! link DiagnosticUnderlineInfo moonflyCustomDiagnosticUnderlineInfo
        highlight! link DiagnosticUnderlineHint moonflyCustomDiagnosticUnderlineHint
    endif
    highlight! link DiagnosticVirtualTextError moonflyCustomGrey241
    highlight! link DiagnosticVirtualTextWarn moonflyCustomGrey241
    highlight! link DiagnosticVirtualTextInfo moonflyCustomGrey241
    highlight! link DiagnosticVirtualTextHint moonflyCustomGrey241
    highlight! link DiagnosticSignError moonflyCustomRedAlert
    highlight! link DiagnosticSignWarn moonflyCustomYellowAlert
    highlight! link DiagnosticSignInfo moonflyCustomSkyAlert
    highlight! link DiagnosticSignHint moonflyCustomWhiteAlert
    highlight! link DiagnosticFloatingError moonflyCustomRed
    highlight! link DiagnosticFloatingWarn moonflyCustomYellow
    highlight! link DiagnosticFloatingInfo moonflyCustomSky
    highlight! link DiagnosticFloatingHint moonflyCustomWhite
    highlight! link LspSignatureActiveParameter moonflyCustomVisual
endif

"-----------------------------------------------------------------------
" Language styling
"-----------------------------------------------------------------------

" Neovim 0.8 provides builtin Treesitter support for C, Lua and Vimscript.
" Likewise, common languages, such as C++, JavaScript, Python and others, now
" have mature Treesitter support via the nvim-treesitter plugin. Hence, only
" setup old-school regex highlight groups for Vim and Neovim versions prior to
" 0.8.
if !has('nvim-0.8')
    " C
    highlight! link cDefine moonflyCustomViolet
    highlight! link cPreCondit moonflyCustomViolet
    highlight! link cStatement moonflyCustomViolet
    highlight! link cStructure moonflyCustomCoral

    " C++
    highlight! link cppAccess moonflyCustomLime
    highlight! link cppCast moonflyCustomTurquoise
    highlight! link cppCustomClass moonflyCustomTurquoise
    highlight! link cppExceptions moonflyCustomLime
    highlight! link cppModifier moonflyCustomViolet
    highlight! link cppOperator moonflyCustomGreen
    highlight! link cppStatement moonflyCustomTurquoise
    highlight! link cppSTLconstant moonflyCustomBlue
    highlight! link cppSTLnamespace moonflyCustomBlue
    highlight! link cppStructure moonflyCustomViolet

    " C#
    highlight! link csModifier moonflyCustomLime
    highlight! link csPrecondit moonflyCustomViolet
    highlight! link csStorage moonflyCustomViolet
    highlight! link csXmlTag moonflyCustomBlue

    " Go
    highlight! link goBuiltins moonflyCustomSky
    highlight! link goConditional moonflyCustomViolet
    highlight! link goDeclType moonflyCustomGreen
    highlight! link goDirective moonflyCustomCranberry
    highlight! link goFloats moonflyCustomPurple
    highlight! link goFunction moonflyCustomBlue
    highlight! link goFunctionCall moonflyCustomSky
    highlight! link goImport moonflyCustomCranberry
    highlight! link goLabel moonflyCustomYellow
    highlight! link goMethod moonflyCustomSky
    highlight! link goMethodCall moonflyCustomSky
    highlight! link goPackage moonflyCustomViolet
    highlight! link goSignedInts moonflyCustomEmerald
    highlight! link goStruct moonflyCustomCoral
    highlight! link goStructDef moonflyCustomCoral
    highlight! link goUnsignedInts moonflyCustomPurple

    " Java
    highlight! link javaAnnotation moonflyCustomLime
    highlight! link javaBraces moonflyCustomWhite
    highlight! link javaClassDecl moonflyCustomYellow
    highlight! link javaCommentTitle moonflyCustomGrey247
    highlight! link javaConstant moonflyCustomSky
    highlight! link javaDebug moonflyCustomSky
    highlight! link javaMethodDecl moonflyCustomYellow
    highlight! link javaOperator moonflyCustomCrimson
    highlight! link javaScopeDecl moonflyCustomViolet
    highlight! link javaStatement moonflyCustomTurquoise

    " JavaScript, 'pangloss/vim-javascript' plugin
    highlight! link jsClassDefinition moonflyCustomEmerald
    highlight! link jsClassKeyword moonflyCustomOrange
    highlight! link jsFrom moonflyCustomCoral
    highlight! link jsFuncBlock moonflyCustomTurquoise
    highlight! link jsFuncCall moonflyCustomSky
    highlight! link jsFunction moonflyCustomLime
    highlight! link jsGlobalObjects moonflyCustomEmerald
    highlight! link jsModuleAs moonflyCustomCoral
    highlight! link jsObjectKey moonflyCustomSky
    highlight! link jsObjectValue moonflyCustomEmerald
    highlight! link jsOperator moonflyCustomViolet
    highlight! link jsStorageClass moonflyCustomLime
    highlight! link jsTemplateBraces moonflyCustomCranberry
    highlight! link jsTemplateExpression moonflyCustomTurquoise
    highlight! link jsThis moonflyCustomGreen

    " JSX, 'MaxMEllon/vim-jsx-pretty' plugin
    highlight! link jsxAttrib moonflyCustomLime
    highlight! link jsxClosePunct moonflyCustomPurple
    highlight! link jsxComponentName moonflyCustomBlue
    highlight! link jsxOpenPunct moonflyCustomLime
    highlight! link jsxTagName moonflyCustomBlue

    " Lua
    highlight! link luaBraces moonflyCustomCranberry
    highlight! link luaBuiltin moonflyCustomGreen
    highlight! link luaFuncCall moonflyCustomSky
    highlight! link luaSpecialTable moonflyCustomSky

    " Python
    highlight! link pythonBuiltin moonflyCustomBlue
    highlight! link pythonClassVar moonflyCustomGreen
    highlight! link pythonCoding moonflyCustomSky
    highlight! link pythonImport moonflyCustomCranberry
    highlight! link pythonOperator moonflyCustomViolet
    highlight! link pythonRun moonflyCustomSky
    highlight! link pythonStatement moonflyCustomViolet

    " Ruby
    highlight! link rubyAccess moonflyCustomYellow
    highlight! link rubyAssertion moonflyCustomSky
    highlight! link rubyAttribute moonflyCustomSky
    highlight! link rubyBlockParameter moonflyCustomGreen
    highlight! link rubyCallback moonflyCustomSky
    highlight! link rubyDefine moonflyCustomViolet
    highlight! link rubyEntities moonflyCustomSky
    highlight! link rubyExceptional moonflyCustomCoral
    highlight! link rubyGemfileMethod moonflyCustomSky
    highlight! link rubyInstanceVariable moonflyCustomTurquoise
    highlight! link rubyInterpolationDelimiter moonflyCustomCranberry
    highlight! link rubyMacro moonflyCustomSky
    highlight! link rubyModule moonflyCustomBlue
    highlight! link rubyPseudoVariable moonflyCustomGreen
    highlight! link rubyResponse moonflyCustomSky
    highlight! link rubyRoute moonflyCustomSky
    highlight! link rubySharpBang moonflyCustomGrey247
    highlight! link rubyStringDelimiter moonflyCustomKhaki
    highlight! link rubySymbol moonflyCustomPurple

    " Rust
    highlight! link rustAssert moonflyCustomGreen
    highlight! link rustAttribute moonflyCustomReset
    highlight! link rustCharacterInvalid moonflyCustomCranberry
    highlight! link rustCharacterInvalidUnicode moonflyCustomCranberry
    highlight! link rustCommentBlockDoc moonflyCustomGrey247
    highlight! link rustCommentBlockDocError moonflyCustomGrey247
    highlight! link rustCommentLineDoc moonflyCustomGrey247
    highlight! link rustCommentLineDocError moonflyCustomGrey247
    highlight! link rustConstant moonflyCustomOrange
    highlight! link rustDerive moonflyCustomGreen
    highlight! link rustEscapeError moonflyCustomCranberry
    highlight! link rustFuncName moonflyCustomBlue
    highlight! link rustIdentifier moonflyCustomBlue
    highlight! link rustInvalidBareKeyword moonflyCustomCranberry
    highlight! link rustKeyword moonflyCustomViolet
    highlight! link rustLifetime moonflyCustomViolet
    highlight! link rustMacro moonflyCustomGreen
    highlight! link rustMacroVariable moonflyCustomViolet
    highlight! link rustModPath moonflyCustomBlue
    highlight! link rustObsoleteExternMod moonflyCustomCranberry
    highlight! link rustObsoleteStorage moonflyCustomCranberry
    highlight! link rustReservedKeyword moonflyCustomCranberry
    highlight! link rustSelf moonflyCustomTurquoise
    highlight! link rustSigil moonflyCustomTurquoise
    highlight! link rustStorage moonflyCustomViolet
    highlight! link rustStructure moonflyCustomViolet
    highlight! link rustTrait moonflyCustomEmerald
    highlight! link rustType moonflyCustomEmerald

    " TypeScript (leafgarland/typescript-vim)
    highlight! link typescriptDOMObjects moonflyCustomBlue
    highlight! link typescriptFuncComma moonflyCustomWhite
    highlight! link typescriptFuncKeyword moonflyCustomLime
    highlight! link typescriptGlobalObjects moonflyCustomBlue
    highlight! link typescriptIdentifier moonflyCustomGreen
    highlight! link typescriptNull moonflyCustomGreen
    highlight! link typescriptOpSymbols moonflyCustomViolet
    highlight! link typescriptOperator moonflyCustomCrimson
    highlight! link typescriptParens moonflyCustomWhite
    highlight! link typescriptReserved moonflyCustomViolet
    highlight! link typescriptStorageClass moonflyCustomLime

    " TypeScript (HerringtonDarkholme/yats.vim)
    highlight! link typeScriptModule moonflyCustomBlue
    highlight! link typescriptAbstract moonflyCustomCoral
    highlight! link typescriptArrayMethod moonflyCustomSky
    highlight! link typescriptArrowFuncArg moonflyCustomWhite
    highlight! link typescriptBOM moonflyCustomEmerald
    highlight! link typescriptBOMHistoryMethod moonflyCustomSky
    highlight! link typescriptBOMLocationMethod moonflyCustomSky
    highlight! link typescriptBOMWindowProp moonflyCustomGreen
    highlight! link typescriptBraces moonflyCustomWhite
    highlight! link typescriptCall moonflyCustomWhite
    highlight! link typescriptClassHeritage moonflyCustomEmerald
    highlight! link typescriptClassKeyword moonflyCustomOrange
    highlight! link typescriptClassName moonflyCustomEmerald
    highlight! link typescriptDecorator moonflyCustomLime
    highlight! link typescriptDOMDocMethod moonflyCustomSky
    highlight! link typescriptDOMEventTargetMethod moonflyCustomSky
    highlight! link typescriptDOMNodeMethod moonflyCustomSky
    highlight! link typescriptExceptions moonflyCustomCrimson
    highlight! link typescriptFuncType moonflyCustomWhite
    highlight! link typescriptMathStaticMethod moonflyCustomSky
    highlight! link typescriptMethodAccessor moonflyCustomViolet
    highlight! link typescriptObjectLabel moonflyCustomSky
    highlight! link typescriptParamImpl moonflyCustomWhite
    highlight! link typescriptStringMethod moonflyCustomSky
    highlight! link typescriptTry moonflyCustomCrimson
    highlight! link typescriptVariable moonflyCustomLime
    highlight! link typescriptXHRMethod moonflyCustomSky

    " Vimscript
    highlight! link vimBracket moonflyCustomSky
    highlight! link vimCommand moonflyCustomViolet
    highlight! link vimCommentTitle moonflyCustomViolet
    highlight! link vimEnvvar moonflyCustomCrimson
    highlight! link vimFuncName moonflyCustomSky
    highlight! link vimFuncSID moonflyCustomSky
    highlight! link vimFunction moonflyCustomSky
    highlight! link vimHighlight moonflyCustomSky
    highlight! link vimNotFunc moonflyCustomViolet
    highlight! link vimNotation moonflyCustomSky
    highlight! link vimOption moonflyCustomTurquoise
    highlight! link vimParenSep moonflyCustomWhite
    highlight! link vimSep moonflyCustomWhite
    highlight! link vimUserFunc moonflyCustomSky
endif

" Clojure
highlight! link clojureDefine moonflyCustomViolet
highlight! link clojureKeyword moonflyCustomPurple
highlight! link clojureMacro moonflyCustomOrange
highlight! link clojureParen moonflyCustomBlue
highlight! link clojureSpecial moonflyCustomSky

" CoffeeScript
highlight! link coffeeConstant moonflyCustomEmerald
highlight! link coffeeGlobal moonflyCustomTurquoise
highlight! link coffeeKeyword moonflyCustomOrange
highlight! link coffeeObjAssign moonflyCustomSky
highlight! link coffeeSpecialIdent moonflyCustomLime
highlight! link coffeeSpecialVar moonflyCustomBlue
highlight! link coffeeStatement moonflyCustomCoral

" Crystal
highlight! link crystalAccess moonflyCustomYellow
highlight! link crystalAttribute moonflyCustomSky
highlight! link crystalBlockParameter moonflyCustomGreen
highlight! link crystalClass moonflyCustomOrange
highlight! link crystalDefine moonflyCustomViolet
highlight! link crystalExceptional moonflyCustomCoral
highlight! link crystalInstanceVariable moonflyCustomLime
highlight! link crystalModule moonflyCustomBlue
highlight! link crystalPseudoVariable moonflyCustomGreen
highlight! link crystalSharpBang moonflyCustomGrey247
highlight! link crystalStringDelimiter moonflyCustomKhaki
highlight! link crystalSymbol moonflyCustomPurple

" CSS/SCSS
highlight! link cssAtRule moonflyCustomViolet
highlight! link cssAttr moonflyCustomTurquoise
highlight! link cssBraces moonflyCustomReset
highlight! link cssClassName moonflyCustomEmerald
highlight! link cssClassNameDot moonflyCustomViolet
highlight! link cssColor moonflyCustomTurquoise
highlight! link cssIdentifier moonflyCustomSky
highlight! link cssProp moonflyCustomTurquoise
highlight! link cssTagName moonflyCustomBlue
highlight! link cssUnitDecorators moonflyCustomKhaki
highlight! link cssValueLength moonflyCustomPurple
highlight! link cssValueNumber moonflyCustomPurple
highlight! link sassId moonflyCustomBlue
highlight! link sassIdChar moonflyCustomViolet
highlight! link sassMedia moonflyCustomViolet
highlight! link scssSelectorName moonflyCustomBlue

" Dart
highlight! link dartMetadata moonflyCustomLime
highlight! link dartStorageClass moonflyCustomViolet
highlight! link dartTypedef moonflyCustomViolet

" Elixir
highlight! link eelixirDelimiter moonflyCustomCrimson
highlight! link elixirAtom moonflyCustomPurple
highlight! link elixirBlockDefinition moonflyCustomViolet
highlight! link elixirDefine moonflyCustomViolet
highlight! link elixirDocTest moonflyCustomGrey247
highlight! link elixirExUnitAssert moonflyCustomLime
highlight! link elixirExUnitMacro moonflyCustomSky
highlight! link elixirKernelFunction moonflyCustomGreen
highlight! link elixirKeyword moonflyCustomOrange
highlight! link elixirModuleDefine moonflyCustomBlue
highlight! link elixirPrivateDefine moonflyCustomViolet
highlight! link elixirStringDelimiter moonflyCustomKhaki
highlight! link elixirVariable moonflyCustomTurquoise

" Elm
highlight! link elmLetBlockDefinition moonflyCustomLime
highlight! link elmTopLevelDecl moonflyCustomCoral
highlight! link elmType moonflyCustomSky

" Haskell
highlight! link haskellDecl moonflyCustomOrange
highlight! link haskellDeclKeyword moonflyCustomOrange
highlight! link haskellIdentifier moonflyCustomTurquoise
highlight! link haskellLet moonflyCustomSky
highlight! link haskellOperators moonflyCustomCranberry
highlight! link haskellType moonflyCustomSky
highlight! link haskellWhere moonflyCustomViolet

" HTML
highlight! link htmlArg moonflyCustomTurquoise
highlight! link htmlLink moonflyCustomGreen
highlight! link htmlH1 moonflyCustomCranberry
highlight! link htmlH2 moonflyCustomOrange
highlight! link htmlEndTag moonflyCustomPurple
highlight! link htmlTag moonflyCustomLime
highlight! link htmlTagN moonflyCustomBlue
highlight! link htmlTagName moonflyCustomBlue
highlight! link htmlUnderline moonflyCustomWhite
if g:moonflyCustomItalics
    exec 'highlight htmlBoldItalic guibg=' . s:black . ' guifg=' . s:coral . ' gui=italic'
    exec 'highlight htmlBoldUnderlineItalic guibg=' . s:black . ' guifg=' . s:coral . ' gui=italic'
    exec 'highlight htmlItalic guifg=' . s:grey247 . ' gui=italic'
    exec 'highlight htmlUnderlineItalic guibg=' . s:black . ' guifg=' . s:grey247 . ' gui=italic'
else
    exec 'highlight htmlBoldItalic guibg=' . s:black . ' guifg=' . s:coral ' gui=none'
    exec 'highlight htmlBoldUnderlineItalic guibg=' . s:black . ' guifg=' . s:coral
    exec 'highlight htmlItalic guifg=' . s:grey247 ' gui=none'
    exec 'highlight htmlUnderlineItalic guibg=' . s:black . ' guifg=' . s:grey247
endif

" Markdown, 'tpope/vim-markdown' plugin
highlight! link markdownBold moonflyCustomYellow
highlight! link markdownCode moonflyCustomKhaki
highlight! link markdownCodeDelimiter moonflyCustomKhaki
highlight! link markdownError NormalNC
highlight! link markdownH1 moonflyCustomOrange
highlight! link markdownHeadingRule moonflyCustomBlue
highlight! link markdownItalic moonflyCustomViolet
highlight! link markdownUrl moonflyCustomPurple

" Markdown, 'plasticboy/vim-markdown' plugin
highlight! link mkdDelimiter moonflyCustomWhite
highlight! link mkdLineBreak NormalNC
highlight! link mkdListItem moonflyCustomBlue
highlight! link mkdURL moonflyCustomPurple

" PHP
highlight! link phpClass moonflyCustomEmerald
highlight! link phpClasses moonflyCustomBlue
highlight! link phpFunction moonflyCustomSky
highlight! link phpParent moonflyCustomReset
highlight! link phpType moonflyCustomViolet

" PureScript
highlight! link purescriptClass moonflyCustomOrange
highlight! link purescriptModuleParams moonflyCustomCoral

" Scala (note, link highlighting does not work, I don't know why)
exec 'highlight scalaCapitalWord guifg=' . s:blue
exec 'highlight scalaCommentCodeBlock guifg=' . s:grey247
exec 'highlight scalaInstanceDeclaration guifg=' . s:turquoise
exec 'highlight scalaKeywordModifier guifg=' . s:lime
exec 'highlight scalaSpecial guifg=' . s:crimson

" Shell scripts
highlight! link shAlias moonflyCustomTurquoise
highlight! link shCommandSub moonflyCustomReset
highlight! link shLoop moonflyCustomViolet
highlight! link shSetList moonflyCustomTurquoise
highlight! link shShellVariables moonflyCustomLime
highlight! link shVariable moonflyCustomTurquoise

" XML
highlight! link xmlAttrib moonflyCustomLime
highlight! link xmlEndTag moonflyCustomBlue
highlight! link xmlTag moonflyCustomLime
highlight! link xmlTagName moonflyCustomBlue

"-----------------------------------------------------------------------
" Plugin styling
"-----------------------------------------------------------------------

" Git commits
highlight! link gitCommitBranch moonflyCustomSky
highlight! link gitCommitDiscardedFile moonflyCustomCrimson
highlight! link gitCommitDiscardedType moonflyCustomSky
highlight! link gitCommitHeader moonflyCustomPurple
highlight! link gitCommitSelectedFile moonflyCustomEmerald
highlight! link gitCommitSelectedType moonflyCustomSky
highlight! link gitCommitUntrackedFile moonflyCustomCranberry
highlight! link gitEmail moonflyCustomBlue

" Git commit diffs
highlight! link diffAdded moonflyCustomGreen
highlight! link diffChanged moonflyCustomCrimson
highlight! link diffIndexLine moonflyCustomCrimson
highlight! link diffLine moonflyCustomSky
highlight! link diffRemoved moonflyCustomRed
highlight! link diffSubname moonflyCustomSky

" Tagbar plugin
highlight! link TagbarFoldIcon moonflyCustomGrey247
highlight! link TagbarVisibilityPublic moonflyCustomLime
highlight! link TagbarVisibilityProtected moonflyCustomLime
highlight! link TagbarVisibilityPrivate moonflyCustomLime
highlight! link TagbarKind moonflyCustomEmerald

" NERDTree plugin
highlight! link NERDTreeClosable moonflyCustomGrey247
highlight! link NERDTreeCWD moonflyCustomPurple
highlight! link NERDTreeDir moonflyCustomSky
highlight! link NERDTreeDirSlash moonflyCustomCranberry
highlight! link NERDTreeExecFile moonflyCustomKhaki
highlight! link NERDTreeFile moonflyCustomWhite
highlight! link NERDTreeHelp moonflyCustomGrey247
highlight! link NERDTreeLinkDir moonflyCustomBlue
highlight! link NERDTreeLinkFile moonflyCustomBlue
highlight! link NERDTreeLinkTarget moonflyCustomTurquoise
highlight! link NERDTreeOpenable moonflyCustomGrey247
highlight! link NERDTreePart moonflyCustomGrey0
highlight! link NERDTreePartFile moonflyCustomGrey0
highlight! link NERDTreeUp moonflyCustomBlue

" NERDTree Git plugin
highlight! link NERDTreeGitStatusDirDirty moonflyCustomKhaki
highlight! link NERDTreeGitStatusModified moonflyCustomCrimson
highlight! link NERDTreeGitStatusRenamed moonflyCustomSky
highlight! link NERDTreeGitStatusStaged moonflyCustomSky
highlight! link NERDTreeGitStatusUntracked moonflyCustomRed

" fern.vim plugin
highlight! link FernBranchSymbol moonflyCustomGrey239
highlight! link FernLeafSymbol moonflyCustomGrey239
highlight! link FernBranchText moonflyCustomBlue
highlight! link FernMarkedLine moonflyCustomVisual
highlight! link FernMarkedText moonflyCustomCrimson
highlight! link FernRootSymbol moonflyCustomPurple
highlight! link FernRootText moonflyCustomPurple

" fern-git-status.vim plugin
highlight! link FernGitStatusBracket moonflyCustomGrey246
highlight! link FernGitStatusIndex moonflyCustomEmerald
highlight! link FernGitStatusWorktree moonflyCustomCrimson

" Glyph palette
highlight! link GlyphPalette1 moonflyCustomCranberry
highlight! link GlyphPalette2 moonflyCustomEmerald
highlight! link GlyphPalette3 moonflyCustomYellow
highlight! link GlyphPalette4 moonflyCustomBlue
highlight! link GlyphPalette6 moonflyCustomTurquoise
highlight! link GlyphPalette7 moonflyCustomWhite
highlight! link GlyphPalette9 moonflyCustomCrimson

" Misc items
highlight! link bufExplorerHelp moonflyCustomGrey247
highlight! link bufExplorerSortBy moonflyCustomGrey247
highlight! link CleverFDefaultLabel moonflyCustomCrimson
highlight! link CtrlPMatch moonflyCustomCoral
highlight! link Directory moonflyCustomBlue
highlight! link erubyDelimiter moonflyCustomCrimson
highlight! link HighlightedyankRegion moonflyCustomGrey0
highlight! link jsonKeyword moonflyCustomSky
highlight! link jsonQuote moonflyCustomWhite
highlight! link netrwClassify moonflyCustomCranberry
highlight! link netrwDir moonflyCustomSky
highlight! link netrwExe moonflyCustomKhaki
highlight! link tagName moonflyCustomTurquoise
highlight! link Cheat40Header moonflyCustomBlue
highlight! link yamlBlockMappingKey moonflyCustomSky
highlight! link yamlFlowMappingKey moonflyCustomSky
if g:moonflyCustomUnderlineMatchParen
    exec 'highlight MatchWord gui=underline guisp=' . s:coral
else
    highlight! link MatchWord moonflyCustomCoral
endif
exec 'highlight snipLeadingSpaces guibg=bg guifg=fg'
exec 'highlight MatchWordCur guibg=bg'

" ALE plugin
if g:moonflyCustomUndercurls
    highlight! link ALEError moonflyCustomDiagnosticUndercurlError
    highlight! link ALEWarning moonflyCustomDiagnosticUndercurlWarn
    highlight! link ALEInfo moonflyCustomDiagnosticUndercurlInfo
else
    highlight! link ALEError moonflyCustomDiagnosticUnderlineError
    highlight! link ALEWarning moonflyCustomDiagnosticUnderlineWarn
    highlight! link ALEInfo moonflyCustomDiagnosticUnderlineInfo
endif
highlight! link ALEVirtualTextError moonflyCustomGrey241
highlight! link ALEErrorSign moonflyCustomRedAlert
highlight! link ALEVirtualTextWarning moonflyCustomGrey241
highlight! link ALEWarningSign moonflyCustomYellowAlert
highlight! link ALEVirtualTextInfo moonflyCustomGrey241
highlight! link ALEInfoSign moonflyCustomSkyAlert

" GitGutter plugin
highlight! link GitGutterAdd moonflyCustomEmeraldAlert
highlight! link GitGutterChange moonflyCustomYellowAlert
highlight! link GitGutterChangeDelete moonflyCustomCoralAlert
highlight! link GitGutterDelete moonflyCustomRedAlert

" Signify plugin
highlight! link SignifySignAdd moonflyCustomEmeraldAlert
highlight! link SignifySignChange moonflyCustomYellowAlert
highlight! link SignifySignChangeDelete moonflyCustomCoralAlert
highlight! link SignifySignDelete moonflyCustomRedAlert

" FZF plugin
exec 'highlight fzf1 guifg=' . s:crimson . ' guibg=' . s:grey236
exec 'highlight fzf2 guifg=' . s:blue . ' guibg=' . s:grey236
exec 'highlight fzf3 guifg=' . s:emerald . ' guibg=' . s:grey236
exec 'highlight fzfNormal guifg=' . s:grey249
exec 'highlight fzfFgPlus guifg=' . s:grey254
exec 'highlight fzfBorder guifg=' . s:grey236
let g:fzf_colors = {
  \  'fg':      ['fg', 'fzfNormal'],
  \  'bg':      ['bg', 'Normal'],
  \  'hl':      ['fg', 'Boolean'],
  \  'fg+':     ['fg', 'fzfFgPlus'],
  \  'bg+':     ['bg', 'Pmenu'],
  \  'hl+':     ['fg', 'Boolean'],
  \  'info':    ['fg', 'String'],
  \  'border':  ['fg', 'fzfBorder'],
  \  'prompt':  ['fg', 'fzf2'],
  \  'pointer': ['fg', 'Exception'],
  \  'marker':  ['fg', 'StorageClass'],
  \  'spinner': ['fg', 'Type'],
  \  'header':  ['fg', 'CursorLineNr']
  \}

" mistfly-statusline plugin
highlight! link MistflyNormal moonflyCustomBlueMode
highlight! link MistflyInsert moonflyCustomEmeraldMode
highlight! link MistflyVisual moonflyCustomPurpleMode
highlight! link MistflyCommand moonflyCustomYellowMode
highlight! link MistflyReplace moonflyCustomCrimsonMode

" Coc plugin (see issue: https://github.com/bluz71/vim-nightfly-colors/issues/31)
highlight! link CocUnusedHighlight moonflyCustomGrey249

" indentLine plugin
if !exists('g:indentLine_defaultGroup') && !exists('g:indentLine_color_gui')
    let g:indentLine_color_gui = s:grey235
endif

" Neovim only plugins
if has('nvim-0.7')
    lua require("moonflyCustom").plugins()
elseif has('nvim-0.6')
    " NvimTree plugin
    highlight! link NvimTreeFolderIcon moonflyCustomBlue
    highlight! link NvimTreeFolderName moonflyCustomBlue
    highlight! link NvimTreeIndentMarker moonflyCustomGrey239
    highlight! link NvimTreeOpenedFolderName moonflyCustomBlue
    highlight! link NvimTreeRootFolder moonflyCustomPurple
    highlight! link NvimTreeSpecialFile moonflyCustomYellow
    highlight! link NvimTreeWindowPicker DiffChange
    exec 'highlight NvimTreeExecFile guifg=' . s:green . ' gui=none'
    exec 'highlight NvimTreeImageFile guifg=' . s:violet . ' gui=none'
    exec 'highlight NvimTreeOpenedFile guifg=' . s:yellow . ' gui=none'
    exec 'highlight NvimTreeSymlink guifg=' . s:turquoise . ' gui=none'

    " Neo-tree plugin
    highlight! link NeoTreeDimText moonflyCustomGrey239
    highlight! link NeoTreeDotfile moonflyCustomGrey236
    highlight! link NeoTreeGitAdded moonflyCustomGreen
    highlight! link NeoTreeGitConflict moonflyCustomCrimson
    highlight! link NeoTreeGitModified moonflyCustomYellow
    highlight! link NeoTreeGitUntracked moonflyCustomGrey241
    highlight! link NeoTreeMessage moonflyCustomGrey247
    highlight! link NeoTreeModified moonflyCustomYellow
    highlight! link NeoTreeRootName moonflyCustomPurple

    " Telescope plugin
    highlight! link TelescopeBorder moonflyCustomGrey236
    highlight! link TelescopeMatching moonflyCustomCoral
    highlight! link TelescopeMultiIcon moonflyCustomCrimson
    highlight! link TelescopeMultiSelection moonflyCustomEmerald
    highlight! link TelescopeNormal moonflyCustomGrey249
    highlight! link TelescopePreviewDate moonflyCustomGrey246
    highlight! link TelescopePreviewGroup moonflyCustomGrey246
    highlight! link TelescopePreviewLink moonflyCustomTurquoise
    highlight! link TelescopePreviewMatch moonflyCustomVisual
    highlight! link TelescopePreviewRead moonflyCustomOrange
    highlight! link TelescopePreviewSize moonflyCustomEmerald
    highlight! link TelescopePreviewUser moonflyCustomGrey246
    highlight! link TelescopePromptPrefix moonflyCustomBlue
    highlight! link TelescopeResultsDiffAdd moonflyCustomGreen
    highlight! link TelescopeResultsDiffChange moonflyCustomRed
    highlight! link TelescopeResultsDiffDelete moonflyCustomCrimsonLine
    highlight! link TelescopeResultsSpecialComment moonflyCustomGrey241
    highlight! link TelescopeSelectionCaret moonflyCustomCrimson
    highlight! link TelescopeTitle moonflyCustomGrey241
    exec 'highlight TelescopeSelection guibg=' . s:grey0 . ' guifg=' . s:grey254

    " gitsigns.nvim plugin
    highlight! link GitSignsAdd moonflyCustomEmeraldAlert
    highlight! link GitSignsAddLn moonflyCustomGreen
    highlight! link GitSignsAddPreview moonflyCustomEmeraldLine
    highlight! link GitSignsChange moonflyCustomYellowAlert
    highlight! link GitSignsChangeDelete moonflyCustomCoralAlert
    highlight! link GitSignsChangeLn moonflyCustomYellow
    highlight! link GitSignsChangeNr moonflyCustomYellowAlert
    highlight! link GitSignsDelete moonflyCustomRedAlert
    highlight! link GitSignsDeleteLn moonflyCustomRed
    highlight! link GitSignsDeletePreview moonflyCustomCrimsonLine
    highlight! link GitSignsDeleteVirtLn moonflyCustomCrimsonLine
    exec 'highlight GitSignsAddInline guibg=' . s:green . ' guifg=' . s:black
    exec 'highlight GitSignsChangeInline guibg=' . s:yellow . ' guifg=' . s:black
    exec 'highlight GitSignsDeleteInline guibg=' . s:red . ' guifg=' . s:black

    " Hop plugin
    highlight! link HopCursor IncSearch
    highlight! link HopNextKey moonflyCustomYellow
    highlight! link HopNextKey1 moonflyCustomBlue
    highlight! link HopNextKey2 moonflyCustomCrimson
    highlight! link HopUnmatched moonflyCustomGrey247

    " Barbar plugin
    highlight! link BufferCurrent moonflyCustomWhiteLineActive
    highlight! link BufferCurrentIndex moonflyCustomWhiteLineActive
    highlight! link BufferCurrentMod moonflyCustomYellowLineActive
    highlight! link BufferTabpages moonflyCustomBlueLine
    highlight! link BufferVisible moonflyCustomGrey246Line
    highlight! link BufferVisibleIndex moonflyCustomGrey246Line
    highlight! link BufferVisibleMod moonflyCustomYellowLine
    highlight! link BufferVisibleSign moonflyCustomGrey246Line
    exec 'highlight BufferCurrentSign guibg=' . s:grey238 . ' guifg=' . s:blue
    exec 'highlight BufferInactive guibg=' . s:grey236 . ' guifg=' . s:grey246
    exec 'highlight BufferInactiveMod guibg=' . s:grey236 . ' guifg=' . s:yellow
    exec 'highlight BufferInactiveSign guibg=' . s:grey236 . ' guifg=' . s:grey247

    " Bufferline plugin
    exec 'highlight BufferLineTabSelected guifg=' . s:blue
    exec 'highlight BufferLineIndicatorSelected guifg=' . s:blue

    " nvim-cmp plugin
    highlight! link CmpItemAbbrMatch moonflyCustomYellow
    highlight! link CmpItemAbbrMatchFuzzy moonflyCustomCoral
    highlight! link CmpItemKind moonflyCustomWhite
    highlight! link CmpItemKindClass moonflyCustomEmerald
    highlight! link CmpItemKindColor moonflyCustomTurquoise
    highlight! link CmpItemKindConstant moonflyCustomPurple
    highlight! link CmpItemKindConstructor moonflyCustomSky
    highlight! link CmpItemKindEnum moonflyCustomViolet
    highlight! link CmpItemKindEnumMember moonflyCustomTurquoise
    highlight! link CmpItemKindEvent moonflyCustomViolet
    highlight! link CmpItemKindField moonflyCustomTurquoise
    highlight! link CmpItemKindFile moonflyCustomBlue
    highlight! link CmpItemKindFolder moonflyCustomBlue
    highlight! link CmpItemKindFunction moonflyCustomSky
    highlight! link CmpItemKindInterface moonflyCustomEmerald
    highlight! link CmpItemKindKeyword moonflyCustomViolet
    highlight! link CmpItemKindMethod moonflyCustomSky
    highlight! link CmpItemKindModule moonflyCustomEmerald
    highlight! link CmpItemKindOperator moonflyCustomViolet
    highlight! link CmpItemKindProperty moonflyCustomTurquoise
    highlight! link CmpItemKindReference moonflyCustomTurquoise
    highlight! link CmpItemKindSnippet moonflyCustomGreen
    highlight! link CmpItemKindStruct moonflyCustomEmerald
    highlight! link CmpItemKindText moonflyCustomGrey249
    highlight! link CmpItemKindTypeParameter moonflyCustomEmerald
    highlight! link CmpItemKindUnit moonflyCustomTurquoise
    highlight! link CmpItemKindValue moonflyCustomTurquoise
    highlight! link CmpItemKindVariable moonflyCustomTurquoise
    highlight! link CmpItemMenu moonflyCustomGrey247

    " Indent Blankline plugin
    exec 'highlight IndentBlanklineChar guifg=' . s:grey235 . ' gui=nocombine'
    exec 'highlight IndentBlanklineSpaceChar guifg=' . s:grey235 . ' gui=nocombine'
    exec 'highlight IndentBlanklineSpaceCharBlankline guifg=' . s:grey235 . ' gui=nocombine'

    " Mini.nvim plugin
    highlight! link MiniCompletionActiveParameter moonflyCustomVisual
    highlight! link MiniCursorword moonflyCustomUnderline
    highlight! link MiniCursorwordCurrent moonflyCustomUnderline
    highlight! link MiniIndentscopePrefix moonflyCustomNoCombine
    highlight! link MiniIndentscopeSymbol moonflyCustomWhite
    highlight! link MiniJump SpellRare
    highlight! link MiniStarterCurrent moonflyCustomNoCombine
    highlight! link MiniStarterFooter Title
    highlight! link MiniStarterHeader moonflyCustomViolet
    highlight! link MiniStarterInactive Comment
    highlight! link MiniStarterItem Normal
    highlight! link MiniStarterItemBullet Delimiter
    highlight! link MiniStarterItemPrefix moonflyCustomYellow
    highlight! link MiniStarterQuery moonflyCustomSky
    highlight! link MiniStarterSection moonflyCustomCrimson
    highlight! link MiniStatuslineModeCommand moonflyCustomYellowMode
    highlight! link MiniStatuslineModeInsert moonflyCustomEmeraldMode
    highlight! link MiniStatuslineModeNormal moonflyCustomBlueMode
    highlight! link MiniStatuslineModeOther moonflyCustomTurquoiseMode
    highlight! link MiniStatuslineModeReplace moonflyCustomCrimsonMode
    highlight! link MiniStatuslineModeVisual moonflyCustomPurpleMode
    highlight! link MiniSurround IncSearch
    highlight! link MiniTablineCurrent moonflyCustomWhiteLineActive
    highlight! link MiniTablineFill TabLineFill
    highlight! link MiniTablineModifiedCurrent moonflyCustomYellowLineActive
    highlight! link MiniTablineModifiedVisible moonflyCustomYellowLine
    highlight! link MiniTablineTabpagesection moonflyCustomBlueMode
    highlight! link MiniTablineVisible moonflyCustomGrey246Line
    highlight! link MiniTestEmphasis moonflyCustomUnderline
    highlight! link MiniTestFail moonflyCustomRed
    highlight! link MiniTestPass moonflyCustomGreen
    highlight! link MiniTrailspace moonflyCustomCrimsonMode
    exec 'highlight MiniJump2dSpot guifg=' . s:yellow . ' gui=underline,nocombine'
    exec 'highlight MiniStatuslineDevinfo guibg=' . s:grey241 . ' guifg=' . s:white . ' gui=none'
    exec 'highlight MiniStatuslineFileinfo guibg=' . s:grey241 . ' guifg=' . s:white . ' gui=none'
    exec 'highlight MiniStatuslineFilename guibg=' . s:grey236 . ' guifg=' . s:grey247
    exec 'highlight MiniStatuslineInactive guibg=' . s:grey236   . ' guifg=' . s:grey247
    exec 'highlight MiniTablineHidden guibg=' . s:grey236 . ' guifg=' . s:grey246
    exec 'highlight MiniTablineModifiedHidden guibg=' . s:grey236 . ' guifg=' . s:yellow

    " Dashboard plugin
    highlight! link DashboardCenter moonflyCustomViolet
    highlight! link DashboardFooter moonflyCustomCoral
    highlight! link DashboardHeader moonflyCustomBlue
    highlight! link DashboardShortCut moonflyCustomTurquoise

    " nvim-notify
    highlight! link NotifyERRORBorder FloatBorder
    highlight! link NotifyWARNBorder FloatBorder
    highlight! link NotifyINFOBorder FloatBorder
    highlight! link NotifyDEBUGBorder FloatBorder
    highlight! link NotifyTRACEBorder FloatBorder
    highlight! link NotifyERRORIcon moonflyCustomRed
    highlight! link NotifyWARNIcon moonflyCustomYellow
    highlight! link NotifyINFOIcon moonflyCustomBlue
    highlight! link NotifyDEBUGIcon moonflyCustomGrey246
    highlight! link NotifyTRACEIcon moonflyCustomPurple
    highlight! link NotifyERRORTitle moonflyCustomRed
    highlight! link NotifyWARNTitle moonflyCustomYellow
    highlight! link NotifyINFOTitle moonflyCustomBlue
    highlight! link NotifyDEBUGTitle moonflyCustomGrey246
    highlight! link NotifyTRACETitle moonflyCustomPurple
endif

set background=dark
