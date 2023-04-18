#include <iostream> 
 
#include <iomanip> 
 
#include <cmath> 
 
 
 
using namespace std; 
 
 
 
// Функции для метода простых итераций 
 
double f1(double x, double y) { 
 
 return sqrt(6 - y); 
 
} 
 
 
 
double f2(double x, double y) { 
 
 return 4 - x; 
 
} 
 
 
 
void simpleIteration(double eps) { 
 
 double x, y, x_new, y_new; 
 
 int k = 0; 
 
 x = 1; 
 
 y = 1; 
 
 double x_prev = 0; 
 
 double y_prev = 0; 
 
 cout << " | " << setw(3) << "k" << " | " 
 
 << setw(10) << "x^k" << " | " 
 
 << setw(10) << "x^(k+1)" << " | " 
 
 << setw(25) << "|x^(k+1) - x^k|" << " | " 
 
 << setw(10) << "y^k" << " | " 
 
 << setw(10) << "y^(k+1)" << " | " 
 
 << setw(25) << "|y^(k+1) - y^k|" << " | " << endl; 
 
 do { 
 
 k++; 
 
 
 
 x_new = f1(x, y); 
 
 y_new = f2(x, y); 
 
 cout << " | " << setw(3) << k << " | " << setw(10) << setprecision(5) << x << " | " 
 
 << setw(10) << setprecision(5) << x_new << " | " << setw(25) << setprecision(20) << abs(x_new - x) << " | " 
 
 << setw(10) << setprecision(5) << y << " | " << setw(10) << setprecision(5) << y_new << " | " 
 
 << setw(25) << setprecision(20) << abs(y_new - y) << " | " << endl; 
 
 x_prev = x; 
 
 y_prev = y; 
 
 x = x_new; 
 
 y = y_new; 
 
 } while (abs(x_new - x_prev) > eps || abs(y_new - y_prev) > eps); 
 
} 
 
 
 
// Функции для метода Ньютона 
 
double det(double a11, double a12, double a21, double a22) { 
 
 return a11 * a22 - a12 * a21; 
 
} 
 
 
 
double f1_newton(double x, double y) { 
 
 return x * x + y - 6; 
 
} 
 
 
 
double f2_newton(double x, double y) { 
 
 return x + y - 4; 
 
} 
 
 
 
double df1_dx(double x, double y) { 
 
 return 2 * x; 
 
} 
 
 
 
double df1_dy(double x, double y) { 
 
 return 1; 
 
} 
 
 
 
double df2_dx(double x, double y) { 
 
 return 1; 
 
} 
 
 
 
double df2_dy(double x, double y) { 
 
 return 1; 
 
} 
 
 
 
void newtonMethod(double eps) { 
 
 double x, y, x_new, y_new; 
 
 int k = 0; 
 
 x = 1; 
 
 y = 1; 
 
 double x_prev = 0; 
 
 double y_prev = 0; 
 
 
 
 cout << " | " << setw(3) << "k" << " | " 
 
 << setw(10) << "x^k" << " | " 
 
 << setw(10) << "x^(k+1)" << " | " 
 
 << setw(25) << "|x^(k+1) - x^k|" << " | " 
 
 << setw(10) << "y^k" << " | " 
 
 << setw(10) << "y^(k+1)" << " | " 
 
 << setw(25) << "|y^(k+1) - y^k|" << " | " << endl; 
 
 
 
 do { 
 
 k++; 
 
 double a11 = df1_dx(x, y); 
 
 double a12 = df1_dy(x, y); 
 
 double a21 = df2_dx(x, y); 
 
 double a22 = df2_dy(x, y); 
 
 double d = det(a11, a12, a21, a22); 
 
 double inv_a11 = a22 / d; 
 
 double inv_a12 = -a12 / d; 
 
 double inv_a21 = -a21 / d; 
 
 double inv_a22 = a11 / d; 
 
 double fx = f1_newton(x, y); 
 
 double fy = f2_newton(x, y); 
 
 x_new = x - inv_a11 * fx - inv_a12 * fy; 
 
 y_new = y - inv_a21 * fx - inv_a22 * fy; 
 
 cout << " | " << setw(3) << k << " | " << setw(10) << setprecision(5) << x << " | " 
 
 << setw(10) << setprecision(5) << x_new << " | " << setw(25) << setprecision(20) << abs(x_new - x) << " | " 
 
 << setw(10) << setprecision(5) << y << " | " << setw(10) << setprecision(5) << y_new << " | " 
 
 << setw(25) << setprecision(20) << abs(y_new - y) << " | " << endl; 
 
 x_prev = x; 
 
 y_prev = y; 
 
 x = x_new; 
 
 y = y_new; 
 
 } while (abs(x_new - x_prev) > eps || abs(y_new - y_prev) > eps); 
 
} 
 
int main() { 
 
 double x, y, x_new, y_new, eps = 0.0001; 
 
 int k = 0; 
 
 cout << "simpleIteratio E=0.0001"<<endl; 
 
 simpleIteration(eps); 
 
 cout << endl; 
 
 // Метод Ньютона 
 
 cout << "newtonMethod E=0.0001" << endl; 
 
 newtonMethod(eps); 
 
 cout << endl; 
 
 
 
 eps /= 100; 
 
 
 
 cout << "simpleIteratio E=0.000001" << endl; 
 
 simpleIteration(eps); 
 
 cout << endl; 
 
 // Метод Ньютона 
 
 cout << "newtonMethod E=0.000001" << endl; 
 
 newtonMethod(eps); 
 
 
 
 return 0; 
 
}