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

{ #category : #'*FicusImpact' }
FiRGObject >> ficusInterpretedDependencies [

	^ (self ficusRequisites collect: [ :each |
		| dependency objectByName |
		dependency := FiRequisiteInterpreter new 
			dependencyOf: each 
			in: self.

		objectByName := Dictionary new.
		dependency targets do: [ :target | 
			objectByName 
				at: target shortPrintString
				put: target ficusObject ].
		
		FiInterpretedDependency builder
			requisite: each;
			targets: objectByName asFiDictionary;
			new
		]) asFiSet
]
