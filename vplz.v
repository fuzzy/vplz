module vplz

#include "sys/ioctl.h"

struct C.winsize{
  ws_row int
  ws_col int
}

fn C.ioctl(fd int, rq u32, itm voidptr)

struct Terminal {
mut:
  yellow string = '\033[1;33m'
  green  string = '\033[1;32m'
  red    string = '\033[1;31m'
  reset  string = '\033[0m'
  progs  string
  progr  f64
  end    bool
pub:
  ltcap  string = '╔'
  lscap  string = '╠'
  xscap  string = '═'
  lbcap  string = '╚'
  fillr  string = '═'
pub mut:
  rows   int
  cols   int
}

pub fn plain_terminal() Terminal {
  mut ts := &C.winsize{}
  C.ioctl(0, 21523, ts)
  return Terminal{
    yellow: '\033[1;43m',
    green:  '\033[1;42m',
    red:    '\033[1;41m',
    ltcap:  ' ',
    lscap:  ' ',
    lbcap:  ' ',
    xscap:  ' ',
    fillr:  ' ',
    rows:   ts.ws_row,
    cols:   ts.ws_col
  }
}

pub fn new_terminal() Terminal {
  mut ts := &C.winsize{}
  C.ioctl(0, 21523, ts)
  return Terminal{rows: ts.ws_row, cols: ts.ws_col}
}

fn (mut t Terminal) filler(l int) string {
  mut filler := []string{}
  for a := 0; a <= l; a++ {
    filler << t.fillr
  }
  return filler.join('')
}

fn (mut t Terminal) pad(pad int) string {
  mut pada := []string{}
  for a := 0; a <= pad; a++ {
    pada << ' '
  }
  return pada.join('')
}

pub fn (mut t Terminal) header() {
  println('${t.ltcap}${t.filler(t.cols - 3)}')
}

pub fn (mut t Terminal) footer() {
  println('${t.lbcap}${t.filler(t.cols - 3)}')
}

pub fn (mut t Terminal) label(s string) {
  println('${t.lscap}${t.xscap} ${s}')
}

pub fn (mut t Terminal) progress(s string, p f64, end, fail bool) {
  bspc := (t.cols / 2)
  bart := (p * bspc)
  perc := int(p * 100)
  bits := t.filler(int(bart))
  padt := (bspc - (s.len + 12))

  mut bars := string{}
  mut etag := string{}
  mut pads := 0

  /* cache some data for later usage during update() */
  t.progs = s
  t.progr = p
  t.end = end

  if !end && !fail {
    bars = t.yellow+bits+t.reset
  } else if end && !fail {
    bars = t.green+bits+t.reset
  } else if end && fail {
    bars = t.red+bits+t.reset
  }

  if end {
    etag = '\n'
  } else {
    etag = '\r'
  }

  if perc < 10 {
    pads = padt+2
  } else if perc >= 10 && perc < 100 {
    pads = padt+1
  } else {
    pads = padt
  }

  print('${t.lscap}${t.xscap} ${s} ${t.pad(pads)} ${perc}% ${bars}${etag}')
}

pub fn (mut t Terminal) update(pp f64, fail bool) {
  t.progress(t.progs, pp, t.end, fail)
}


