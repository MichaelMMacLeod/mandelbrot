fn main() {
    let mut a = -2.0;
    let mut bi = -2.0;
    let incr = 0.1;
    println!("");
    while a < 2.0 {
        while bi < 2.0 {
            if time(0.0, 0.0, a, bi, 100) < 50 {
                print!("#");
            } else {
                print!(":");
            }
            bi += incr;
        }
        println!("");
        bi = -2.0;
        a += incr;
    }
}

fn time(mut a: f32, mut b: f32, cx: f32, cy: f32, m: i32) -> i32 {
    for n in 0..m {
        if (a * a + b * b).sqrt() >= 2.0 {
            return n;
        }
        let a_new = a * a - b * b + cx;
        b = 2.0 * a * b + cy;
        a = a_new;
    }
    m
}
