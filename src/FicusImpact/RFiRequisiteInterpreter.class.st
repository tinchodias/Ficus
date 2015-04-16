Class {
	#name : #RFiRequisiteInterpreter,
	#superclass : #Object,
	#category : #'FicusImpact-Dependencies'
}

{ #category : #public }
RFiRequisiteInterpreter >> dependencyOf: aRequisite in: aFiRGObject [

	self flag: #todo.
	
	(aRequisite isKindOf: RFiMessageSend) ifTrue: [ 
		^ self dependencyOfMessageSend: aRequisite in: aFiRGObject ].

	(aRequisite isKindOf: RFiVariableAccess) ifTrue: [	
		^ self dependencyOfVariableAccess: aRequisite in: aFiRGObject ].

	(aRequisite isKindOf: RFiInheritanceDeclaration) ifTrue: [	
		^ self dependencyOfInheritanceDeclaration: aRequisite in: aFiRGObject ].

	self shouldBeImplemented.
]

{ #category : #public }
RFiRequisiteInterpreter >> dependencyOfInheritanceDeclaration: aRequisite in: aFiRGObject [
	
	^ aFiRGObject environment 
		at: aRequisite theClassName
		ifPresent: [ :foundClass | RFiInheritance builder target: foundClass; new ]
		ifAbsent: [ RFiInheritance notFound ]
]

{ #category : #public }
RFiRequisiteInterpreter >> dependencyOfMessageSend: aRequisite in: aFiRGMethod [
	
	| possibleInvocations |
	possibleInvocations := 
		aRequisite receiver 
			implementorsOf: aRequisite selector 
			in: aFiRGMethod.

	^ RFiPossibleMethodInvocation methods: possibleInvocations
]

{ #category : #public }
RFiRequisiteInterpreter >> dependencyOfVariableAccess: aRequisite in: aFiRGObject [
	
	^ aFiRGObject 
		lookupVariableNamed: aRequisite variableName 
		ifFound: [ :variable | 
			RFiVariableBinding builder 
				target: variable;
				new ]
		ifNotFound: [ RFiVariableBinding undeclared ]
]
