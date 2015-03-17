Class {
	#name : #YrMethodEncodingTest,
	#superclass : #TestCase,
	#category : #'FicusMonticelloYrupe-Encoding'
}

{ #category : #tests }
YrMethodEncodingTest >> testRoundTripByteString [

	| method encoding encoded decoded |
	method :=
		FiMethod 
			sourceCode: 
'fortyTwo 
	^ 42' 
			protocol: #'number declaration'.
	
	encoding := YrMethodEncoding new.
	encoded := encoding stringFor: method.
	decoded := encoding objectFrom: encoded.
	
	self assert: decoded equals: method.
]

{ #category : #tests }
YrMethodEncodingTest >> testRoundTripWideString [

	| method encoding encoded decoded |
	method :=
		FiMethod 
			sourceCode: 
'fortyTwoTM 
	"Intel486™"

	^ 42' 
			protocol: #'number declaration'.
	
	encoding := YrMethodEncoding new.
	encoded := encoding stringFor: method.
	decoded := encoding objectFrom: encoded.
	
	self assert: decoded equals: method.
]
