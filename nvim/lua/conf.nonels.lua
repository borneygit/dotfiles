-- vim: foldmethod=marker foldenable
-- vim: tabstop=2 softtabstop=2 shiftwidth=2

local null_ls = require('null-ls')

function python_null_ls_condition(params)
  -- Don't run diagnostics stuff on these files: system and 3rd-party libraries.
  return not (
    params.bufname:match('site-packages')
    or params.bufname:match('.pyenv')
    or params.bufname:match('Python.framework')
  )
end

function clang_null_ls_condition(params)
  -- Skip to let clang to work for MacOSX system or vcpkg libraries, which are huge and may slow-down nvim.
  return not (params.bufname:match('MacOSX.sdk') or params.bufname:match('Toolchains') or params.bufname:match('vcpkg'))
end

null_ls.setup({
  -- add your sources / config options here
  sources = {
    -- Python
    null_ls.builtins.diagnostics.mypy.with({
      extra_args = { '--follow-imports', 'silent' },
      prefer_local = '~/.pyenv/shims',
      runtime_condition = python_null_ls_condition,
      -- mypy runs slowly, we use it on-save instead of on-change.
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    }),
    -- C/C++/CSharp
    null_ls.builtins.formatting.clang_format.with({
      filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'proto', 'cs' },
      runtime_condition = clang_null_ls_condition,
    }),
    -- Golang
    null_ls.builtins.formatting.gofmt,
    -- Rust
    require('none-ls.formatting.rustfmt'),
    -- Swift
    null_ls.builtins.formatting.swift_format,
    -- Dart
    null_ls.builtins.formatting.dart_format,
    -- Js/Ts
    require('none-ls.formatting.eslint_d').with({ prefer_local = 'node_modules/.bin' }),
    null_ls.builtins.formatting.prettier.with({
      prefer_local = 'node_modules/.bin',
      filetypes = { 'javascript', 'typescript', 'typescriptreact', 'css' },
    }),
    -- CMake
    null_ls.builtins.formatting.cmake_format,
    -- Lua
    null_ls.builtins.formatting.stylua.with({
      extra_args = { '--indent-type', 'spaces', '--indent-width', '2', '--quote-style', 'AutoPreferSingle' },
    }),
  },
  debug = false,
})
