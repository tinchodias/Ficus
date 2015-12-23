Extension { #name : #RFiObject }

{ #category : #'*FicusImpact' }
RFiObject >> ficusAllDependencies [
	
	^ self ficusDependencies
]

{ #category : #'*FicusImpact' }
RFiObject >> ficusDependencies [
	
	^ self ficusRequisites collect: [ :each |
		RFiRequisiteInterpreter new 
			dependencyOf: each 
			in: self ]
]

{ #category : #'*FicusImpact' }
RFiObject >> ficusInterpretedDependencies [

	^ (self ficusDependencies collect: #asRFiInterpretedDependency) asFiSet
]
