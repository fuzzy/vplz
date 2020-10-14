# Vplz example usage

```v
module main

import time
import vplz

fn test(mut t vplz.Terminal) {
  t.header()
	t.label('Hello World!')

  mut pr := 0.1
  t.progress('Test prompt', 0.001, false, false)
  for i := 0; i <= 12; i++ {
    pr = (pr + 0.06)
    t.update(pr, false)
    time.sleep_ms(200)
  }
  t.progress('Test prompt', 1.0, true, false)

  pr = 0.1
  t.progress('Longer test prompt', 0.001, false, false)
  for i := 0; i <= 12; i++ {
    pr = (pr + 0.06)
    t.update(pr, false)
    time.sleep_ms(200)
  }
  t.progress('Longer test prompt', 1.0, true, false)

  pr = 0.1
  t.progress('Even longer test prompt', 0.001, false, false)
  for i := 0; i <= 12; i++ {
    pr = (pr + 0.06)
    t.update(pr, false)
    time.sleep_ms(200)
  }
  t.progress('Even longer test prompt', 0.99, true, true)


  t.label('Complete')
  t.footer()
}

fn main() {
  mut t := vplz.plain_terminal()
  test(mut t)
  mut t2 := vplz.new_terminal()
  test(mut t2)
}
```
