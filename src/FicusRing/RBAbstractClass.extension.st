Extension { #name : #RBAbstractClass }

{ #category : #'*FicusRing-override' }
RBAbstractClass >> classBinding [
	^ model environment associationAt: self name
]

{ #category : #'*FicusRing' }
RBAbstractClass class >> existingNamed: aSymbol model: aModel [
	^(self named: aSymbol)
		model: aModel;
		realName: aSymbol;
		yourself
]
