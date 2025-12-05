use z3::ast::{Bool, Int};
use z3::Optimize;

fn main() {
    let opt = Optimize::new();
    let accelerators: [[Bool; 9]; 9] = std::array::from_fn(|_|std::array::from_fn(|_|Bool::fresh_const("a")));
    let accelerated: [[Bool; 9]; 9] = std::array::from_fn(|_|std::array::from_fn(|_|Bool::fresh_const("b")));
    let mut sum = Int::from_u64(0);

    for i in 0..9 {
        for j in 0..9 {
            let mut neigh = Bool::from_bool(false);
            if i > 0 {
                neigh |= &accelerators[i - 1][j];
            }
            if i < 8 {
                neigh |= &accelerators[i + 1][j];
            }
            if j > 0 {
                neigh |= &accelerators[i][j - 1];
            }
            if j < 8 {
                neigh |= &accelerators[i][j + 1]
            }
            opt.assert(&accelerated[i][j].eq(neigh & !&accelerators[i][j]));
            sum += Bool::ite(&accelerated[i][j], &Int::from_u64(1), &Int::from_u64(0));
        }
    }

    opt.maximize(&sum);
    println!("Problem status: {:?}", opt.check(&[]));
    let m = opt.get_model().unwrap();

    let sum = m.eval(&sum, false).unwrap();
    println!("Accelerated {} blocks", sum);

    println!("Legend: O: accelerator, .: accelerated cell, x: unaccelerated cell");
    for i in 0..9 {
        for j in 0..9 {
            let a = m.eval(&accelerators[i][j], true).unwrap().as_bool().unwrap();
            let b = m.eval(&accelerated[i][j], true).unwrap().as_bool().unwrap();
            if a {
                print!("O ");
            } else if b {
                print!(". ");
            } else {
                print!("x ")
            }
        }
        println!();
    }
}
