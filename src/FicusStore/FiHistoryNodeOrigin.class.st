Class {
	#name : #FiHistoryNodeOrigin,
	#superclass : #FiFixedObject,
	#category : #'FicusStore-Models'
}

{ #category : #inspecting }
FiHistoryNodeOrigin >> ficusInspectorIcon [
	
	^ Smalltalk ui icons glamorousDiveRightIcon
]

{ #category : #testing }
FiHistoryNodeOrigin >> isComposite [

	^ false
]
