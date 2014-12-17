Extension { #name : #RBSmalllintChecker }

{ #category : #'*FicusRing-override' }
RBSmalllintChecker >> run [
	rule resetResult.
	environment classesAndTraits
		do: [ :class |
			self checkClass: class.
			self checkMethodsForClass: class ]
		displayingProgress: [ :class | 'Running critics on: ', class name ]
]
