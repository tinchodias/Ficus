Extension { #name : #FiRGObject }

{ #category : #'*FicusImpact' }
FiRGObject >> ficusAllDependencies [
	
	^ self ficusDependencies
]

{ #category : #'*FicusImpact' }
FiRGObject >> ficusDependencies [
	
	^ self ficusRequisites collect: [ :each |
		FiRequisiteInterpreter new 
			dependencyOf: each 
			in: self ]
]
