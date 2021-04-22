BEGIN {
	RS = "\033[[0-9;]+m|\n";
  FS = "\t";
	FG_COLORS[30] = "Black"
	FG_COLORS[31] = "Red"
	FG_COLORS[32] = "Green"
	FG_COLORS[33] = "Yellow"
	FG_COLORS[34] = "Blue"
	FG_COLORS[35] = "Magenta"
	FG_COLORS[36] = "Cyan"
	FG_COLORS[37] = "White"
	BG_COLORS[40] = "Black"
	BG_COLORS[41] = "Red"
	BG_COLORS[42] = "Green"
	BG_COLORS[43] = "Yellow"
	BG_COLORS[44] = "Blue"
	BG_COLORS[45] = "Magenta"
	BG_COLORS[46] = "Cyan"
	BG_COLORS[47] = "White"
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
        last_fg = sprintf("foreground='%s' ", FG_COLORS[code])
      }
      if (code in BG_COLORS) {
        last_bg = sprintf("background='%s'", BG_COLORS[code])
      }
    }
  }
}
END {
  print ""
}
