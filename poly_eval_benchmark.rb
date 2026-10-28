# frozen_string_literal: true

require 'benchmark/ips'

def poly_eval(cs, x)
  acc = 0r
  cs.each_with_index { |c, p| acc += c * x**p }
  acc
end

def poly_eval_horner(cs, x)
  acc = 0r
  cs.reverse_each { |c| acc = acc * x + c }
  acc
end

Benchmark.ips do |bm|
  bm.config(warmup: 5, time: 10)

  cs = [7/6r, -2/5r, 0r, 1/3r]
  x = 1/2r

  bm.report('poly_eval') { poly_eval(cs, x) }
  bm.report('poly_eval_horner') { poly_eval_horner(cs, x) }

  bm.compare!
end
