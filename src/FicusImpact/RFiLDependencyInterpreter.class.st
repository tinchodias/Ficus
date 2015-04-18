Class {
	#name : #RFiLDependencyInterpreter,
	#superclass : #Object,
	#instVars : [
		'targetsCallback',
		'entity',
		'methodVisitor'
	],
	#category : #'FicusImpact-LGraph'
}

{ #category : #private }
RFiLDependencyInterpreter >> entity: aRFiObject [

	entity := aRFiObject
]

{ #category : #private }
RFiLDependencyInterpreter >> messageSendTo: aReceiver of: aSelector [

	(aReceiver 
		implementorsOf: aSelector 
		in: entity)
		do: targetsCallback
]

{ #category : #private }
RFiLDependencyInterpreter >> methodVisitor [
	
	^ methodVisitor ifNil: [ methodVisitor := RFiLMethodVisitor new ]
]

{ #category : #public }
RFiLDependencyInterpreter >> run [
	
	self flag: #todo. "fix"
	
	entity isCompiledMethod
		ifTrue: [ ^ self runOnMethod ].
		
	self notYetImplemented 
]

{ #category : #private }
RFiLDependencyInterpreter >> runOnMethod [

	self methodVisitor
		collector: self;
		visitMethod: entity.
]

{ #category : #private }
RFiLDependencyInterpreter >> targetsCallback: aBlockClosure [ 

	targetsCallback := aBlockClosure 
]

{ #category : #private }
RFiLDependencyInterpreter >> variableAccess: aName [

	entity
		lookupVariableNamed: aName 
		ifFound: [ :target | targetsCallback value: target ]
		ifNotFound: [ self flag: #todo. "Undeclared!" ]

]
