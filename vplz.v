/*
* Author: Mike 'Fuzzy' Partin
 * This code is released under the Copyfree Open Innovation License
 * You should find a copy of the license in the LICENSE.md file accompanying
 * this source code.
*/
module vplz

pub fn double_fancy_progressbar(t string, s bool) &ProgressBars {
	return new_progressbars(0, t, s, true, &ProgressBarStyle{
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
		vertical: dp_vertical
		horizontal: dp_horizontal
		progress: dp_horizontal
	})
}

pub fn single_fancy_progressbar(t string, s bool) &ProgressBars {
	return new_progressbars(0, t, s, true, &ProgressBarStyle{
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
		vertical: sp_vertical
		horizontal: sp_horizontal
		progress: dp_horizontal
	})
}

/*
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
*/
