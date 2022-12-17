using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace KTPO4310.Ivanov.Lib.src.LogAn
{
    public class LogAnalyzer
    {
        public bool WasLastFileNameValid { get; set; }
        public bool IsValidLogFileName(string fileName)
        {
             WasLastFileNameValid = false;

            if (string.IsNullOrEmpty(fileName))
            {
                throw new ArgumentException("имя файла должно быть задано");
            }
            if (fileName.EndsWith(".foo", StringComparison.CurrentCultureIgnoreCase))
            {
                return true;
            }
            WasLastFileNameValid = true;
            return false;
        }
    }
    
}
