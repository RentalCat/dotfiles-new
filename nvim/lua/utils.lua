-- ディレクトリ関係 --------------------------------------------------------------------------- {{{
function getNvimDir()
    return vim.fn.stdpath('config')
end

function getNvimTmpDir()
    return getNvimDir + '/.'
end
-- }}}
