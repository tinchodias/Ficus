Extension { #name : #MCFileBasedRepository }

{ #category : #'*FicusMonticello' }
MCFileBasedRepository >> versionNamesForPackageNamed: packageName [ 
	^ Array streamContents: [ :stream | 
		self allFileNamesOrCache do: [ :mcVersionName | 
			(mcVersionName copyUpToLast: $-) = packageName ifTrue: [ stream nextPut: mcVersionName ] ] ]
]
