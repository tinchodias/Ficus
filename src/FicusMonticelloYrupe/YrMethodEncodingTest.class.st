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
YrMethodEncodingTest >> testRoundTripStringWithNullCharacter [
	"Test this weird thing that happens in AJx86Assembler>>syscall in many Pharo versions, like 30465"

	| method encoding encoded decoded |
	method :=
		FiMethod 
			sourceCode: 
'fortyTwo
	"', 
	{Character null},
	'"

	^ 42' 
			protocol: #'number declaration'.
	
	encoding := YrMethodEncoding new.
	encoded := encoding stringFor: method.
	decoded := encoding objectFrom: encoded.
	
	self deny: (decoded = method).
	self assert: decoded sourceCode equals: (method sourceCode copyWithout: Character null).
	
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
