-- This is the `get_visual` function I've been talking about.
-- ----------------------------------------------------------------------------
-- Summary: When `LS_SELECT_RAW` is populated with a visual selection, the function
-- returns an insert node whose initial text is set to the visual selection.
-- When `LS_SELECT_RAW` is empty, the function simply returns an empty insert node.
local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end
-- ----------------------------------------------------------------------------

return {
  -- Combining text and insert nodes to create basic LaTeX commands 
  s({trig="tt", dscr="Expands 'tt' into '\texttt{}'"},
    fmta("\\texttt{<>}",
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
