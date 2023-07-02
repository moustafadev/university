

#include <iostream>
#include "locale.h"
#include <math.h>
#include <iomanip>
using namespace std;
const float eps = 0.001; // точность
const float x = 1.0, y = 1.0/5.0, z = 2.0/5.0; // начальное приближение
const int rr = 10000; // округление
void method_simple_implications() // Метод простых итераций
{
    int k = 0;
    float x0 = x, x1 = x; // x0 = x(k), x1 = x(k+1)
    float y0 = y, y1 = y; // y0 = y(k), y1 = y(k+1)
    float z0 = z, z1 = z; // z0 = y(k), z1 = z(k+1)
    float modx, mody, modz; // modx: |x1 - x0|, mody: |y1 - y0|, modz: |z1 - z0|
    do
    {
        x0 = x1; y0 = y1; z0 = z1;
        x1 = ((-1.0/9.0) * y0 + (1.0 / 9.0) * z0 - (5.0/6.0)) / (-5.0/6.0);
        y1 = (2.0 * x0 + 5/8 *z0 + - 2.0) / - 10.0;
        z1 = (-x0 + (1.0/5.0) * y0 + 1.0) / (5.0 / 2.0);
        modx = fabs(x1 - x0);
        mody = fabs(y1 - y0);
        modz = fabs(z1 - z0);
        cout << "|" << setw(4) << k << setw(4)
        << "|" << setw(8) << round(x0 * rr) / rr << setw(5)
        << "|" << setw(10)<< round(x1 * rr) / rr << setw(5)
        << "|" << setw(14) << round(modx * rr) / rr << setw(8)
        << "|" << setw(9) << round(y0 * rr) / rr << setw(4)
        << "|" << setw(9) << round(y1 * rr) / rr << setw(4)


        << "|" << setw(11) << round(mody * rr) / rr << setw(7)
        << "|" << setw(9) << round(z0 * rr) / rr << setw(4)
        << "|" << setw(9) << round(z1 * rr) / rr << setw(4)
        << "|" << setw(11) << round(modz * rr) / rr << setw(7)
        << "|" << endl;
        k++;
    } while ((modx > eps) || (mody > eps) || (modz > eps));
}
void method_Zeidela() // Метод Зейделя
{
        int k = 0;
        float x0 = x, x1 = x; // x0 = x(k), x1 = x(k+1)
        float y0 = y, y1 = y; // y0 = y(k), y1 = y(k+1)
        float z0 = z, z1 = z; // z0 = y(k), z1 = z(k+1)
        float modx, mody, modz; // modx: |x1 - x0|, mody: |y1 - y0|, modz: |z1 - z0|
    do
    {
        x0 = x1; y0 = y1; z0 = z1;
        x1 = (y0*5.0/54.0+z0*5.0/54.0+1);
        y1 = (1.0/5.0-1.0/5.0*x0-1.0/16*z0);
        z1 = (2.0/5.0*y0+2.0/5.0*x0+2.0/5.0);
        modx = fabs(x1 - x0);
        mody = fabs(y1 - y0);
        modz = fabs(z1 - z0);
        cout << "|" << setw(4) << k << setw(4)
        << "|" << setw(8) << round(x0 * rr) / rr << setw(5)
        << "|" << setw(10)<< round(x1 * rr) / rr << setw(5)
        << "|" << setw(14) << round(modx * rr) / rr << setw(8)
        << "|" << setw(9) << round(y0 * rr) / rr << setw(4)
        << "|" << setw(9) << round(y1 * rr) / rr << setw(4)
        << "|" << setw(11) << round(mody * rr) / rr << setw(7)
        << "|" << setw(9) << round(z0 * rr) / rr << setw(4)
        << "|" << setw(9) << round(z1 * rr) / rr << setw(4)
        << "|" << setw(11) << round(modz * rr) / rr << setw(7)
        << "|" << endl;
        k++;
    } while ((modx > eps) || (mody > eps) || (modz > eps));
}
void show_table()
{
    cout << "---------------------------------------------------------------------------------------------------------------------------------------------------" <<endl;
    cout << "| k | X(k) | X(k + 1) | |(X(k+1) - X(k))| | Y(k) |Y(k+1) | |Y(k+1) - Y(k)| | Z(k) | Z(k+1) | |Z(k+1) - Z(k)| |\n";
    cout << "--------------------------------------------------------------------------------------------------------------------------------------------------"<<endl;
}
void func()
{
int n;
while (true)
{
    cout << "Команда 1 - поиск корня на отрезке по Методу простых итераций" << endl;
    cout << "Команда 2 - поиск корня на отрезке по Методу Зейделя" << endl;
    cout << "Введите команду: "; cin >> n;
    switch (n)
    {

        case 1:
        cout << "\nМетод простых итераций" << endl;
        show_table();
        method_simple_implications();
        cout << "\nПроцесс поиска корня на отрезке прошел успешно !" << endl;
        break;
        case 2:
        cout << "\nМетод Зейделя" << endl;
        show_table();
        method_Zeidela();
        cout << "\nПроцесс поиска корня на отрезке прошел успешно !" << endl;
        break;
        default:
        cout << "\nОшибка ввода! Команды не существует! Повторите ввод! \n";
        break;
    }
    cout << "\n";
// system("pause");
// system("cls");
}
}
int main()
{
    setlocale(0, "");
    cout << "Лабораторная работа по Вычислительной математике No5\n" << endl;
    cout << "ИТЕРАЦИОННЫЕ МЕТОДЫ РЕШЕНИЯ СИСТЕМ ЛИНЕЙНЫХ АЛГЕБРАИЧЕСКИХ УРАВНЕНИЙ\n" <<
    endl;
    cout << "Выполнили студенты группы 4310 Лошаков Александр и Козмодемьянов Антон\n";
    func();
    system("pause");
    return 0;
}