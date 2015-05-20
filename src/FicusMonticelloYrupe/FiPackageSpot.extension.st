Extension { #name : #FiPackageSpot }

{ #category : #'*FicusMonticelloYrupe' }
FiPackageSpot >> asYrupeFilePath [

	^ String streamContents: [ :aStream |
		aStream
			nextPutAll: 'contents.tree/';
			nextPutAll: (FiPackage new yrupeDefaultEncoder filenameFor: packageName) ]
]
