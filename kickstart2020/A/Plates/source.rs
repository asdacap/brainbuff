#[allow(unused_imports)]
use std::cmp::{min,max};
use std::io::{BufWriter, stdin, stdout, Write};
use std::iter::{repeat};
const INF: i64 = 0x3f3f3f3f;
 
#[derive(Default)]
struct Scanner {
    buffer: Vec<String>
}
impl Scanner {
    fn next<T: std::str::FromStr>(&mut self) -> T {
        loop {
            if let Some(token) = self.buffer.pop() {
                return token.parse().ok().expect("Failed parse");
            }
            let mut input = String::new();
            stdin().read_line(&mut input).expect("Failed read");
            self.buffer = input.split_whitespace().rev().map(String::from).collect();
        }
    }
}

fn main() {
    let mut scanner = Scanner::default();
    let out = &mut BufWriter::new(stdout());
    
    let t: i64 = scanner.next();
    for i in 0..t {
        let answer = solve(&mut scanner);

        writeln!(out, "Case #{}: {}", i+1, answer).ok();
    }
}
    
fn solve(scanner: &mut Scanner) -> i64 {
    let n: usize = scanner.next();
    let pn: usize = scanner.next();
    let max_w: usize = scanner.next();

    let mut xs: Vec<Vec<i64>> = (0..n).map(|_| {
        (0..pn).map(|_| scanner.next()).collect()
    }).collect();

    for i1 in 0..n {
        for i2 in 1..pn {
            xs[i1][i2] = xs[i1][i2] + xs[i1][i2-1];
        }
    }

    let mut dp: Vec<Vec<i64>> = vec![vec![0; max_w+1]; n];

    for i1 in 0..n {
        for (w_i, cur_v_ref) in xs[i1].iter().enumerate() {
            let cur_v = *cur_v_ref; 
            let cur_w = w_i+1;
            for i2 in 0..(max_w+1) {
                if i2 == cur_w {
                    dp[i1][i2] = max(dp[i1][i2], cur_v);
                }
                if i1 > 0 && i2 >= cur_w {
                    dp[i1][i2] = max(dp[i1][i2], dp[i1-1][i2]);
                    dp[i1][i2] = max(dp[i1][i2], dp[i1-1][i2-cur_w] + cur_v);
                }
            }
        }
    }

    return dp[n-1][max_w];
}
