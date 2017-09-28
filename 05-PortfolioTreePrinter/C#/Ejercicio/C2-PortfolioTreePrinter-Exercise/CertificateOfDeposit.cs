using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace C2_PortfolioTreePrinter_Exercise
{
    class CertificateOfDeposit : AccountTransaction
    {

        private double _value;
        private int _numberOfDays;
        private double _tna;

        public CertificateOfDeposit(double value, int numberOfDays, double tna)
        {
            _value = value;
            _numberOfDays = numberOfDays;
            _tna = tna;
        }

        public double value()
        {
            return _value;
        }

        public static CertificateOfDeposit registerFor(double value, int numberOfDays, double tna,
                ReceptiveAccount account)
        {
            CertificateOfDeposit certificadoDeDeposito = new CertificateOfDeposit(value, numberOfDays,tna);

            account.register(certificadoDeDeposito);

            return certificadoDeDeposito;
        }

        public double earnings()
        {
            return _value * (_tna / 360) * _numberOfDays;
        }

        public int numberOfDays()
        {
            return _numberOfDays;
        }

        public double tna()
        {
            return _tna;
        }

        public double AfectAccountBalanceIn()
        {
            return _value*-1;
        }

        public string Description()
        {
            return "Plazo fijo por " + _value.ToString() +".0 durante "+ _numberOfDays.ToString() +" días a una tna de " + _tna.ToString();
        }
    }
}
