local helpers = require('helpers/luasnip-helpers')
local get_visual = helpers.get_visual


return {
  -- Combining text and insert nodes to create basic LaTeX commands 
  s({trig="tt", dscr="Expands 'tt' into '\texttt{}'"},
    fmta("\\texttt{<>}",
    { i(1) }
    )
  ),
  s({trig="tss", dscr="Expands 'tss' into '\textsuperscript{}'"},
    fmta("\\textsuperscript{<>}",
    { i(1) }
    )
  ),
  s({trig="tdi", dscr="Expands 'tdi' into '\todo[inline]{}'"},
    fmta("\\todo[inline]{<>}",
    { i(1) }
    )
  ),
  s({trig="__", dscr="Expand subscript", snippetType="autosnippet"},
    fmta(
      [[_{<>}]],
      {
        d(1, get_visual);
      }
    )
  ),
  s({trig="^^", dscr="Expand superscript", snippetType="autosnippet"},
    fmta(
      [[^{<>}]],
      {
        d(1, get_visual);
      }
    )
  ),
  s({trig="eq", descr="A LaTeX equation environment"},
    fmt(
      [[
        \begin{equation*}
          <>
        \end{equation*}
      ]],
      { i(0) },
      { delimiters = "<>" }
    )
  ),
  s({trig = "([^%a])eq", wordTrig = false, regTrig = true},
    fmta(
      [[<>
        \begin{equation*}
          <>
        \end{equation*}
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(0),
      }
    )
  ),
  s({trig = "([^%a])ff", wordTrig = false, regTrig = true},
    fmta(
      [[<>\frac{<>}{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(1),
        i(2)
      }
    )
  ),
  s({trig="env"},
    fmta(
      [[
        \begin{<>}
          <>
        \end{<>}
      ]],
      {
        i(1),
        i(2),
        rep(1),
      }
    )
  ),
  s({trig="hr", descr="The hyperref package's href{}{} command (for url links)"},
    fmta(
      [[\href{<>}{<>}]],
      {
        i(1, "url"),
        i(2, "display name"),
      }
    )
  ),
  s({trig = "([^%a])mm", wordTrig = false, regTrig = true},
    fmta(
      "<>$<>$",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    )
  ),
  s({trig = "([^%a])ee", wordTrig = false, regTrig = true},
    fmta(
      "<>e^{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual)
      }
    )
  ),

}
