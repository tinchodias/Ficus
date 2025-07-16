Class {
	#name : #FiDictionaryChange,
	#superclass : #FiChange,
	#instVars : [
		'key'
	],
	#category : #'Ficus-Dictionary-Changes'
}

{ #category : #printing }
FiDictionaryChange >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: key;
		nextPut: $).
]
