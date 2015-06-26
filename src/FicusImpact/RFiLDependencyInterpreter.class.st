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
		
	(entity isTrait and: [ entity isInstanceSide ])
		ifTrue: [ ^ self runOnTrait ].

]

{ #category : #private }
RFiLDependencyInterpreter >> runOnClass [

	entity traits do: targetsCallback.
		
	entity superclass ifNil: [ ^ self ].
	targetsCallback value: entity superclass.
]

{ #category : #private }
RFiLDependencyInterpreter >> runOnMethod [

	methodVisitor
		collector: self;
		visitMethod: entity.
]

{ #category : #'as yet unclassified' }
RFiLDependencyInterpreter >> runOnTrait [
	
	entity traits do: targetsCallback.
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
