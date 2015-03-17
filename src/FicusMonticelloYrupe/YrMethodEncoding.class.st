"
I implement an encoding for FiMethod instances.
"
Class {
	#name : #YrMethodEncoding,
	#superclass : #YrLeafEncoding,
	#category : #'FicusMonticelloYrupe-Encoding'
}

{ #category : #accessing }
YrMethodEncoding class >> id [

	^ 'st'
]

{ #category : #private }
YrMethodEncoding >> objectFrom: aString [

	| firstLineEnd source |
	firstLineEnd := aString indexOf: Character lf.
	source := ((aString copyFrom: firstLineEnd + 1 to: aString size) 
		convertFromWithConverter: UTF8TextConverter new) withSqueakLineEndings.
	
	^ FiMethod 
		sourceCode: source
		protocol: (aString copyFrom: 2 to: firstLineEnd - 2) asSymbol

]

{ #category : #private }
YrMethodEncoding >> stringFor: aFiMethod [

	| source |
	source := aFiMethod sourceCode copy withUnixLineEndings.
	source := [ source convertToWithConverter: UTF8TextConverter new ]
		on: Error
		do: [ :error | (aFiMethod lineNumber: 1), '
	"Yrupe couldn''t encode the original source code"' ].

	^ String streamContents: [ :stream |
		stream 
			nextPut: $";
			nextPutAll: aFiMethod protocol;
			nextPut: $"; 
			lf;
			nextPutAll: source ]
]
