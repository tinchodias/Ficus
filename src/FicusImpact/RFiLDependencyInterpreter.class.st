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

{ #category : #initialization }
RFiLDependencyInterpreter >> initialize [

	super initialize.
	
	methodVisitor := RFiLMethodVisitor new.
]

{ #category : #private }
RFiLDependencyInterpreter >> messageSendTo: aReceiver of: aSelector [

	(aReceiver 
		implementorsOf: aSelector 
		in: entity)
		do: targetsCallback
]

{ #category : #public }
RFiLDependencyInterpreter >> run [
	
	self flag: #todo. "fix ifs..."
	
	entity isCompiledMethod
		ifTrue: [ ^ self runOnMethod ].

	(entity isBehavior and: [ entity isInstanceSide ])
		ifTrue: [ ^ self runOnClass ].
		
	self notYetImplemented 
]

{ #category : #private }
RFiLDependencyInterpreter >> runOnClass [
	
	targetsCallback value: entity superclass.
	self flag: #todo. "value trait composition too"
]

{ #category : #private }
RFiLDependencyInterpreter >> runOnMethod [

	methodVisitor
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
