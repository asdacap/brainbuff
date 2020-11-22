#[allow(unused_imports)]
use std::cmp::{min,max};
use std::io::{BufWriter, stdin, stdout, Write};
use std::borrow::{BorrowMut};
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
    let mut tree: Tree = Tree::newNode();

    for _ in (0..n) {
        let text: String = scanner.next();
        let chars: Vec<char> = text.chars().collect();
        tree.append(&chars);
    }

    let (_, score) = tree.calculate(0, k);
    return score;
}

struct Tree{
    subtree: Vec<Option<Box<Tree>>>,
    leaves: i64,
}

impl Tree {
    fn newNode() -> Tree {
        Tree {
            subtree: (0..26).map(|_| None).collect(),
            leaves: 0,
        }
    }

    fn calculate(&self, multiplier: i64, k: i64) -> (i64, i64) {
        let (subremainder,subscore): (Vec<i64>, Vec<i64>) = self.subtree.iter().flatten()
            .map(|subtree| subtree.calculate(multiplier+1, k))
            .unzip();

        let mut remainder = subremainder.iter().sum::<i64>() + self.leaves;
        let mut score = subscore.iter().sum::<i64>();

        let div = remainder/k;
        let remainder = remainder - (div*k);
        let score = score + div*multiplier;
        return (remainder, score);
    }

    fn append(&mut self, text: &[char]) {
        if text.len() == 0 {
            self.leaves = self.leaves+1;
        } else {
            let idx: usize = (text[0] as u8 - 'A' as u8).into();
            if self.subtree[idx].is_none() {
                self.subtree[idx] = Some(Box::new(Tree::newNode()));
            }
            self.subtree[idx].as_mut().unwrap().append(&text[1..]);
        }
    }
}
