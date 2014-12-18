Extension { #name : #FiRGObject }

{ #category : #'*FicusImpact' }
FiRGObject >> ficusDependencyInterpretations [
	
	^ self ficusDependencies collect: [ :each |
		FiDependencyInterpreter new 
			interpretationOf: each 
			in: self ]
]
