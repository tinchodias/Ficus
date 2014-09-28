Extension { #name : #Object }

{ #category : #'*Ficus' }
Object >> asFicusPath [
	
	^ FiPath root / self
]

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
Object >> effectOfReplace: oldValue [ 
	
	^ FiReplacement builder
		oldValue: oldValue;
		newValue: self;
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
Object >> noEdit [
	
	^ FiNoEdit new
]

{ #category : #'*Ficus' }
Object >> replaceBy: aValue [

	^ FiEqual value: aValue
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
