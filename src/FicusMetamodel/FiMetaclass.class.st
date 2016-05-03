"
I represent a metaclass.
"
Class {
	#name : #FiMetaclass,
	#superclass : #FiBehavior,
	#instVars : [
		'traitComposition'
	],
	#category : #'FicusMetamodel-Core'
}

{ #category : #'instance creation' }
FiMetaclass class >> named: aString [ 
	^ self new
		name: aString;
		yourself
		
]

{ #category : #printing }
FiMetaclass >> definition [
	"Refer to the comment in ClassDescription|definition."

	^ String streamContents: 
		[:strm |
		strm nextPutAll: 'Metaclass'.
		strm
			crtab;
			nextPutAll: 'uses: ';
			print: self traitComposition.
		strm
			crtab;
			nextPutAll: 'instanceVariableNames: ';
			store: self instanceVariablesString]
]

{ #category : #'as yet unclassified' }
FiMetaclass >> hasNullSuperclass [

	^ false
]

{ #category : #initialization }
FiMetaclass >> initialize [

	super initialize.

	traitComposition := '{}'.
]

{ #category : #testing }
FiMetaclass >> isMeta [

	^ true
]

{ #category : #accessing }
FiMetaclass >> traitComposition [
	
	^ traitComposition
]
