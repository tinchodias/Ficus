"
I represent a method.
"
Class {
	#name : #FiMethod,
	#superclass : #FiFixedObject,
	#instVars : [
		'protocol',
		'sourceCode',
		'selector'
	],
	#category : #'FicusMetamodel-Core'
}

{ #category : #accessing }
FiMethod class >> excludedInstanceVariableNamesForSteps [

	^ super excludedInstanceVariableNamesForSteps copyWith: #selector
]

{ #category : #'instance creation' }
FiMethod class >> sourceCode: aSourceCode [
	
	^ self
		sourceCode: aSourceCode
		protocol: #'as yet unclassified'
]

{ #category : #'instance creation' }
FiMethod class >> sourceCode: aSourceCode protocol: aProtocol [
	
	^ self basicNew
		initializeWithSourceCode: aSourceCode
		protocol: aProtocol;
		yourself
]

{ #category : #accessing }
FiMethod >> defaultStep [

	^ self selector
]

{ #category : #initialization }
FiMethod >> initializeWithSourceCode: aSourceCode protocol: aProtocol [

	super initialize.
	
	sourceCode := aSourceCode.
	protocol := aProtocol.
]

{ #category : #printing }
FiMethod >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
	self selector printOn: aStream.
	aStream nextPut: $).
	
]

{ #category : #accessing }
FiMethod >> privateSourceCode [
	
	^ sourceCode
]

{ #category : #accessing }
FiMethod >> protocol [
	
	^ protocol
]

{ #category : #accessing }
FiMethod >> selector [

	self flag: #fix. "Horrible! Keep as a step instead of calculating it?"

	^ selector ifNil: [
		selector := [ RBParser parseMethodPattern: self sourceCode ]
			on: SyntaxErrorNotification 
			do: [ :error | ('_unparsed_selector_', self hash printStringHex) asSymbol ].
		]
]

{ #category : #accessing }
FiMethod >> sourceCode [
	
	^ sourceCode asString
]

{ #category : #accessing }
FiMethod >> valueAt: step ifPresent: presentBlock ifAbsent: absentBlock [
	"I'm needed because the slot 'sourceCode' can hold a FiRemoteString, thus the accessor has to be used."

	step == #sourceCode ifTrue: [ ^ self sourceCode ].
	step == #protocol ifTrue: [ ^ self protocol ].
	
	^ super valueAt: step ifPresent: presentBlock ifAbsent: absentBlock
]
