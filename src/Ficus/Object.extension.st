Extension { #name : #Object }

{ #category : #'*Ficus' }
Object >> defaultStep [
	"Answer a default value, a kind of suggestion to use it as step."
	
	^ self asString asSymbol
]

{ #category : #'*Ficus' }
Object >> differenceFrom: other [

	^ self = other 
		ifTrue: [ FiNoEffect new ]
		ifFalse: [ 
			FiReplacement builder
				oldValue: other;
				newValue: self;
				new ]
]

{ #category : #'*Ficus' }
Object >> editReplaceBy: aValue [

	^ FiEqual value: aValue
]

{ #category : #'*Ficus' }
Object >> effectOfReplaceBy: newValue [ 
	
	^ FiReplacement builder
		oldValue: self;
		newValue: newValue;
		new
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
Object >> isShot [

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
