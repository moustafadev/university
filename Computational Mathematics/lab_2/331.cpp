#include <iostream>
#include <cmath>
#include <iomanip>

using namespace std;

double f1(double x, double y, double z) {
    return 1 - y/6 + 5*z/12;
}

double f2(double x, double y, double z) {
    return -3/5 + 3*x/5 + z/10;
}

double f3(double x, double y, double z) {
    return 1/5 - x/5 + y/5;
}

void solve(double x0, double y0, double z0, double eps) {
    cout << "Метод простых итераций\n";
    cout << fixed << setprecision(4);
    cout << setw(2) << "k" << setw(10) << "X^k" << setw(10) << "X^(k+1)" << setw(15) << "|X^(k+1) - X^(k)|"
         << setw(10) << "Y^k" << setw(10) << "Y^(k+1)" << setw(15) << "|Y^(k+1) - Y^(k)|"
         << setw(10) << "Z^k" << setw(10) << "Z^(k+1)" << setw(15) << "|Z^(k+1) - Z^(k)|" << endl;
    int k = 0;
    double X_k = x0;
    double Y_k = y0;
    double Z_k = z0;
    double tmpX = 0;
    double tmpY = 0;
    double tmpZ = 0;
    double X_k_plus_1 = 0;
    double Y_k_plus_1 = 0;
    double Z_k_plus_1 = 0;
    bool do_while = true;
    while (do_while || (fabs(X_k_plus_1 - tmpX) > eps
                        || fabs(Y_k_plus_1 - tmpY) > eps
                        || fabs(Z_k_plus_1 - tmpZ) > eps)) {
        do_while = false;
        X_k_plus_1 = f1(X_k, Y_k, Z_k);
        Y_k_plus_1 = f2(X_k, Y_k, Z_k);
        Z_k_plus_1 = f3(X_k, Y_k, Z_k);
        cout << setw(2) << k << setw(10) << X_k << setw(10) << X_k_plus_1 << setw(15) << fabs(X_k_plus_1 - X_k)
             << setw(10) << Y_k << setw(10) << Y_k_plus_1 << setw(15) << fabs(Y_k_plus_1 - Y_k)
             << setw(10) << Z_k << setw(10) << Z_k_plus_1 << setw(15) << fabs(Z_k_plus_1 - Z_k) << endl;
        tmpX = X_k;
        tmpY = Y_k;
        tmpZ = Z_k;
        X_k = X_k_plus_1;
        Y_k = Y_k_plus_1;
        Z_k = Z_k_plus_1;
        k++;
    }
}

void _solve(double x0, double y0, double z0, double eps) {
    cout << "Метод Зейделя\n";
    cout << fixed << setprecision(4);
    cout << setw(2) << "k" << setw(10) << "X^k" << setw(10) << "X^(k+1)" << setw(15) << "|X^(k+1) - X^(k)|"
         << setw(10) << "Y^k" << setw(10) << "Y^(k+1)" << setw(15) << "|Y^(k+1) - Y^(k)|"
         << setw(10) << "Z^k" << setw(10) << "Z^(k+1)" << setw(15) << "|Z^(k+1) - Z^(k)|" << endl;
    int k = 0;
    double X_k = x0;
    double Y_k = y0;
    double Z_k = z0;
    double tmpX = 0;
    double tmpY = 0;
    double tmpZ = 0;
    double X_k_plus_1 = 0;
    double Y_k_plus_1 = 0;
    double Z_k_plus_1 = 0;
    bool do_while = true;
    while (do_while || (fabs(X_k_plus_1 - tmpX) > eps
                        || fabs(Y_k_plus_1 - tmpY) > eps
                        || fabs(Z_k_plus_1 - tmpZ) > eps)) {
        do_while = false;
        X_k_plus_1 = f1(X_k, Y_k, Z_k);
        Y_k_plus_1 = f2(X_k_plus_1, Y_k, Z_k);
        Z_k_plus_1 = f3(X_k_plus_1, Y_k_plus_1, Z_k);
        cout << setw(2) << k << setw(10) << X_k << setw(10) << X_k_plus_1 << setw(15) << fabs(X_k_plus_1 - X_k)
             << setw(10) << Y_k << setw(10) << Y_k_plus_1 << setw(15) << fabs(Y_k_plus_1 - Y_k)
             << setw(10) << Z_k << setw(10) << Z_k_plus_1 << setw(15) << fabs(Z_k_plus_1 - Z_k) << endl;
        tmpX = X_k;
        tmpY = Y_k;
        tmpZ = Z_k;
        X_k = X_k_plus_1;
        Y_k = Y_k_plus_1;
        Z_k = Z_k_plus_1;
        k++;
    }
}

int main() {
    double x0 = 1;
    double y0 = -3/5;
    double z0 = 1/5;
    double eps = 0.001;
    solve(x0, y0, z0, eps);
    _solve(x0, y0, z0, eps);
    return 0;
}