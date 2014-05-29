Class {
	#name : #FiExtensionMethods,
	#superclass : #FiShot,
	#instVars : [
		'hostName',
		'methods',
		'isMetaSide'
	],
	#category : #'Ficus-Model-Meta'
}

{ #category : #accessing }
FiExtensionMethods >> defaultStep [

	^ (isMetaSide 
		ifFalse: [ hostName ]
		ifTrue: [ hostName,  ' class' ]) asSymbol
]

{ #category : #accessing }
FiExtensionMethods >> hostName [
	
	^ hostName
]

{ #category : #accessing }
FiExtensionMethods >> hostName: anObject [
	
	hostName := anObject
]

{ #category : #testing }
FiExtensionMethods >> isFicusClass [

	^ false
]

{ #category : #testing }
FiExtensionMethods >> isFicusTrait [

	^ false
]

{ #category : #accessing }
FiExtensionMethods >> isMetaSide [
	^ isMetaSide
]

{ #category : #accessing }
FiExtensionMethods >> isMetaSide: anObject [
	isMetaSide := anObject
]

{ #category : #accessing }
FiExtensionMethods >> methods [
	
	^ methods
]

{ #category : #accessing }
FiExtensionMethods >> methods: anObject [
	
	methods := anObject
]
