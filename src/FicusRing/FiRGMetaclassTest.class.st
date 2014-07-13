Class {
	#name : #FiRGMetaclassTest,
	#superclass : #FiRGShotTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGMetaclassTest >> testMethods [

	self assert: ringShotResource classA theMetaClass methods isEmpty.

]

{ #category : #tests }
FiRGMetaclassTest >> testSelectorsAndMethodsDo [

	| results |
	results := OrderedCollection new.
	
	ringShotResource classA theMetaClass selectorsAndMethodsDo: [ :selector :method |
		results add: selector -> method ].

	self assert: results isEmpty.
]

{ #category : #tests }
FiRGMetaclassTest >> testTheNonMetaClass [

	| classA |
	classA := ringShotResource classA.
	self assert: classA theMetaClass theNonMetaClass == classA
]
