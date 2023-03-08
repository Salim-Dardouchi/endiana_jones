module main

import os

fn check_valid_chars(s string) bool {
	valid := r'0123456789abcdefABCDEF\x'
	return s.contains_only(valid)
}

fn le2str(s string) string {
	if s.len % 2 != 0 {
		return 'Length has to be even..'
	}
	else if check_valid_chars(s) == false {
		return 'Invalid character inside hex string..'
	}

	mut alpha_bytes := []string{}

	is_escaped := if s.contains(r'\x') { true } else { false }
	s_scan := if s.starts_with(r'0x' ) { s[2..] } else { s }

	len := s_scan.len

	mut parse_chars := false
	for i := 0; i < len; i += 2  {
		if is_escaped == false || parse_chars == true {
			alpha_bytes << s_scan[i .. i + 2]
		}
		parse_chars = !parse_chars
	}

	alpha_bytes = alpha_bytes.reverse()
	mut str := ''

	for b in alpha_bytes {
		val := b.parse_uint(16, 8) or { 0 }
		str += u8(val).ascii_str()
	}

	return str
}

fn main() {
	for i, arg in os.args {
		if i != 0 { println('Arg[${i}]: ${le2str(arg)}') }
	}
}
