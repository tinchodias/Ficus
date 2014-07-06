Class {
	#name : #FiDependencyInterpreter,
	#superclass : #Object,
	#category : #'FicusImpact-Interpretations'
}

{ #category : #public }
FiDependencyInterpreter >> interpretationOf: aDependency in: aFiRGShot [

	(aDependency isKindOf: FiVariableAccess)
		ifFalse: [ self shouldBeImplemented ].
		
	^ aFiRGShot 
		lookupVariableNamed: aDependency variableName 
		ifFound: [ :variable | 
			FiVariableBinding builder 
				target: variable;
				new ]
		ifNotFound: [ FiVariableBinding undeclared ].
]
