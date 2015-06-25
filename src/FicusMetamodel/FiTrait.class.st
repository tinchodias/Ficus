"
I represent a trait.
"
Class {
	#name : #FiTrait,
	#superclass : #FiAbstractTrait,
	#instVars : [
		'category',
		'comment',
		'name',
		'classTrait'
	],
	#category : #'FicusMetamodel-Core'
}

{ #category : #'instance creation' }
FiTrait class >> named: aString [ 
	^ self new
		name: aString;
		yourself
		
]

{ #category : #accessing }
FiTrait >> category [

	^ category
]

{ #category : #accessing }
FiTrait >> classTrait [

	^ classTrait
]

{ #category : #accessing }
FiTrait >> comment [

	^ comment
]

{ #category : #accessing }
FiTrait >> defaultStep [

	^ name asSymbol
]

{ #category : #printing }
FiTrait >> definition [
	"Answer a String that defines the receiver"

	^ String
		streamContents: [ :stream | 
			stream
				nextPutAll: 'Trait named: ';
				store: name.
			stream
				cr;
				tab;
				nextPutAll: 'uses: ';
				nextPutAll: traitComposition.
			stream
				cr;
				tab;
				nextPutAll: 'category: ';
				store: category ]
]

{ #category : #initialize }
FiTrait >> initialize [

	super initialize.

	name := nil.
	category := nil.
	comment := ''.
]

{ #category : #accessing }
FiTrait >> name [
	
	^ name
]

{ #category : #printing }
FiTrait >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
	self name printOn: aStream.
	aStream nextPut: $).
	
]
