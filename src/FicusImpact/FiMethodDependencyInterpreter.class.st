Class {
	#name : #FiMethodDependencyInterpreter,
	#superclass : #Object,
	#category : #'FicusImpact-Interpretations'
}

{ #category : #public }
FiMethodDependencyInterpreter >> interpretationOf: aDependency in: aRingShot [

	(aDependency isKindOf: FiMessageSend) ifTrue: [ 
		| possibleInvocations |
		possibleInvocations := 
			aDependency receiver 
				implementorsOf: aDependency selector 
				in: aRingShot environment.

		^ FiPossibleMethodInvocation builder
			methods: (FiSet withValues: possibleInvocations);
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
