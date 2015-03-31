Class {
	#name : #FiLDependencyInterpreter,
	#superclass : #Object,
	#instVars : [
		'targetsCallback',
		'entity'
	],
	#category : #'FicusImpact-LGraph'
}

{ #category : #public }
FiLDependencyInterpreter >> dependencyOfInheritanceDeclaration: aRequisite in: aFiRGObject [
	
	^ aFiRGObject environment 
		at: aRequisite theClassName
		ifPresent: [ :foundClass | FiInheritance builder target: foundClass; new ]
		ifAbsent: [ FiInheritance notFound ]
]

{ #category : #public }
FiLDependencyInterpreter >> dependencyOfMessageSend: aRequisite in: aFiRGMethod [
	
	| possibleInvocations |
	possibleInvocations := 
		aRequisite receiver 
			implementorsOf: aRequisite selector 
			in: aFiRGMethod.

	^ FiPossibleMethodInvocation methods: possibleInvocations
]

{ #category : #public }
FiLDependencyInterpreter >> dependencyOfVariableAccess: aRequisite in: aFiRGObject [
	
	^ aFiRGObject 
		lookupVariableNamed: aRequisite variableName 
		ifFound: [ :variable | 
			FiVariableBinding builder 
				target: variable;
				new ]
		ifNotFound: [ FiVariableBinding undeclared ]
]

{ #category : #'as yet unclassified' }
FiLDependencyInterpreter >> entity: aFiRGObject [

	entity := aFiRGObject
]

{ #category : #'as yet unclassified' }
FiLDependencyInterpreter >> messageSendTo: aReceiver of: aSelector [

	(aReceiver 
		implementorsOf: aSelector 
		in: entity)
		do: targetsCallback
]

{ #category : #'as yet unclassified' }
FiLDependencyInterpreter >> run [
	
	self flag: #todo. "fix"
	
	entity isCompiledMethod
		ifTrue: [ ^ self runOnMethod ].
		
	self notYetImplemented 
]

{ #category : #'as yet unclassified' }
FiLDependencyInterpreter >> runOnMethod [

	FiLMethodVisitor new
		collector: self;
		visitMethod: entity.
]

{ #category : #'as yet unclassified' }
FiLDependencyInterpreter >> targetsCallback: aBlockClosure [ 

	targetsCallback := aBlockClosure 
]

{ #category : #'as yet unclassified' }
FiLDependencyInterpreter >> variableAccess: aName [

	entity
		lookupVariableNamed: aName 
		ifFound: [ :target | targetsCallback value: target ]
		ifNotFound: [ self flag: #todo. "Undeclared!" ]

]
