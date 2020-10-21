module vplz

// Utility functions
fn filler(c string, s int) string {
	mut retv := []string{}
	for i := 0; i < s; i++ {
		retv << c
	}
	return retv.join('')
}

