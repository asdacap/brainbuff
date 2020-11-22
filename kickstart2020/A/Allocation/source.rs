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
    let n: i64 = scanner.next();
    let b: i64 = scanner.next();

    let mut xs: Vec<i64> = (0..n).map(|_| scanner.next()).collect();
    xs.sort();

    let mut count = 0;
    let mut total = 0;

    for x in xs.iter() {
        if (total + x > b) {
            break;
        }

        total = total + x;
        count = count + 1;
    }

    return count;
}
