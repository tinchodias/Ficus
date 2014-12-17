Extension { #name : #RBClass }

{ #category : #'*FicusRing-override' }
RBClass >> realName: aSymbol [ 
	self realClass: (model environment at: aSymbol)
]
