from enum import Enum
import unittest
import time
import datetime 
import math
	
class Cart:
	def __init__(self,catalog):
		self.books = {}
		self.catalog = catalog

	def addBook(self, aBook, quantity):
		if aBook in self.catalog:
			if quantity > 0 :
				if math.floor(quantity) == quantity:
					if aBook in self.books:
						self.books[aBook] += quantity
					else:
						self.books[aBook] =  quantity
				else:
					raise Exception('Cantidad debe ser Entera')
			else:
				raise Exception('Cantidad debe ser positiva')
		else:
			raise Exception('Libro no es de la editorial')

class CreditCard:
	def __init__(self, id, expirationDate, owner):
		self.id = id
		self.expirationDate = expirationDate
		self.owner = owner

class Calendar:
	def __init__(self, fechaDeHoy):
		day = int(fechaDeHoy[:2])
		month = int(fechaDeHoy[2:4])
		year = int(fechaDeHoy[4:])

		self.today = datetime.date(year,month,day)

class Clerk:
	def __init__(self, calendario):
		self.calendar = calendario

	def CheckOut(self, carrito, cardExpirationDate ):
		year = int(cardExpirationDate[2:])
		month = int(cardExpirationDate[:2])

		date = datetime.date(year, month , 1 )


		if date < self.calendar.today :
			raise Exception('La tarjeta esta vencida')

		if carrito.books == {} :
			raise Exception('No se puede hacer checkout de un carrito vacio')



class TusLibrosTest(unittest.TestCase):

	def test01WhenCreateCartIsEmpty(self):
		carrito = Cart([])
		self.assertTrue(len(carrito.books) == 0)

	def test02CanAddBookToCartThatAreInTheCatalog(self):
		carrito = Cart(['123'])
		carrito.addBook('123', 1)
		self.assertTrue('123' in carrito.books )

	def test03CantAddItemToCartThatAreNotInTheCatalog(self):
		carrito = Cart(['123','133','7565'])
		try:
			carrito.addBook('1234', 1)
			self.fail()
		except Exception, e :
			self.assertTrue( str(e) == 'Libro no es de la editorial')


	def test04CanAddMoreThatOneBookWithSameISN(self):
		carrito = Cart(['123','133','7565'])
		carrito.addBook('123', 4)
		self.assertTrue(carrito.books['123']  == 4)

	def test05CanAddMoreOfTheSameBook(self):
		carrito = Cart(['123','133','7565'])
		carrito.addBook('123', 4)
		carrito.addBook('123', 2)
		self.assertTrue(carrito.books['123']  == 6)

	def test06CantAddANegativeNumberOfBooks(self):
		carrito = Cart(['123','133','7565'])		
		try:
			carrito.addBook('123', -4)
			self.fail()
		except Exception, e :
			self.assertTrue( str(e) == 'Cantidad debe ser positiva')
			self.assertTrue({} == carrito.books)

	def test07CantAddNonIntegerNumberOfBooks(self):
		carrito = Cart(['123','133','7565'])
		try:
			carrito.addBook('123', 1.22)
			self.fail()
		except Exception, e :
			self.assertTrue( str(e) == 'Cantidad debe ser Entera')
			self.assertTrue({} == carrito.books)

#TEST CAJER@

	def test08CanCheckOutProductsIfCardIsNotExpired(self):
		carrito = Cart(['1','12','123'])
		cajero = Clerk(Calendar('01112017'))
		carrito.addBook('123', 4)
		try:
			cajero.CheckOut(carrito, '112019')
		except Exception, e :
			self.fail(e)	

	def test09CantCheckOutProductsIfCardAlredyExpired(self):
		carrito = Cart(['1','12','123'])
		cajero = Clerk(Calendar('01112017'))
		carrito.addBook('123', 4)
		try:
			cajero.CheckOut(carrito, '112012')
		except Exception, e :
			self.assertTrue( str(e) == 'La tarjeta esta vencida')

	def test10CanCheckOutProductsIfCardExpiresToday(self):
		carrito = Cart(['1','12','123'])
		cajero = Clerk(Calendar('01112017'))
		carrito.addBook('123', 4)
		try:
			cajero.CheckOut(carrito, '112017')
		except Exception, e :
			self.fail(e)


	def test11CantCheckOutEmptyCart(self):
		carrito = Cart(['1','12','123'])
		cajero = Clerk(Calendar('01112017'))
		try:
			cajero.CheckOut(carrito, '112017')
			self.fail()
		except Exception, e :
			self.assertTrue( str(e) == 'No se puede hacer checkout de un carrito vacio')

#TEST Tarjeta

	def test12CannotCreateInvalidCreditCardByEmptyOwner(self):
		pass