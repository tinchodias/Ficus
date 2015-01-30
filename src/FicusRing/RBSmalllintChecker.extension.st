Extension { #name : #RBSmalllintChecker }

{ #category : #'*FicusRing-override' }
RBSmalllintChecker >> run [
	rule resetResultOnEnvironment: environment.
	environment classesAndTraits
		do: [ :class |
			self checkClass: class.
			self checkMethodsForClass: class ]
		displayingProgress: [ :class | 'Running critics on: ', class name ]
]
