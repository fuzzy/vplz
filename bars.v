module vplz

import term

struct ProgressBars {
mut:
	title    string
	seperate bool
	end      bool
	color    bool
	length   int
	style    &ProgressBarStyle
	bars     map[string]ProgressBar
	rows     int
	cols     int
}

pub fn new_progressbars(len int, title string, sepr bool, color bool, sty &ProgressBarStyle) &ProgressBars {
	mut retv := &ProgressBars{
		end: false
		seperate: sepr
		title: title
		color: color
		length: len
		style: sty
		bars: map[string]ProgressBar{}
	}
	retv.update_term_size()
	return retv
}

// ProgressBars Methods
pub fn (mut bars ProgressBars) add_bar(title string) ?bool {
	bars.bars[title] = new_progressbar(0, title, bars.color, bars.style)
	return true
}

pub fn (bars ProgressBars) start() {
	bars.print_header()
	bars.print_footer()
}

fn (bars ProgressBars) print_header() {
	mut fill := ''
	if bars.title.len == 0 {
		fill = filler(bars.style.horizontal, (bars.cols - 2))
	} else {
		mut filt := []string{}
		filt << filler(bars.style.horizontal, 2)
		filt << '[ $bars.title ]'
		filt << filler(bars.style.horizontal, (bars.cols - (8 + bars.title.len)))
		fill = filt.join('')
	}
	println('$bars.style.top_left$fill$bars.style.top_right')
}

fn (bars ProgressBars) print_footer() {
	fill := filler(bars.style.horizontal, (bars.cols - 2))
	println('$bars.style.bottom_left$fill$bars.style.bottom_right')
}

pub fn (mut bars ProgressBars) update_term_size() ?bool {
	bars.cols, bars.rows = term.get_terminal_size()
}
