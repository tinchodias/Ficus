"
I am an item for the FiInspector.
"
Class {
	#name : #FiInspectorItem,
	#superclass : #Object,
	#instVars : [
		'path',
		'content'
	],
	#category : #'FicusStore-UI-Others'
}

{ #category : #accessing }
FiInspectorItem >> children [

	content isFiObject ifFalse: [ ^ #() ].
	
	^ (content stepsAndValues sorted: [ :a :b | a key < b key ]) 
			collect: [ :stepAndValue |
				FiInspectorItem new 
					path: path / stepAndValue key;
					content: stepAndValue value;
					yourself ]
]

{ #category : #accessing }
FiInspectorItem >> content [
	^ content
]

{ #category : #accessing }
FiInspectorItem >> content: anObject [
	content := anObject
]

{ #category : #accessing }
FiInspectorItem >> path [
	^ path
]

{ #category : #accessing }
FiInspectorItem >> path: anObject [
	path := anObject
]

{ #category : #accessing }
FiInspectorItem >> step [
	
	^ path step
]
