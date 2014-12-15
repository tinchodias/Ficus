Class {
	#name : #FiSuperMessageReceiver,
	#superclass : #FiMessageReceiver,
	#category : #'FicusImpact-Dependencies'
}

{ #category : #lookup }
FiSuperMessageReceiver >> implementorsOf: aSelector in: aFiRGMethod [

	^ aFiRGMethod environment
		implementorsOf: aSelector 
		inSuperclassesOf: aFiRGMethod methodClass
]

{ #category : #printing }
FiSuperMessageReceiver >> shortPrintString [

	^ 'super'
]
