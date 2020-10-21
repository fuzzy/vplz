module vplz

import term

struct ProgressBar {
mut:
	title  string
	end    bool
	color  bool
	length int
	style  &ProgressBarStyle
	rows   int
	cols   int
}

pub fn new_progressbar(len int, title string, color bool, sty &ProgressBarStyle) &ProgressBar {
	return &ProgressBar{
		title: title
		end: false
		color: color
		length: len
		style: sty
	}
}

pub fn simple_progressbar(t string) &ProgressBar {
	return new_progressbar(0, t, false, &ProgressBarStyle{
		working: yellow
		success: green
		failed: red
		progress: '#'
	})
}

pub fn (mut bar ProgressBar) update_term_size() ?bool {
	bar.cols, bar.rows = term.get_terminal_size()
}
