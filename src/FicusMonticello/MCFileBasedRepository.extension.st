Extension { #name : #MCFileBasedRepository }

{ #category : #'*FicusMonticello' }
MCFileBasedRepository >> fileNamesForPackageNamed: packageName [ 

	^ Array streamContents: [ :stream | 
		self allFileNamesOrCache do: [ :aFileName | 
			(aFileName copyUpToLast: $-) = packageName ifTrue: [ stream nextPut: aFileName ] ] ]
]
