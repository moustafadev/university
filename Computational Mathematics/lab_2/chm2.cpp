#include <iostream>
#include "locale.h"
#include <math.h>
#include <iomanip>
using namespace std;
const float eps = 0.001; // Точность (эпсилон)
const float x = 1, y = 3; // Начальное приближение
const int rr = 10000; // Округление



double f1(double x, double y) {
    return y*y - x*y - 12;
}

double f2(double x, double y) {
    return x*x - x*y + 3;
}
void method_simple_implications() // Метод простых итераций
{
	int k = 0;
	float x0 = x, y0 = y, x1 = x, y1 = y; // x0 = x(k), x1 = x(k+1)
	float modx, mody; // y0 = y(k), y1 = y(k+1)
	do // modx: |x1 - x0|, mody: |y1 - y0|
	{
		x0 = x1, y0 = y1;
		x1 = x0 + (f1(x0,y0)*(0.125))+(0.625*f2(x0,y0));
        y1 = y0 + (f1(x0,y0)*(-0.125))+(0.375*f2(x0,y0));
		modx = fabs(x1 - x0);
		mody = fabs(y1 - y0);
		cout << "|" << setw(4) << k << setw(4) << "|" << setw(8) << x0 <<
		setw(5) << "|" << setw(10) << x1 << setw(5) << "|" <<
		setw(14) << modx  << setw(8) << "|" << setw(9) << y0 <<
		setw(4) << "|" << setw(9) << y1 << setw(4)<< "|" << setw(11)
		<< mody << setw(7) << "|" << endl;
		k++;
	} while ((modx > eps) || (mody > eps));
}


double det(double a11, double a12, double a21, double a22) { 
 
 return a11 * a22 - a12 * a21; 
 
} 

double df1_dx(double x, double y) { 
 
 return -y; 
 
} 
 
 
 
double df1_dy(double x, double y) { 
 
 return 2*y-x; 
 
} 
 
 
 
double df2_dx(double x, double y) { 
 
 return 2*x-y; 
 
} 
 
 
 
double df2_dy(double x, double y) { 
 
 return -x; 
 
} 

void method_Newton(double eps) { 
 
	double x, y, x_new, y_new; 
	int k = 0; 
	x = 1; 
	y = 3; 
	double x_prev = 0; 
	double y_prev = 0;  
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
		
		double fx = f1(x, y); 
		
		double fy = f2(x, y); 
		
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


void show_table()
{
	cout << "-------------------------------------------------------------------------------------------------------\n";
	cout << "| k |   x^(k)  |  x^(k+1) ||x^(k+1) - x^(k)||  y^(k)    |  y^(k+1) ||y^(k+1) - y^(k)| |\n";
	cout << "-------------------------------------------------------------------------------------------------------\n";
}
void func()
{
	
	cout << "\nМетод простых итераций" << endl;
	show_table();
	method_simple_implications();
	cout << "\nПроцесс поиска корня на отрезке прошел успешно !" << endl;
	cout << "\n";
	cout << "\nМетод Ньютона" << endl;
	show_table();
	method_Newton(eps);
	cout << "\nПроцесс поиска корня на отрезке прошел успешно !" << endl;
	cout << "\n";
}
int main()
{
	setlocale(0, "");
	cout << "Лабораторная работа по Вычислительной математике No3-4\n" << endl;
	cout << "Выполнили студенты группы 4310 Лошаков Александр и Козмодемьянов Антон\n"
	<< endl;
	cout << "Вариант No20\nСистема нелинейных уравнений:" << endl;
	func();
	// system("pause");
	return 0;
}



