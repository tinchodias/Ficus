Class {
	#name : #RFiDependency,
	#superclass : #FiFixedObject,
	#instVars : [
		'requisite',
		'targets',
		'source'
	],
	#category : #'FicusImpact-Model'
}

{ #category : #'instance creation' }
RFiDependency class >> requisite: aRequisite source: aRFiObject targets: someTargets [

	^ self basicNew 
		initializeWithRequisite: aRequisite
		source: aRFiObject
		targets: someTargets;
		yourself
]

{ #category : #converting }
RFiDependency >> asRFiInterpretedDependency [

	| objectByName |
	objectByName := Dictionary new.
	self targets do: [ :target | 
		objectByName 
			at: target shortPrintString
			put: target ficusObject ].
	
	^ RFiInterpretedDependency builder
		requisite: self requisite;
		targets: objectByName asFiDictionary;
		new
]

{ #category : #accessing }
RFiDependency >> defaultStep [

	^ requisite shortPrintString
]

{ #category : #'as yet unclassified' }
RFiDependency >> initializeWithRequisite: req source: src targets: tg [ 
	
	super initialize.
	
	requisite := req.
	source := src.
	targets := tg.
]

{ #category : #accessing }
RFiDependency >> requisite [

	^ requisite
]

{ #category : #accessing }
RFiDependency >> source [

	^ source
]

{ #category : #accessing }
RFiDependency >> targets [

	^ targets
]
