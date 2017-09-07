using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace IdiomExercise
{
    [TestClass]
    public class Test
    {
        public delegate void funcionAMedir();
        [TestMethod]
        public void AddingCustomerShouldNotTakeMoreThan50Milliseconds()
        {
            CustomerBook customerBook = new CustomerBook();
            String nombreCustomer = "John Lennon";
            TakesLessThan(TimeTakenBy(() => customerBook.addCustomerNamed(nombreCustomer)), 50);

        }

        [TestMethod]
        public void RemovingCustomerShouldNotTakeMoreThan100Milliseconds()
        {
            CustomerBook customerBook = new CustomerBook();
            String nombreCustomer = "Paul McCartney";
            customerBook.addCustomerNamed(nombreCustomer);
            TakesLessThan(TimeTakenBy(() => customerBook.removeCustomerNamed(nombreCustomer)), 100);
        }

        [TestMethod]
        public void CanNotAddACustomerWithEmptyName()
        {
            CustomerBook customerBook = new CustomerBook();
            MustFail<Exception>(() => customerBook.addCustomerNamed(""), CustomerBook.CUSTOMER_NAME_EMPTY, customerBook);

        }

        [TestMethod]
        public void CanNotRemoveNotAddedCustomer()
        {
            CustomerBook customerBook = new CustomerBook();
            MustFail<InvalidOperationException>(() => customerBook.removeCustomerNamed("John Lennon"), CustomerBook.INVALID_CUSTOMER_NAME, customerBook);
        }

        private void MedirTiempoFuncionX(int time, Action func)
        {
            DateTime timeBeforeRunning = DateTime.Now;
            func();
            DateTime timeAfterRunning = DateTime.Now;

            Assert.IsTrue(timeAfterRunning.Subtract(timeBeforeRunning).TotalMilliseconds < time);
        }

        private double TimeTakenBy(Action func)
        {
            DateTime timeBeforeRunning = DateTime.Now;
            func();
            DateTime timeAfterRunning = DateTime.Now;
            return timeAfterRunning.Subtract(timeBeforeRunning).TotalMilliseconds;
        }

        private void TakesLessThan(double timeFunction, double timeLimit)
        {
            Assert.IsTrue(timeFunction < timeLimit);
        }

        private void MustFail<T>(Action func, IComparable<String> aStringDescribingFailure, CustomerBook customerBook) where T : Exception
        {
            try
            {
                func();
                Assert.Fail();
            }
            catch (T e)
            {
                Assert.AreEqual(e.Message, aStringDescribingFailure);
                Assert.IsTrue(customerBook.isEmpty());
            }
        }
    }
}