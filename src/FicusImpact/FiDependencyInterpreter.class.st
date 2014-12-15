Class {
	#name : #FiDependencyInterpreter,
	#superclass : #Object,
	#category : #'FicusImpact-Interpretations'
}

{ #category : #public }
FiDependencyInterpreter >> interpretationOf: aDependency in: aRingShot [

	(aDependency isKindOf: FiMessageSend) ifTrue: [ 
		| possibleInvocations |
		possibleInvocations := 
			aDependency receiver 
				implementorsOf: aDependency selector 
				in: aRingShot environment.

		^ FiPossibleMethodInvocation builder
			methods: possibleInvocations asFiSet;
			new ].

	(aDependency isKindOf: FiVariableAccess) ifTrue: [	
		^ aRingShot 
			lookupVariableNamed: aDependency variableName 
			ifFound: [ :variable | 
				FiVariableBinding builder 
					target: variable;
					new ]
			ifNotFound: [ FiVariableBinding undeclared ] ].
		
	self shouldBeImplemented.
]
