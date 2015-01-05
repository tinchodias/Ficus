Extension { #name : #FiRGObject }

{ #category : #'*FicusImpact' }
FiRGObject >> ficusDependencyInterpretations [
	
	^ self ficusRequisites collect: [ :each |
		FiDependencyInterpreter new 
			interpretationOf: each 
			in: self ]
]
