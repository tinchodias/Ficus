Class {
	#name : #FiRequisiteInterpreter,
	#superclass : #Object,
	#category : #'FicusImpact-Dependencies'
}

{ #category : #public }
FiRequisiteInterpreter >> dependencyOf: aRequisite in: aFiRGObject [

	self flag: #todo.
	
	(aRequisite isKindOf: FiMessageSend) ifTrue: [ 
		^ self dependencyOfMessageSend: aRequisite in: aFiRGObject ].

	(aRequisite isKindOf: FiVariableAccess) ifTrue: [	
		^ self dependencyOfVariableAccess: aRequisite in: aFiRGObject ].

	(aRequisite isKindOf: FiInheritanceDeclaration) ifTrue: [	
		^ self dependencyOfInheritanceDeclaration: aRequisite in: aFiRGObject ].

	(aRequisite isKindOf: FiMethodOwnerDeclaration) ifTrue: [	
		^ self dependencyOfMethodOwnerDeclaration: aRequisite in: aFiRGObject ].
		
	self shouldBeImplemented.
]

{ #category : #public }
FiRequisiteInterpreter >> dependencyOfInheritanceDeclaration: aRequisite in: aFiRGObject [
	
	^ aFiRGObject environment 
		at: aRequisite theClassName
		ifPresent: [ :foundClass | FiInheritance builder target: foundClass; new ]
		ifAbsent: [ FiInheritance notFound ]
]

{ #category : #public }
FiRequisiteInterpreter >> dependencyOfMessageSend: aRequisite in: aFiRGMethod [
	
	| possibleInvocations |
	possibleInvocations := 
		aRequisite receiver 
			implementorsOf: aRequisite selector 
			in: aFiRGMethod.

	^ FiPossibleMethodInvocation methods: possibleInvocations
]

{ #category : #public }
FiRequisiteInterpreter >> dependencyOfMethodOwnerDeclaration: aFiMethodOwnerDeclaration in: aFiRGMethod [ 
	
	^ FiMethodOwner builder 
		target: aFiRGMethod methodClass;
		new

]

{ #category : #public }
FiRequisiteInterpreter >> dependencyOfVariableAccess: aRequisite in: aFiRGObject [
	
	^ aFiRGObject 
		lookupVariableNamed: aRequisite variableName 
		ifFound: [ :variable | 
			FiVariableBinding builder 
				target: variable;
				new ]
		ifNotFound: [ FiVariableBinding undeclared ]
]
