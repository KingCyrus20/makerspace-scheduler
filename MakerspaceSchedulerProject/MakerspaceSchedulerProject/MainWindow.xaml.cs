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

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            employeeList.Add(new Employee(EmployeeSelector.Text));
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
                        break;
                    }
                }
            }
        }
    }
}
