from enum import Enum
import unittest



class Cart:
	def __init__(self,catalog):
		self.books = {}
		self.catalog = catalog

	def addBook(self, aBook, quantity):
		if aBook in self.catalog:
			if quantity > 0 :
				if aBook in self.books:
					self.books[aBook] += quantity
				else:
					self.books[aBook] =  quantity 
			else:
				raise Exception('Cantidad debe ser positiva')
		else:
			raise Exception('Libro no es de la editorial')


class TusLibrosTest(unittest.TestCase):

	def test01WhenCreateCartIsEmpty(self):
		carrito = Cart([])
		self.assertTrue(len(carrito.books) == 0)

	def test02CanAddBookToCartThatAreInTheCatalog(self):
		carrito = Cart(['123'])
		carrito.addBook('123', 1)
		self.assertTrue('123' in carrito.books )

	def test03CantAddItemToCartThatAreNotInTheCatalog(self):
		try:
			carrito = Cart(['123','133','7565'])
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
		try:
			carrito = Cart(['123','133','7565'])
			carrito.addBook('123', -4)
			self.fail()
		except Exception, e :
			self.assertTrue( str(e) == 'Cantidad debe ser positiva')


