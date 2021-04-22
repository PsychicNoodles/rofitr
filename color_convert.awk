BEGIN {
  # ansi color code escape sequence
	RS = "\033[[0-9;]+m|\n";
  FS = "\t";
  # ansi color code values
	FG_COLORS[30] = "black"
	FG_COLORS[31] = "red"
	FG_COLORS[32] = "green"
	FG_COLORS[33] = "yellow"
	FG_COLORS[34] = "blue"
	FG_COLORS[35] = "magenta"
	FG_COLORS[36] = "cyan"
	FG_COLORS[37] = "white"
	BG_COLORS[40] = "black"
	BG_COLORS[41] = "red"
	BG_COLORS[42] = "green"
	BG_COLORS[43] = "yellow"
	BG_COLORS[44] = "blue"
	BG_COLORS[45] = "magenta"
	BG_COLORS[46] = "cyan"
	BG_COLORS[47] = "white"
  # custom values for ansi colors
  COLORS["black"] = "black"
  COLORS["red"] = "red"
  COLORS["green"] = "green"
  COLORS["yellow"] = "yellow"
  COLORS["blue"] = "blue"
  COLORS["magenta"] = "magenta"
  COLORS["cyan"] = "cyan"
  COLORS["white"] = "white"
}
{
  # trim whitespace
  sub(/(^ )|( $)/, "", $1)
  if (RT == "\n") {
    print ""
  } else {
    if ($1 != "") {
      printf "<span %s%s%s>%s</span> ", bold, last_fg, last_bg, $1
    }
    
    bold = ""
    split(substr(RT, 3, length(RT) - 3), codes, ";")
    for (i in codes) {
      code = codes[i]
      if (code == "1") {
        bold = "weight='bold' "
      }
      if (code == "0") {
        last_fg = ""
        last_bg = ""
        bold = ""
      }
      if (code in FG_COLORS) {
        last_fg = sprintf("foreground='%s' ", COLORS[FG_COLORS[code]])
      }
      if (code in BG_COLORS) {
        last_bg = sprintf("background='%s'", COLORS[BG_COLORS[code]])
      }
    }
  }
}
END {
  print ""
}
