using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace C2_PortfolioTreePrinter_Exercise
{
    [TestClass]
    public class PortfolioTest
    {
        [TestMethod]
        public void test01ReceptiveAccountHaveZeroAsBalanceWhenCreated()
        {
            ReceptiveAccount account = new ReceptiveAccount();

            Assert.AreEqual(0.0, account.balance());
        }

        [TestMethod]
        public void test02DepositIncreasesBalanceOnTransactionValue()
        {
            ReceptiveAccount account = new ReceptiveAccount();
            Deposit.registerForOn(100, account);

            Assert.AreEqual(100.0, account.balance());

        }

        [TestMethod]
        public void test03WithdrawDecreasesBalanceOnTransactionValue()
        {
            ReceptiveAccount account = new ReceptiveAccount();
            Deposit.registerForOn(100, account);
            var withdraw = Withdraw.registerForOn(50, account);

            Assert.AreEqual(50.0, account.balance());
            Assert.AreEqual(50.0, withdraw.value());
        }

        [TestMethod]
        public void test04PortfolioBalanceIsSumOfManagedAccountsBalance()
        {
            ReceptiveAccount account1 = new ReceptiveAccount();
            ReceptiveAccount account2 = new ReceptiveAccount();
            Portfolio complexPortfolio = Portfolio.createWith(account1, account2);

            Deposit.registerForOn(100, account1);
            Deposit.registerForOn(200, account2);

            Assert.AreEqual(300.0, complexPortfolio.balance());
        }

        [TestMethod]
        public void test05PortfolioCanManagePortfolios()
        {
            ReceptiveAccount account1 = new ReceptiveAccount();
            ReceptiveAccount account2 = new ReceptiveAccount();
            ReceptiveAccount account3 = new ReceptiveAccount();
            Portfolio complexPortfolio = Portfolio.createWith(account1, account2);
            Portfolio composedPortfolio = Portfolio.createWith(complexPortfolio, account3);

            Deposit.registerForOn(100, account1);
            Deposit.registerForOn(200, account2);
            Deposit.registerForOn(300, account3);
            Assert.AreEqual(600.0, composedPortfolio.balance());
        }

        [TestMethod]
        public void test06ReceptiveAccountsKnowsRegisteredTransactions()
        {
            ReceptiveAccount account = new ReceptiveAccount();
            Deposit deposit = Deposit.registerForOn(100, account);
            Withdraw withdraw = Withdraw.registerForOn(50, account);

            Assert.IsTrue(account.registers(deposit));
            Assert.IsTrue(account.registers(withdraw));
        }

        [TestMethod]
        public void test07PortofoliosKnowsTransactionsRegisteredByItsManagedAccounts()
        {
            ReceptiveAccount account1 = new ReceptiveAccount();
            ReceptiveAccount account2 = new ReceptiveAccount();
            ReceptiveAccount account3 = new ReceptiveAccount();
            Portfolio complexPortfolio = Portfolio.createWith(account1, account2);
            Portfolio composedPortfolio = Portfolio.createWith(complexPortfolio, account3);

            Deposit deposit1 = Deposit.registerForOn(100, account1);
            Deposit deposit2 = Deposit.registerForOn(200, account2);
            Deposit deposit3 = Deposit.registerForOn(300, account3);

            Assert.IsTrue(composedPortfolio.registers(deposit1));
            Assert.IsTrue(composedPortfolio.registers(deposit2));
            Assert.IsTrue(composedPortfolio.registers(deposit3));
        }

        [TestMethod]
        public void test08ReceptiveAccountManageItSelf()
        {
            ReceptiveAccount account1 = new ReceptiveAccount();

            Assert.IsTrue(account1.manages(account1));
        }

        [TestMethod]
        public void test09ReceptiveAccountDoNotManageOtherAccount()
        {
            ReceptiveAccount account1 = new ReceptiveAccount();
            ReceptiveAccount account2 = new ReceptiveAccount();

            Assert.IsFalse(account1.manages(account2));
        }

        [TestMethod]
        public void test10PortfolioManagesComposedAccounts()
        {
            ReceptiveAccount account1 = new ReceptiveAccount();
            ReceptiveAccount account2 = new ReceptiveAccount();
            ReceptiveAccount account3 = new ReceptiveAccount();
            Portfolio complexPortfolio = Portfolio.createWith(account1, account2);

            Assert.IsTrue(complexPortfolio.manages(account1));
            Assert.IsTrue(complexPortfolio.manages(account2));
            Assert.IsFalse(complexPortfolio.manages(account3));
        }

        [TestMethod]
        public void test11PortfolioManagesComposedAccountsAndPortfolios()
        {
            ReceptiveAccount account1 = new ReceptiveAccount();
            ReceptiveAccount account2 = new ReceptiveAccount();
            ReceptiveAccount account3 = new ReceptiveAccount();
            Portfolio complexPortfolio = Portfolio.createWith(account1, account2);
            Portfolio composedPortfolio = Portfolio.createWith(complexPortfolio, account3);

            Assert.IsTrue(composedPortfolio.manages(account1));
            Assert.IsTrue(composedPortfolio.manages(account2));
            Assert.IsTrue(composedPortfolio.manages(account3));
            Assert.IsTrue(composedPortfolio.manages(complexPortfolio));
        }

        [TestMethod]
        public void test12AccountsKnowsItsTransactions()
        {
            ReceptiveAccount account1 = new ReceptiveAccount();

            Deposit deposit1 = Deposit.registerForOn(100, account1);

            Assert.AreEqual(1, account1.transactions().Count);
            Assert.IsTrue(account1.transactions().Contains(deposit1));
        }

        [TestMethod]
        public void test13PortfolioKnowsItsAccountsTransactions()
        {
            ReceptiveAccount account1 = new ReceptiveAccount();
            ReceptiveAccount account2 = new ReceptiveAccount();
            ReceptiveAccount account3 = new ReceptiveAccount();
            Portfolio complexPortfolio = Portfolio.createWith(account1, account2);
            Portfolio composedPortfolio = Portfolio.createWith(complexPortfolio, account3);

            Deposit deposit1 = Deposit.registerForOn(100, account1);
            Deposit deposit2 = Deposit.registerForOn(200, account2);
            Deposit deposit3 = Deposit.registerForOn(300, account3);

            Assert.AreEqual(3, composedPortfolio.transactions().Count);
            Assert.IsTrue(composedPortfolio.transactions().Contains(deposit1));
            Assert.IsTrue(composedPortfolio.transactions().Contains(deposit2));
            Assert.IsTrue(composedPortfolio.transactions().Contains(deposit3));
        }

        [TestMethod]
        public void test17CanNotCreatePortfoliosWithRepeatedAccount()
        {
            ReceptiveAccount account1 = new ReceptiveAccount();
            try
            {
                Portfolio.createWith(account1, account1);
                Assert.Fail();
            }
            catch (Exception invalidPortfolio)
            {
                Assert.AreEqual(Portfolio.ACCOUNT_ALREADY_MANAGED, invalidPortfolio.Message);
            }

        }

        [TestMethod]
        public void test18CanNotCreatePortfoliosWithAccountsManagedByOtherManagedPortfolio()
        {
            ReceptiveAccount account1 = new ReceptiveAccount();
            ReceptiveAccount account2 = new ReceptiveAccount();
            Portfolio complexPortfolio = Portfolio.createWith(account1, account2);
            try
            {
                Portfolio.createWith(complexPortfolio, account1);
                Assert.Fail();
            }
            catch (Exception invalidPortfolio)
            {
                Assert.AreEqual(Portfolio.ACCOUNT_ALREADY_MANAGED, invalidPortfolio.Message);
            }
        }


        [TestMethod]
        public void test19aTransferShouldRegistersATransferDepositOnToAccount()
        {
            ReceptiveAccount fromAccount = new ReceptiveAccount();
            ReceptiveAccount toAccount = new ReceptiveAccount();

            Transfer transfer = Transfer.registerFor(100, fromAccount, toAccount);

            Assert.IsTrue(toAccount.registers(transfer.depositLeg()));
        }

        [TestMethod]
        public void test19bTransferShouldRegistersATransferWithdrawOnFromAccount()
        {
            ReceptiveAccount fromAccount = new ReceptiveAccount();
            ReceptiveAccount toAccount = new ReceptiveAccount();

            Transfer transfer = Transfer.registerFor(100, fromAccount, toAccount);

            Assert.IsTrue(fromAccount.registers(transfer.withdrawLeg()));
        }

        [TestMethod]
        public void test19cTransferLegsKnowTransfer()
        {
            ReceptiveAccount fromAccount = new ReceptiveAccount();
            ReceptiveAccount toAccount = new ReceptiveAccount();

            Transfer transfer = Transfer.registerFor(100, fromAccount, toAccount);

            Assert.AreEqual(transfer.depositLeg().transfer(), transfer.withdrawLeg().transfer());
        }

        [TestMethod]
        public void test19dTransferKnowsItsValue()
        {
            ReceptiveAccount fromAccount = new ReceptiveAccount();
            ReceptiveAccount toAccount = new ReceptiveAccount();

            Transfer transfer = Transfer.registerFor(100, fromAccount, toAccount);

            Assert.AreEqual(100, transfer.value(), 0.0);
        }

        [TestMethod]
        public void test19eTransferShouldWithdrawFromFromAccountAndDepositIntoToAccount()
        {
            ReceptiveAccount fromAccount = new ReceptiveAccount();
            ReceptiveAccount toAccount = new ReceptiveAccount();

            Transfer.registerFor(100, fromAccount, toAccount);

            Assert.AreEqual(-100.0, fromAccount.balance(), 0.0);
            Assert.AreEqual(100.0, toAccount.balance(), 0.0);
        }


        [TestMethod]
        public void test20AccountSummaryShouldProvideHumanReadableTransactionsDetail()
        {
            ReceptiveAccount fromAccount = new ReceptiveAccount();
            ReceptiveAccount toAccount = new ReceptiveAccount();

            Deposit.registerForOn(100, fromAccount);
            Withdraw.registerForOn(50, fromAccount);
            Transfer.registerFor(100, fromAccount, toAccount);

            List<String> lines = accountSummaryLines(fromAccount);

            Assert.AreEqual(3, lines.Count);
            Assert.AreEqual("Depósito por 100.0", lines.ElementAt(0));
            Assert.AreEqual("Extracción por 50.0", lines.ElementAt(1));
            Assert.AreEqual("Transferencia por -100.0", lines.ElementAt(2));
        }

        private List<String> accountSummaryLines(ReceptiveAccount fromAccount)
        {
            throw new Exception("Implement");
        }

        [TestMethod]
        public void test21ShouldBeAbleToBeQueryTransferNet()
        {
            ReceptiveAccount fromAccount = new ReceptiveAccount();
            ReceptiveAccount toAccount = new ReceptiveAccount();

            Deposit.registerForOn(100, fromAccount);
            Withdraw.registerForOn(50, fromAccount);
            Transfer.registerFor(100, fromAccount, toAccount);
            Transfer.registerFor(250, toAccount, fromAccount);

            Assert.AreEqual(150.0, accountTransferNet(fromAccount));

            Assert.AreEqual(-150.0, accountTransferNet(toAccount));
        }

        private double accountTransferNet(ReceptiveAccount account)
        {
            throw new Exception("Implement");
        }

        [TestMethod]
        public void test22CertificateOfDepositShouldWithdrawInvestmentValue()
        {
            ReceptiveAccount account = new ReceptiveAccount();
            ReceptiveAccount toAccount = new ReceptiveAccount();

            Deposit.registerForOn(1000, account);
            Withdraw.registerForOn(50, account);
            Transfer.registerFor(100, account, toAccount);
            CertificateOfDeposit.registerFor(100, 30, 0.1, account);

            Assert.AreEqual(100.0, investmentNet(account));
            Assert.AreEqual(750.0, account.balance());
        }

        private double investmentNet(ReceptiveAccount account)
        {
            throw new Exception("Implement");
        }

        [TestMethod]
        public void test23ShouldBeAbleToQueryInvestmentEarnings()
        {
            ReceptiveAccount account = new ReceptiveAccount();

            CertificateOfDeposit.registerFor(100, 30, 0.1, account);
            CertificateOfDeposit.registerFor(100, 60, 0.15, account);

            double m_investmentEarnings =
                100.0 * (0.1 / 360) * 30 +
                100.0 * (0.15 / 360) * 60;

            Assert.AreEqual(m_investmentEarnings, investmentEarnings(account));
        }

        private double investmentEarnings(ReceptiveAccount account)
        {
            throw new Exception("Implement");
        }

        [TestMethod]
        public void test24AccountSummaryShouldWorkWithCertificateOfDeposit()
        {
            ReceptiveAccount fromAccount = new ReceptiveAccount();
            ReceptiveAccount toAccount = new ReceptiveAccount();

            Deposit.registerForOn(100, fromAccount);
            Withdraw.registerForOn(50, fromAccount);
            Transfer.registerFor(100, fromAccount, toAccount);
            CertificateOfDeposit.registerFor(1000, 30, 0.1, fromAccount);

            List<String> lines = accountSummaryLines(fromAccount);

            Assert.AreEqual(4, lines.Count);
            Assert.AreEqual("Depósito por 100.0", lines.ElementAt(0));
            Assert.AreEqual("Extracción por 50.0", lines.ElementAt(1));
            Assert.AreEqual("Transferencia por -100.0", lines.ElementAt(2));
            Assert.AreEqual("Plazo fijo por 1000.0 durante 30 días a una tna de 0.1", lines.ElementAt(3));
        }

        [TestMethod]
        public void test25ShouldBeAbleToBeQueryTransferNetWithCertificateOfDeposit()
        {
            ReceptiveAccount fromAccount = new ReceptiveAccount();
            ReceptiveAccount toAccount = new ReceptiveAccount();

            Deposit.registerForOn(100, fromAccount);
            Withdraw.registerForOn(50, fromAccount);
            Transfer.registerFor(100, fromAccount, toAccount);
            Transfer.registerFor(250, toAccount, fromAccount);
            CertificateOfDeposit.registerFor(1000, 30, 0.1, fromAccount);

            Assert.AreEqual(150.0, accountTransferNet(fromAccount));
            Assert.AreEqual(-150.0, accountTransferNet(toAccount));
        }

        [TestMethod]
        public void test26PortfolioTreePrinter()
        {
            ReceptiveAccount account1 = new ReceptiveAccount();
            ReceptiveAccount account2 = new ReceptiveAccount();
            ReceptiveAccount account3 = new ReceptiveAccount();
            Portfolio complexPortfolio = Portfolio.createWith(account1, account2);
            Portfolio composedPortfolio = Portfolio.createWith(complexPortfolio, account3);


            Dictionary<SummarizingAccount, String> accountNames = new Dictionary<SummarizingAccount, String>();
            accountNames.Add(composedPortfolio, "composedPortfolio");
            accountNames.Add(complexPortfolio, "complexPortfolio");
            accountNames.Add(account1, "account1");
            accountNames.Add(account2, "account2");
            accountNames.Add(account3, "account3");

            List<String> lines = portofolioTreeOf(composedPortfolio, accountNames);

            Assert.AreEqual(5, lines.Count);
            Assert.AreEqual("composedPortfolio", lines.ElementAt(0));
            Assert.AreEqual(" complexPortfolio", lines.ElementAt(1));
            Assert.AreEqual("  account1", lines.ElementAt(2));
            Assert.AreEqual("  account2", lines.ElementAt(3));
            Assert.AreEqual(" account3", lines.ElementAt(4));

        }

        private List<String> portofolioTreeOf(Portfolio composedPortfolio,
                Dictionary<SummarizingAccount, String> accountNames)
        {
            throw new Exception("Implement");
        }

        [TestMethod]
        public void test27ReversePortfolioTreePrinter()
        {
            ReceptiveAccount account1 = new ReceptiveAccount();
            ReceptiveAccount account2 = new ReceptiveAccount();
            ReceptiveAccount account3 = new ReceptiveAccount();
            Portfolio complexPortfolio = Portfolio.createWith(account1, account2);
            Portfolio composedPortfolio = Portfolio.createWith(complexPortfolio, account3);

            Dictionary<SummarizingAccount, String> accountNames = new Dictionary<SummarizingAccount, String>();
            accountNames.Add(composedPortfolio, "composedPortfolio");
            accountNames.Add(complexPortfolio, "complexPortfolio");
            accountNames.Add(account1, "account1");
            accountNames.Add(account2, "account2");
            accountNames.Add(account3, "account3");

            List<String> lines = reversePortofolioTreeOf(composedPortfolio, accountNames);

            Assert.AreEqual(5, lines.Count);
            Assert.AreEqual(" account3", lines.ElementAt(0));
            Assert.AreEqual("  account2", lines.ElementAt(1));
            Assert.AreEqual("  account1", lines.ElementAt(2));
            Assert.AreEqual(" complexPortfolio", lines.ElementAt(3));
            Assert.AreEqual("composedPortfolio", lines.ElementAt(4));

        }

        private List<String> reversePortofolioTreeOf(Portfolio composedPortfolio,
                Dictionary<SummarizingAccount, String> accountNames)
        {
            throw new Exception("Implement");
        }

    }
}
