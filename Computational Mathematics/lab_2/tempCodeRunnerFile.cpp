#include <iostream>
#include <iomanip> 
#include <cmath> 

using namespace std;

// Функции для метода простых итераций
double G1(double y, double z)
{
    return (y*5.0/54.0+z*5.0/54.0+1);
}

double G2(double x, double z)
{
    return (1.0/5.0-1.0/5.0*x-1.0/16*z);
}

double G3(double x, double y)
{
    return (2.0/5.0*y+2.0/5.0*x+2.0/5.0);
}
void simpleIteration(double eps) 
{
    // Начальные приближения
    double x = 0, y = 0, z = 0;
    double x_prev = 0, y_prev = 0, z_prev = 0;
    int iter = 0;

    // Метод простых итераций
    cout << "Метод простых итераций: " << endl;
    cout << " | " << setw(3) << "k" << " | "

        << setw(10) << "x^k" << " | "

        << setw(10) << "x^(k+1)" << " | "

        << setw(20) << "|x^(k+1) - x^k|" << " | "

        << setw(10) << "y^k" << " | "

        << setw(10) << "y^(k+1)" << " | "

        << setw(20) << "|y^(k+1) - y^k|" << " | "

        << setw(10) << "z^k" << " | "

        << setw(10) << "z^(k+1)" << " | "

        << setw(20) << "|z^(k+1) - z^k|" << " | " << endl;

    do
    {
        x_prev = x;
        y_prev = y;
        z_prev = z;

        x = G1(y_prev, z_prev);
        y = G2(x_prev, z_prev);
        z = G3(x_prev, y_prev);

        iter++;
        cout << " | " << setw(3) << iter << " | " << setw(10) << setprecision(5) << x_prev << " | "

            << setw(10) << setprecision(5) << x << " | " 
            
            << setw(20) << setprecision(10) << abs(x - x_prev) << " | "

            << setw(10) << setprecision(5) << y_prev << " | " << setw(10) << setprecision(5) << y << " | "

            << setw(20) << setprecision(10) << abs(y - y_prev) << " | "

            << setw(10) << setprecision(5) << z_prev << " | " << setw(10) << setprecision(5) << z << " | "

            << setw(20) << setprecision(10) << abs(z - z_prev) << " | " << endl;

    } while ((abs(x - x_prev) >= eps) || (abs(y - y_prev) >= eps) || (abs(z - z_prev) >= eps));

}

void seidel(double eps) 
{
    double xk = 0, yk = 0, zk = 0;
    double xk1 = 0,yk1 = 0,zk1 = 0;
    int k = 0;

    cout << "Метод Зейделя: " << endl;
    cout << " | " << setw(3) << "k" << " | "

        << setw(10) << "x^k" << " | "

        << setw(10) << "x^(k+1)" << " | "

        << setw(20) << "|x^(k+1) - x^k|" << " | "

        << setw(10) << "y^k" << " | "

        << setw(10) << "y^(k+1)" << " | "

        << setw(20) << "|y^(k+1) - y^k|" << " | "

        << setw(10) << "z^k" << " | "

        << setw(10) << "z^(k+1)" << " | "

        << setw(20) << "|z^(k+1) - z^k|" << " | " << endl;

    do {
        xk = xk1;
        yk = yk1;
        zk = zk1;

        xk1 = G1(yk, zk);
        yk1 = G2(xk1, zk);
        zk1 = G3(xk1, yk1);

        k++;

        cout << " | " << setw(3) << k << " | " << setw(10) << setprecision(5) << xk << " | "

            << setw(10) << setprecision(5) << xk1 << " | " << setw(15) << setprecision(15) << abs(xk1 - xk) << " | "

            << setw(10) << setprecision(5) << yk << " | " << setw(10) << setprecision(5) << yk1 << " | "

            << setw(15) << setprecision(20) << abs(yk1 - yk) << " | "

            << setw(10) << setprecision(5) << zk << " | " << setw(10) << setprecision(5) << zk1 << " | "

            << setw(12) << setprecision(12) << abs(zk1 - zk) << " | " << endl;

    } while (abs(xk1 - xk) >= eps || abs(yk1 - yk) >= eps || abs(zk1 - zk) >= eps);

}
int main()
{
    double eps = 0.001;
    setlocale(LC_ALL, "Russian");
    simpleIteration(eps);
    seidel(eps);
}