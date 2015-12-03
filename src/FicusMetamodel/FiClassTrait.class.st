"
I represent a class trait i.e., a trait for the class side
"
Class {
	#name : #FiClassTrait,
	#superclass : #FiAbstractTrait,
	#category : #'FicusMetamodel-Core'
}

{ #category : #'instance creation' }
FiClassTrait class >> named: aString [ 
	^ self new
		name: aString;
		yourself
		
]

{ #category : #printing }
FiClassTrait >> definition [

	^ String
		streamContents: [ :stream | 
			stream
				nextPutAll: 'ClassTrait';
				crtab;
				nextPutAll: 'uses: ';
				nextPutAll: traitComposition ]
]

{ #category : #testing }
FiClassTrait >> isMeta [

	^ true
]

{ #category : #printing }
FiClassTrait >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
	self name printOn: aStream.
	aStream nextPut: $).
	
]
