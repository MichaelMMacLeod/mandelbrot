class Mandelbrot {
    private static final char[] chars = "$@B%8&WM#*|1?-_+~i!I:,'. ".toCharArray();

    public static void main(String[] args) {
        for (double a = -2; a <= 2; a += 0.05) {
            for (double bi = -2; bi <= 2; bi += 0.05) {
                Complex c = new Complex(a, bi);
                int m = mandelbrot(new Complex(0, 0), c, 0, 1000);
                System.out.print(getChar(m));
            }
            System.out.println();
        }
    }

    private static char getChar(int i) {
        return chars[i % 25];
    }

    private static int mandelbrot(Complex z, Complex c, int n, int m) {
        if (Complex.magnitude(z) >= 2 || n == m) {
            return n;
        } else {
            return mandelbrot(
                Complex.add(Complex.multiply(z, z), c), 
                c,
                n + 1, 
                m);
        }
    }
}