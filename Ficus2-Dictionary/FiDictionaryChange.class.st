Class {
	#name : #FiDictionaryChange,
	#superclass : #FiChange,
	#instVars : [
		'key'
	],
	#category : #'Ficus2-Dictionary-Changes'
}

{ #category : #printing }
FiDictionaryChange >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: key;
		nextPut: $).
]
