Extension { #name : #Object }

{ #category : #'*Ficus-Updates' }
Object >> changeFrom: other [

	^ self = other 
		ifTrue: [ FiNoChange new ]
		ifFalse: [ 
			FiReplacement builder
				oldValue: other;
				newValue: self;
				new ]
]

{ #category : #'*Ficus-Updates' }
Object >> changeOfReplaceBy: newValue [ 
	
	^ FiReplacement builder
		oldValue: self;
		newValue: newValue;
		new
]

{ #category : #'*Ficus-Updates' }
Object >> defaultStep [
	"Answer a default value, a kind of suggestion to use it as step."
	
	^ self asString asSymbol
]

{ #category : #'*Ficus-Updates' }
Object >> editFromSimpleChange: aSimpleChange [ 
	"Convert as edit, assuming the change applies to myself."
	
	self assert: aSimpleChange children isEmpty.
	
	aSimpleChange
		ifAdd: [ ] 
		ifRemove: [ ] 
		ifUpdate: [ ^ self editReplaceBy: aSimpleChange newValue ].

	^ self error: 'Should not happen'
]

{ #category : #'*Ficus-Updates' }
Object >> editReplaceBy: aValue [

	^ FiEqual value: aValue
]

{ #category : #'*Ficus-Updates' }
Object >> ficusDeepCollect: aBlock basePath: aPath [

	^ aBlock 
		value: self 
		value: aPath 
		value: #()
]

{ #category : #'*Ficus-Updates' }
Object >> ficusDeepDo: aBlock basePath: aPath [

	^ aBlock 
		value: self 
		value: aPath
]

{ #category : #'*Ficus-Updates' }
Object >> resultOf: anEdit [ 

	^ anEdit resultOn: self
]

{ #category : #'*Ficus-Updates' }
Object >> resultOfSubEdit: aSubEdit steps: aCollection [ 
	
	self assert: aCollection isEmpty.
	
	^ self resultOf: aSubEdit edit
]
