Class {
	#name : #FiMonticelloMarshaler,
	#superclass : #Object,
	#category : #FicusMonticello
}

{ #category : #marshaling }
FiMonticelloMarshaler >> marshaled: aMCSnapshot [
	
	| run |
	run := FiMarshalingVisitor new.
	
	aMCSnapshot definitions do: [ :each | each accept: run ].
	
	^ run result
]
