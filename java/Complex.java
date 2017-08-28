/*
 * Copyright (c) 2004 David Flanagan.  All rights reserved.
 * This code is from the book Java Examples in a Nutshell, 3nd Edition.
 * It is provided AS-IS, WITHOUT ANY WARRANTY either expressed or implied.
 * You may study, use, and modify it for any non-commercial purpose,
 * including teaching and use in open-source projects.
 * You may distribute it non-commercially as long as you retain this notice.
 * For a commercial use license, or to purchase the book, 
 * please visit http://www.davidflanagan.com/javaexamples3.
 */

// Modified; removed unneccesary code for this task.

public class Complex {
    public final double a, bi;

    public Complex(double a, double bi) {
        this.a = a;
        this.bi = bi;
    }

    public static double magnitude(Complex c) {
        return Math.sqrt(c.a * c.a + c.bi * c.bi);
    }

    public static Complex add(Complex fst, Complex snd) {
        return new Complex(fst.a + snd.a, fst.bi + snd.bi);
    }

    public static Complex multiply(Complex fst, Complex snd) {
        return new Complex(fst.a * snd.a - fst.bi * snd.bi, fst.a * snd.bi + fst.bi * snd.a);
    }
}