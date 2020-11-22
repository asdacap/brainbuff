#[allow(unused_imports)]
use std::cmp::{min,max};
use std::io::{BufWriter, stdin, stdout, Write};
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
    for i in (0..t) {
        let answer = solve(&mut scanner);

        writeln!(out, "Case #{}: {}", i+1, answer).ok();
    }
}
    
fn solve(scanner: &mut Scanner) -> i64 {
    let n: usize = scanner.next();
    let k: i64 = scanner.next();

    let xsi: Vec<i64> = (0..n).map(|_| scanner.next()).collect();
    let xs: Vec<i64> = (0..(n-1)).map(|i| xsi[i+1] - xsi[i]).collect();

    let mut lowd = 1; // exclusive
    let mut maxd = *xs.iter().max().unwrap();

    while maxd > lowd {
        let midd = (maxd+lowd)/2;
        if can(&xs, k, midd) {
            maxd = midd;
        } else {
            lowd = midd+1;
        }
    }

    return maxd;
}

fn can(xs: &[i64], k: i64, d: i64) -> bool {
    let mut kleft = k;
    
    for x in xs.iter() {
        let kneed = ((*x as f64)/(d as f64)).ceil() as i64;
        kleft = kleft - (kneed-1);
    }

    kleft >= 0
}
