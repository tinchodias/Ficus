Extension { #name : #Object }

{ #category : #'*Ficus' }
Object >> changeFrom: other [

	^ self = other 
		ifTrue: [ FiNoChange new ]
		ifFalse: [ 
			FiReplacement builder
				oldValue: other;
				newValue: self;
				new ]
]

{ #category : #'*Ficus' }
Object >> changeOfReplaceBy: newValue [ 
	
	^ FiReplacement builder
		oldValue: self;
		newValue: newValue;
		new
]

{ #category : #'*Ficus' }
Object >> defaultStep [
	"Answer a default value, a kind of suggestion to use it as step."
	
	^ self asString asSymbol
]

{ #category : #'*Ficus' }
Object >> editFromSimpleChange: aSimpleChange [ 
	"Convert as edit, assuming the change applies to myself."
	
	self assert: aSimpleChange children isEmpty.
	
	aSimpleChange
		ifAdd: [ ] 
		ifRemove: [ ] 
		ifUpdate: [ ^ self editReplaceBy: aSimpleChange newValue ].

	^ self error: 'Should not happen'
]

{ #category : #'*Ficus' }
Object >> editReplaceBy: aValue [

	^ FiEqual value: aValue
]

{ #category : #'*Ficus' }
Object >> ficusDeepCollect: aBlock basePath: aPath [

	^ aBlock 
		value: self 
		value: aPath 
		value: #()
]

{ #category : #'*Ficus' }
Object >> ficusDeepDo: aBlock [

	^ aBlock value: self
]

{ #category : #'*Ficus' }
Object >> ficusDeepDo: aBlock basePath: aPath [

	^ aBlock 
		value: self 
		value: aPath
]

{ #category : #'*Ficus' }
Object >> isFiObject [

	^ false
]

{ #category : #'*Ficus' }
Object >> resultOf: anEdit [ 

	^ anEdit resultOn: self
]

{ #category : #'*Ficus' }
Object >> resultOfSubEdit: aSubEdit steps: aCollection [ 
	
	self assert: aCollection isEmpty.
	
	^ self resultOf: aSubEdit edit
]

{ #category : #'*Ficus' }
Object >> storeOn: aWriteStream indent: anInteger [ 
	
	self storeOn: aWriteStream
]
