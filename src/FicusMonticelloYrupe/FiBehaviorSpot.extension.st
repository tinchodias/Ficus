Extension { #name : #FiBehaviorSpot }

{ #category : #'*FicusMonticelloYrupe' }
FiBehaviorSpot >> asYrupeFilePath [

	^ String streamContents: [ :aStream |
		aStream
			nextPutAll: self asPackageSpot asYrupeFilePath;
			nextPut: $/;
			nextPutAll: (FiSet new yrupeDefaultEncoder filenameFor: 'contents');
			nextPut: $/;
			nextPutAll: (FiBehavior new yrupeDefaultEncoder filenameFor: behaviorName).
			
		isMetaSide ifTrue: [
			aStream
				nextPut: $/;
				nextPutAll: (FiMetaclass new yrupeDefaultEncoder filenameFor: 'metaclass').
		] ]

]
