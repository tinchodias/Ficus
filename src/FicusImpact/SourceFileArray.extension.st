Extension { #name : #SourceFileArray }

{ #category : #'*FicusImpact' }
SourceFileArray >> readOnlyCopy [

	^ self collect: [:aFile | aFile ifNotNil: [ aFile readOnlyCopy ] ]
]
