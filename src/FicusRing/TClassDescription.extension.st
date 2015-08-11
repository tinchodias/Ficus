Extension { #name : #TClassDescription }

{ #category : #'*FicusRing' }
TClassDescription >> authors [
	"Returns a bag representing the author frequency based on the latest version of the methods of the receiver."

	^(self methods, self classSide methods) collect: [ :each | each author ] as: Bag .
	
	
]

{ #category : #'*FicusRing' }
TClassDescription >> linesOfCode [ 
	"An approximate measure of lines of code.
	Includes comments, but excludes blank lines."
	| lines |
	lines := self localMethods inject: 0 into: [:sum :each | sum + each linesOfCode]. 
	^ self isMeta 
		ifTrue: [lines]
		ifFalse: [lines + self classSide linesOfCode]
]

{ #category : #'*FicusRing' }
TClassDescription >> numberOfMethods [
	"count all methods that are local (not comming from a trait)"
	| num |
	num := self localMethods size.
	^ self isMeta  
		ifTrue: [ num ]
		ifFalse: [ num + self classSide numberOfMethods ] 
]
