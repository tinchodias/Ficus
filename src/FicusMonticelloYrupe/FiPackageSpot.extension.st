Extension { #name : #FiPackageSpot }

{ #category : #'*FicusMonticelloYrupe' }
FiPackageSpot >> asYrupeFilePath [

	^ String streamContents: [ :aStream |
		aStream
			nextPutAll: FiEnvironmentSpot new asYrupeFilePath;
			nextPut: $/;
			nextPutAll: (FiSet new yrupeDefaultEncoder filenameFor: 'packages');
			nextPut: $/;
			nextPutAll: (FiPackage new yrupeDefaultEncoder filenameFor: packageName) ]
]
