!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'LIC 11/2/2017 19:51:06'!
test01CreatedCartIsEmpty
	|carrito|
	carrito := Cart new.
	self assert: carrito isEmpty
	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'LIC 11/2/2017 20:05:27'!
test02CanAddBooksInCatalog
	|carrito|
	carrito := Cart withCatalog: #('123').
	carrito add: 1 item: '123'.
	self assert: [carrito items includes: '123'].! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'LIC 11/2/2017 20:30:52'!
test03CantAddItemsNotInCatalog
	|carrito|
	carrito := Cart withCatalog: #('123' '133' '7565').
	self 
		should: [ 
			carrito add: 1 item: '1234'.
			self fail]
		raise: Error 
		withExceptionDo: [ :error |
			self assert: Cart notInCatalogMessage =
			error messageText ]! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'LIC 11/2/2017 20:25:32'!
add: aQuantity item: anISBN
	
	(catalog includes: anISBN) ifFalse: [self error: 'Libro no es de la editorial'].

	items at: aQuantity put: anISBN! !

!Cart methodsFor: 'as yet unclassified' stamp: 'LIC 11/2/2017 19:56:23'!
initialize
	items := Dictionary new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'LIC 11/2/2017 20:15:00'!
initializeWithCatalog: anArray 
	items := Dictionary new.
	catalog := Bag new addAll: anArray.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'LIC 11/2/2017 19:53:57'!
isEmpty
	^items isEmpty! !

!Cart methodsFor: 'as yet unclassified' stamp: 'LIC 11/2/2017 20:11:46'!
items
	^items! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'LIC 11/2/2017 20:26:34'!
notInCatalogMessage
	^'Libro no es de la editorial'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'LIC 11/2/2017 20:08:20'!
withCatalog: aCatalog
	^self new initializeWithCatalog: aCatalog! !
