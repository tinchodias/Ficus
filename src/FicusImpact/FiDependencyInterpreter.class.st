Class {
	#name : #FiDependencyInterpreter,
	#superclass : #Object,
	#category : #'FicusImpact-Interpretations'
}

{ #category : #public }
FiDependencyInterpreter >> interpretationOf: aDependency in: aFiRGObject [

	(aDependency isKindOf: FiMessageSend) ifTrue: [ 
		^ self interpretationOfMessageSend: aDependency in: aFiRGObject ].

	(aDependency isKindOf: FiVariableAccess) ifTrue: [	
		^ self interpretationOfVariableAccess: aDependency in: aFiRGObject ].

	(aDependency isKindOf: FiInheritanceDeclaration) ifTrue: [	
		^ self interpretationOfInheritanceDeclaration: aDependency in: aFiRGObject ].
		
	self shouldBeImplemented.
]

{ #category : #public }
FiDependencyInterpreter >> interpretationOfInheritanceDeclaration: aDependency in: aFiRGObject [
	
	^ aFiRGObject environment 
		at: aDependency theClassName
		ifPresent: [ :foundClass | FiInheritance builder target: foundClass; new ]
		ifAbsent: [ FiInheritance notFound ]
]

{ #category : #public }
FiDependencyInterpreter >> interpretationOfMessageSend: aDependency in: aFiRGMethod [
	
	| possibleInvocations |
	possibleInvocations := 
		aDependency receiver 
			implementorsOf: aDependency selector 
			in: aFiRGMethod.

	^ FiPossibleMethodInvocation builder
		methods: possibleInvocations asFiSet;
		new
]

{ #category : #public }
FiDependencyInterpreter >> interpretationOfVariableAccess: aDependency in: aFiRGObject [
	
	^ aFiRGObject 
		lookupVariableNamed: aDependency variableName 
		ifFound: [ :variable | 
			FiVariableBinding builder 
				target: variable;
				new ]
		ifNotFound: [ FiVariableBinding undeclared ]
]
