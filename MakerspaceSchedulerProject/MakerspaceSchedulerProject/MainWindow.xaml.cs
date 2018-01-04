using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace MakerspaceSchedulerProject
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public static ObservableCollection<Employee> employeeList;
        public MainWindow()
        {
            InitializeComponent();
            employeeList = new ObservableCollection<Employee>();
            EmployeeSelector.ItemsSource = employeeList;
        }

        private bool employeeExists(String name)
        {
            if (employeeList.Count() > 0)
            {
                foreach (Employee emp in employeeList)
                {
                    if (emp.Name.Equals(name))
                        return true;
                }
                return false;
            }
            return false;
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            employeeList.Add(new Employee(EmployeeSelector.Text));
            MessageBoxResult employeeAdded = MessageBox.Show("Employee Added.");
        }

        private void RemoveButton_Click(object sender, RoutedEventArgs e)
        {
            if (employeeList.Count() > 0)
            {
                foreach (Employee emp in employeeList)
                {
                    if (emp.Name.Equals(EmployeeSelector.Text))
                    {
                        employeeList.Remove(emp);
                        MessageBoxResult employeeRemoved = MessageBox.Show("Employee Removed.");
                        break;                        
                    }
                }
            }
        }

        private void EditButton_Click(object sender, RoutedEventArgs e)
        {
            if (employeeExists(EmployeeSelector.Text))
            {
                EmployeeEditor currentEmployee = new EmployeeEditor();
                currentEmployee.Text = EmployeeSelector.Text;
                currentEmployee.ShowDialog();
            }
            else
            {
                MessageBoxResult editError = MessageBox.Show("Employee does not exist.");
            }
        }
    }
}
