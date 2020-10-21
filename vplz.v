/*
* Author: Mike 'Fuzzy' Partin
 * This code is released under the Copyfree Open Innovation License
 * You should find a copy of the license in the LICENSE.md file accompanying
 * this source code.
*/
module vplz

import term

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
}

struct ProgressBar {
mut:
	end    bool
	length int
	style  &ProgressBarStyle
}

pub fn new_progressbar(len int, sty &ProgressBarStyle) &ProgressBar {
	return &ProgressBar{
		end: false
		length: len
		style: sty
	}
}

pub fn double_fancy_progressbar() &ProgressBar {
	return new_progressbar(0, &ProgressBarStyle{
		working: yellow
		success: green
		failed: red
		top_left: dp_top_left
		top_right: dp_top_right
		top_sep: dp_sep_top
		side_left: dp_vertical
		side_right: dp_vertical
		side_sep_left: dp_sep_left
		side_sep_right: dp_sep_right
		bottom_left: dp_bottom_left
		bottom_right: dp_bottom_right
		bottom_sep: dp_sep_bottom
		center_sep: dp_sep_center
	})
}

pub fn single_fancy_progressbar() &ProgressBar {
	return new_progressbar(0, &ProgressBarStyle{
		working: yellow
		success: green
		failed: red
		top_left: sp_top_left
		top_right: sp_top_right
		top_sep: sp_sep_top
		side_left: sp_vertical
		side_right: sp_vertical
		side_sep_left: sp_sep_left
		side_sep_right: sp_sep_right
		bottom_left: sp_bottom_left
		bottom_right: sp_bottom_right
		bottom_sep: sp_sep_bottom
		center_sep: sp_sep_center
	})
}

// ///////////////////////// OLD SOON TO BE DEPRECATED CODE
struct Bar {
mut:
	progs  string
	progr  f64
	end    bool
pub mut:
	yellow string = '\033[1;33m'
	green  string = '\033[1;32m'
	red    string = '\033[1;31m'
	reset  string = '\033[0m'
	ltcap  string = '╔'
	lscap  string = '╠'
	xscap  string = '═'
	lbcap  string = '╚'
	fillr  string = '═'
	rows   int
	cols   int
}

struct MultiBar {
}

pub fn simple_terminal() Bar {
	mut retv := Bar{
		ltcap: ' '
		lscap: ' '
		lbcap: ' '
		xscap: ' '
		fillr: ' '
	}
	retv.update_termsize()
	return retv
}

pub fn muti_bar() MultiBar {
	return MultiBar{}
}

pub fn new_terminal() Bar {
	mut retv := Bar{}
	retv.update_termsize()
	return retv
}

fn (mut t Bar) filler(l int) string {
	mut filler := []string{}
	for a := 0; a <= l; a++ {
		filler << t.fillr
	}
	return filler.join('')
}

fn (mut t Bar) pad(pad int) string {
	mut pada := []string{}
	for a := 0; a <= pad; a++ {
		pada << ' '
	}
	return pada.join('')
}

pub fn (mut t Bar) update_termsize() {
	t.cols, t.rows = term.get_terminal_size()
}

pub fn (mut t Bar) header() {
	println('$t.ltcap${t.filler(t.cols - 3)}')
}

pub fn (mut t Bar) footer() {
	println('$t.lbcap${t.filler(t.cols - 3)}')
}

pub fn (mut t Bar) label(s string) {
	println('$t.lscap$t.xscap $s')
}

pub fn (mut t Bar) progress(s string, p f64, end bool, fail bool) {
	bspc := (t.cols / 2)
	bart := (p * bspc)
	perc := int(p * 100)
	bits := t.filler(int(bart))
	padt := (bspc - (s.len + 12))
	mut bars := string{}
	mut etag := string{}
	mut pads := 0 // cache some data for later usage during update()
	t.progs = s
	t.progr = p
	t.end = end
	if !end && !fail {
		bars = t.yellow + bits + t.reset
	} else if end && !fail {
		bars = t.green + bits + t.reset
	} else if end && fail {
		bars = t.red + bits + t.reset
	}
	if end {
		etag = '\n'
	} else {
		etag = '\r'
	}
	if perc < 10 {
		pads = padt + 2
	} else if perc >= 10 && perc < 100 {
		pads = padt + 1
	} else {
		pads = padt
	}
	print('$t.lscap$t.xscap $s ${t.pad(pads)} $perc% $bars$etag')
}

pub fn (mut t Bar) update(pp f64, fail bool) {
	t.progress(t.progs, pp, t.end, fail)
}
