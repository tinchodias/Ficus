Extension { #name : #RBMetaclass }

{ #category : #'*FicusRing-override' }
RBMetaclass >> realName: aSymbol [ 
	self realClass: (model environment at: aSymbol ifAbsent: [ self error ]) theMetaClass
]
