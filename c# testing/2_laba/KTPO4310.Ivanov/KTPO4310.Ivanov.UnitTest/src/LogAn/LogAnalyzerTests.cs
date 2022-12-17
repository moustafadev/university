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
            bool resulr = analyzer.IsValidLogFileName("filewithbadextension.KADYROV");

            Assert.True(resulr);
        }
        [Test]
        public void IsValidLogFileName_GoodExtensionLowercase_ReturnsTrue()
        {
            LogAnalyzer analyzer = new LogAnalyzer();
            bool resulr = analyzer.IsValidLogFileName("filewithbadextension.KADYROV");

            Assert.True(resulr);
        }

        [TestCase("filewithbadextension.KADYROV")]
        [TestCase("filewithbadextension.kadyrov")]
        public void IsValidLogFileName_ValidExtension_ReturnsTrue(string fileName)
        {
            LogAnalyzer analyzer = new LogAnalyzer();
            bool result = analyzer.IsValidLogFileName(fileName);
            Assert.True(result);

        }

        [Test]
        public void IsValidFileName_EmptyFileName_Throws()
        {
            LogAnalyzer analyzer = new LogAnalyzer();
            var ex = Assert.Catch<Exception>(() => analyzer.IsValidLogFileName(""));
            StringAssert.Contains("имя файла должно быть задано", ex.Message);
        }
        [TestCase("badfile.foo", true)]
        [TestCase("goodfile.kadyrov", false)]
        public void IsValidFileName_WhenCalled_ChangesWasLastFileNameValid(string fileName, bool expected)
        {
            LogAnalyzer analyzer = new LogAnalyzer();
            analyzer.IsValidLogFileName(fileName);
            Assert.AreEqual(expected, analyzer.WasLastFileNameValid);
        }

    }

}
