"
I represent a bits FiBehavior's layout.
"
Class {
	#name : #FiBitsLayout,
	#superclass : #FiLayout,
	#instVars : [
		'isWords'
	],
	#category : #'FicusMetamodel-Core'
}

{ #category : #'initialize - release' }
FiBitsLayout >> initialize [
	super initialize.
	isWords := false
]

{ #category : #testing }
FiBitsLayout >> isBitsLayout [

	^ true
]

{ #category : #testing }
FiBitsLayout >> isBytesLayout [

	^ isWords not
]

{ #category : #accessing }
FiBitsLayout >> isWords [

	^ isWords
]

{ #category : #testing }
FiBitsLayout >> isWordsLayout [

	^ isWords
]
