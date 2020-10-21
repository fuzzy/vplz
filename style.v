module vplz

const (
	// colors enumeration
	black           = 0
	red             = 1
	green           = 2
	yellow          = 3
	blue            = 4
	magenta         = 5
	cyan            = 6
	white           = 7
	// character subset enumeration
	sp_top_right    = '┐' // Single Pipe: Top Right
	sp_top_left     = '┌' // Single Pipe: Top Left
	sp_bottom_right = '┘' // Single Pipe: Bottom Right
	sp_bottom_left  = '└' // Single Pipe: Bottom Left
	sp_sep_right    = '┤' // Single Pipe: Seperator Right
	sp_sep_left     = '├' // Single Pipe: Seperator Left
	sp_sep_top      = '┬' // Single Pipe: Seperator Top
	sp_sep_bottom   = '┴' // Single Pipe: Seperator Bottom
	sp_sep_center   = '┼' // Single Pipe: Seperator Center
	sp_horizontal   = '─' // Single Pipe: Horizontal
	sp_vertical     = '│' // Single Pipe: Vertical
	dp_top_right    = '╗' // Double Pipe: Top Right
	dp_top_left     = '╔' // Double Pipe: Top Left
	dp_bottom_right = '╝' // Double Pipe: Bottom Right
	dp_bottom_left  = '╚' // Double Pipe: Bottom Left
	dp_sep_right    = '╣' // Double Pipe: Seperator Right
	dp_sep_left     = '╠' // Double Pipe: Seperator Left
	dp_sep_top      = '╦' // Double Pipe: Seperator Top
	dp_sep_bottom   = '╩' // Double Pipe: Seperator Bottom
	dp_sep_center   = '╬' // Double Pipe: Seperator Center
	dp_horizontal   = '═' // Double Pipe: Horizontal
	dp_vertical     = '║' // Double Pipe: Vertical
)

struct ProgressBarStyle {
mut:
	working        int
	success        int
	failed         int
	top_left       string
	top_right      string
	top_sep        string
	side_left      string
	side_right     string
	side_sep_left  string
	side_sep_right string
	bottom_left    string
	bottom_right   string
	bottom_sep     string
	center_sep     string
	horizontal     string
	vertical       string
	progress       string
}
