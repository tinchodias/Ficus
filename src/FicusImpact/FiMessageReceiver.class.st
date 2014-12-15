Class {
	#name : #FiMessageReceiver,
	#superclass : #FiFixedObject,
	#category : #'FicusImpact-Dependencies'
}

{ #category : #lookup }
FiMessageReceiver >> implementorsOf: aSelector in: aFiRGMethod [

	^ self subclassResponsibility 
]

{ #category : #printing }
FiMessageReceiver >> shortPrintString [

	^ self subclassResponsibility 
]
