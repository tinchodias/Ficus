Extension { #name : #MCWorkingCopy }

{ #category : #'*FicusMonticello' }
MCWorkingCopy >> ficusDifferenceRelativeToRepository: aRepository [

	| snapshotA shotA snapshotB shotB |
	snapshotA := self closestAncestorSnapshotIn: aRepository.
	snapshotB := self completeSnapshot.

	shotA := self ficusPackageWith: snapshotA.	
	shotB := self ficusPackageWith: snapshotB.	

	^ shotB differenceFrom: shotA.

]

{ #category : #'*FicusMonticello' }
MCWorkingCopy >> ficusPackage [

	^ self ficusPackageWith: self completeSnapshot
]

{ #category : #'*FicusMonticello' }
MCWorkingCopy >> ficusPackageWith: aMCSnapshot [

	^ FiMonticelloMarshaler new 
		marshaled: aMCSnapshot
		name: self packageName
]
