Extension { #name : #CompiledMethod }

{ #category : #'*FicusMonticello' }
CompiledMethod >> fileIndex [

	^SourceFiles fileIndexFromSourcePointer: self sourcePointer
]

{ #category : #'*FicusMonticello' }
CompiledMethod >> filePosition [

	^ SourceFiles filePositionFromSourcePointer: self sourcePointer
]
