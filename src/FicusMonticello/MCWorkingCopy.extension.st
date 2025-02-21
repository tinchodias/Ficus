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

	^ FiMonticelloWriter new 
		written: aMCSnapshot
		name: self packageName
]

{ #category : #'*FicusMonticello' }
MCWorkingCopy >> silentlyNewVersionIn: aRepository snapshot: aSnapshot [

	^ (self requestVersionNameAndMessageWithSuggestion: (self uniqueVersionNameIn: aRepository)) 
		ifNotNil: [:pair |
			self 
				silentlyNewVersionWithName: pair first trimBoth 
				message: pair last 
				in: aRepository
				snapshot: aSnapshot ].

]

{ #category : #'*FicusMonticello' }
MCWorkingCopy >> silentlyNewVersionWithName: nameString message: messageString in: aRepository snapshot: aSnapshot [	
	
	| info deps |
	info := ancestry infoWithName: nameString message: messageString.
	ancestry := MCWorkingAncestry new addAncestor: info.
	
	deps := self collectDependenciesWithMessage: messageString in: aRepository.
	
	^ MCVersion
		package: package
		info: info
		snapshot: aSnapshot
		dependencies: deps
]
