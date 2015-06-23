Class {
	#name : #FiDictionaryChange,
	#superclass : #FiChange,
	#instVars : [
		'key'
	],
	#category : #'FicusExtras-Model-Core-Changes'
}

{ #category : #printing }
FiDictionaryChange >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: key;
		nextPut: $).
]
