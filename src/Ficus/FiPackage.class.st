Class {
	#name : #FiPackage,
	#superclass : #FiShot,
	#instVars : [
		'theName',
		'contents'
	],
	#category : #'Ficus-Model-Meta'
}

{ #category : #accessing }
FiPackage >> contents [
	
	^ contents
]

{ #category : #accessing }
FiPackage >> contents: anObject [
	
	contents := anObject
]

{ #category : #accessing }
FiPackage >> theName [
	
	^ theName
]

{ #category : #accessing }
FiPackage >> theName: anObject [
	
	theName := anObject
]
