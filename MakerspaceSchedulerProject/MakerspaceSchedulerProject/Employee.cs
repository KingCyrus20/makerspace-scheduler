using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MakerspaceSchedulerProject
{
    public class Employee
    {
        public String Name;
        public List<Employee> HatedEmployees;
        public Employee(string name)
        {
            Name = name;
        }

        public override string ToString()
        {
            return Name;
        }
    }
}
