Extension { #name : #FiMethodSpot }

{ #category : #'*FicusMonticelloYrupe' }
FiMethodSpot >> asYrupeFilePath [

	^ String streamContents: [ :aStream |
		aStream
			nextPutAll: self asBehaviorSpot asYrupeFilePath;
			nextPut: $/;
			nextPutAll: (FiSet new yrupeDefaultEncoder filenameFor: 'methods');
			nextPut: $/;
			nextPutAll: (FiMethod new yrupeDefaultEncoder filenameFor: selector).
		]

]
