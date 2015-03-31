Class {
	#name : #FiLDependencyInterpreter,
	#superclass : #Object,
	#instVars : [
		'targetsCallback',
		'entity',
		'methodVisitor'
	],
	#category : #'FicusImpact-LGraph'
}

{ #category : #private }
FiLDependencyInterpreter >> entity: aFiRGObject [

	entity := aFiRGObject
]

{ #category : #private }
FiLDependencyInterpreter >> messageSendTo: aReceiver of: aSelector [

	(aReceiver 
		implementorsOf: aSelector 
		in: entity)
		do: targetsCallback
]

{ #category : #private }
FiLDependencyInterpreter >> methodVisitor [
	
	^ methodVisitor ifNil: [ methodVisitor := FiLMethodVisitor new ]
]

{ #category : #public }
FiLDependencyInterpreter >> run [
	
	self flag: #todo. "fix"
	
	entity isCompiledMethod
		ifTrue: [ ^ self runOnMethod ].
		
	self notYetImplemented 
]

{ #category : #private }
FiLDependencyInterpreter >> runOnMethod [

	self methodVisitor
		collector: self;
		visitMethod: entity.
]

{ #category : #private }
FiLDependencyInterpreter >> targetsCallback: aBlockClosure [ 

	targetsCallback := aBlockClosure 
]

{ #category : #private }
FiLDependencyInterpreter >> variableAccess: aName [

	entity
		lookupVariableNamed: aName 
		ifFound: [ :target | targetsCallback value: target ]
		ifNotFound: [ self flag: #todo. "Undeclared!" ]

]
