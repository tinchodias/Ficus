Class {
	#name : #FiMethodOwnerDeclaration,
	#superclass : #FiRequisite,
	#instVars : [
		'theNonMetaSideName',
		'isMeta'
	],
	#classInstVars : [
		'aStream'
	],
	#category : #'FicusImpact-Requisites'
}

{ #category : #'instance creation' }
FiMethodOwnerDeclaration class >> named: aString [

	^ self named: aString isMeta: false
]

{ #category : #'instance creation' }
FiMethodOwnerDeclaration class >> named: aString isMeta: aBoolean [

	^ FiMethodOwnerDeclaration builder
		theNonMetaSideName: aString;
		isMeta: aBoolean;
		new
]

{ #category : #accessing }
FiMethodOwnerDeclaration >> isMeta [
	
	^ isMeta
]

{ #category : #printing }
FiMethodOwnerDeclaration >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: theNonMetaSideName asString.
	
	isMeta ifTrue: [
		aStream print: ' class' ].
		
	aStream
		nextPut: $).
]

{ #category : #accessing }
FiMethodOwnerDeclaration >> theNonMetaSideName [
	
	^ theNonMetaSideName
]
