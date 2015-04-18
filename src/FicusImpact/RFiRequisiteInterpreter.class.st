Class {
	#name : #RFiRequisiteInterpreter,
	#superclass : #Object,
	#category : #'FicusImpact-Dependencies'
}

{ #category : #public }
RFiRequisiteInterpreter >> dependencyOf: aRequisite in: aRFiObject [

	self flag: #todo.
	
	(aRequisite isKindOf: RFiMessageSend) ifTrue: [ 
		^ self dependencyOfMessageSend: aRequisite in: aRFiObject ].

	(aRequisite isKindOf: RFiVariableAccess) ifTrue: [	
		^ self dependencyOfVariableAccess: aRequisite in: aRFiObject ].

	(aRequisite isKindOf: RFiInheritanceDeclaration) ifTrue: [	
		^ self dependencyOfInheritanceDeclaration: aRequisite in: aRFiObject ].

	self shouldBeImplemented.
]

{ #category : #public }
RFiRequisiteInterpreter >> dependencyOfInheritanceDeclaration: aRequisite in: aRFiObject [
	
	^ aRFiObject environment 
		at: aRequisite theClassName
		ifPresent: [ :foundClass | RFiInheritance builder target: foundClass; new ]
		ifAbsent: [ RFiInheritance notFound ]
]

{ #category : #public }
RFiRequisiteInterpreter >> dependencyOfMessageSend: aRequisite in: aRFiMethod [
	
	| possibleInvocations |
	possibleInvocations := 
		aRequisite receiver 
			implementorsOf: aRequisite selector 
			in: aRFiMethod.

	^ RFiPossibleMethodInvocation methods: possibleInvocations
]

{ #category : #public }
RFiRequisiteInterpreter >> dependencyOfVariableAccess: aRequisite in: aRFiObject [
	
	^ aRFiObject 
		lookupVariableNamed: aRequisite variableName 
		ifFound: [ :variable | 
			RFiVariableBinding builder 
				target: variable;
				new ]
		ifNotFound: [ RFiVariableBinding undeclared ]
]
