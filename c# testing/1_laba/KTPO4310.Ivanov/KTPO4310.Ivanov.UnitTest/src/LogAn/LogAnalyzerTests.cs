using KTPO4310.Ivanov.Lib.src.LogAn;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;


namespace KTPO4310.Ivanov.UnitTest.src.LogAn
{
    
    [TestFixture]
    public class LogAnalyzerTests
    {
        [Test]
        public void IsValidFileNameGoodExtension_ReturnsFalse()
        {
            LogAnalyzer analyzer = new LogAnalyzer();
            bool resulr = analyzer.IsValidLogFileName("filewithbadextension.lib");

            Assert.False(resulr);
        }
        [Test]
        public void IsValidLogFileName_GoodExtensionUppercase_ReturnsTrue()
        {
            LogAnalyzer analyzer = new LogAnalyzer();
            bool resulr = analyzer.IsValidLogFileName("filewithbadextension.foo");

            Assert.True(resulr);
        }
        [Test]
        public void IsValidLogFileName_GoodExtensionLowercase_ReturnsTrue()
        {
            LogAnalyzer analyzer = new LogAnalyzer();
            bool resulr = analyzer.IsValidLogFileName("filewithbadextension.foo");

            Assert.True(resulr);
        }
    }

}
