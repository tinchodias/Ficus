Class {
	#name : #FiDictionaryEffect,
	#superclass : #FiEditEffect,
	#instVars : [
		'key'
	],
	#category : #'Ficus-Model-Effects'
}

{ #category : #printing }
FiDictionaryEffect >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: key;
		nextPut: $).
]
