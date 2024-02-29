return {
  s({trig="nowordtrigger", descr="Generate a LuaSnip snippet that triggers on something if it isn't in a word"},
    fmta(
      [===[
        s({trig = "([^%a])<>", wordTrig = false, regTrig = true},
          fmta(
            [[<<>><>]],
            {
              f( function(_, snip) return snip.captures[1] end ),
              <>
            }
          )
        ),
      ]===],
      {
        i(1),
        i(2),
        i(3),
      }
    )
  ),
}
