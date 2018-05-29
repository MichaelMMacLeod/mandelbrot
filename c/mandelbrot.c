#include <stdio.h>
#include <math.h>

int time(double a, double b, double cx, double cy, int m) {
    for (int n = 0; n < m; ++n) {
        if (sqrt(a * a + b * b) >= 2.0) {
            return n;
        }
        double a_new = a * a - b * b + cx;
        b = 2.0 * a * b + cy;
        a = a_new;
    }
    return m;
}

char toChar(int n) {
    char *shading = "$@B%8&WM#*|1?-+~i!I:,'. ";
    return shading[sizeof(char) * (n % 24)];
}

int main() {
    for (double bi = -2.0; bi < 2.0; bi = bi + 0.05) {
        for (double a = -2.0; a < 2.0; a = a + 0.05) {
            printf("%c", toChar(time(0.0, 0.0, a, bi, 100)));
        }
        printf("\n");
    }
}
