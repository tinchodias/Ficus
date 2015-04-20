Class {
	#name : #RFiRequisiteInterpreter,
	#superclass : #Object,
	#category : #'FicusImpact-Interpreting'
}

{ #category : #public }
RFiRequisiteInterpreter >> dependencyOf: aRequisite in: aRFiObject [

	^ RFiDependency 
		requisite: aRequisite 
		source: aRFiObject
		targets: (self targetsOf: aRequisite in: aRFiObject) asFiSet
]

{ #category : #public }
RFiRequisiteInterpreter >> targetsOf: aRequisite in: aRFiObject [

	self flag: #todo.
	
	(aRequisite isKindOf: RFiMessageSend) ifTrue: [ 
		^ self targetsOfMessageSend: aRequisite in: aRFiObject ].

	(aRequisite isKindOf: RFiVariableAccess) ifTrue: [	
		^ self targetsOfVariableAccess: aRequisite in: aRFiObject ].

	(aRequisite isKindOf: RFiInheritanceDeclaration) ifTrue: [	
		^ self targetsOfInheritanceDeclaration: aRequisite in: aRFiObject ].

	self shouldBeImplemented.
]

{ #category : #public }
RFiRequisiteInterpreter >> targetsOfInheritanceDeclaration: aRequisite in: aRFiObject [
	
	^ aRFiObject environment 
		at: aRequisite theClassName
		ifPresent: [ :foundClass | { foundClass } ]
		ifAbsent: [ #() ]
]

{ #category : #public }
RFiRequisiteInterpreter >> targetsOfMessageSend: aRequisite in: aRFiMethod [
	
	^ aRequisite receiver 
		implementorsOf: aRequisite selector 
		in: aRFiMethod
]

{ #category : #public }
RFiRequisiteInterpreter >> targetsOfVariableAccess: aRequisite in: aRFiObject [
	
	^ aRFiObject 
		lookupVariableNamed: aRequisite variableName 
		ifFound: [ :variable | { variable } ]
		ifNotFound: [ #() ]
]
