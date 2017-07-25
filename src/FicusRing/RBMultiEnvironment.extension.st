Extension { #name : #RBMultiEnvironment }

{ #category : #'*FicusRing' }
RBMultiEnvironment >> addClass: aClass into: aValue [ 
	(environmentDictionaries at: aValue ifAbsentPut: [self newSelectorEnvironment]) 
		addClass: aClass
]

{ #category : #'*FicusRing' }
RBMultiEnvironment >> addClass: aClass selector: aSymbol into: aValue [ 
	(environmentDictionaries at: aValue ifAbsentPut: [self newSelectorEnvironment]) 
		addClass: aClass
		selector: aSymbol
]

{ #category : #'*FicusRing' }
RBMultiEnvironment >> asSelectorEnvironment [
	| s |
	s := RBSelectorEnvironment onEnvironment: environment.
	s label: self label.
	environmentDictionaries do: [:each | | env |
			env := each asSelectorEnvironment. 
			env classesDo: [:cls | env selectorsForClass: cls do:  [:sel | s addClass: cls selector: sel]]].
	^ s
	  
]

{ #category : #'*FicusRing' }
RBMultiEnvironment >> newSelectorEnvironment [

	^ RBSelectorEnvironment onEnvironment: environment rootEnvironment
]

{ #category : #'*FicusRing' }
RBMultiEnvironment >> removeClass: aClass into: aValue [ 
	(environmentDictionaries at: aValue ifAbsent: [self newSelectorEnvironment]) 
		removeClass: aClass
]

{ #category : #'*FicusRing' }
RBMultiEnvironment >> removeClass: aClass selector: aSelector into: aValue [ 
	(environmentDictionaries at: aValue ifAbsentPut: [ self newSelectorEnvironment ]) 
		removeClass: aClass
		selector: aSelector
]

{ #category : #'*FicusRing' }
RBMultiEnvironment >> selectEnvironment: aValue [ 

	environment := 
		environmentDictionaries at: aValue
				ifAbsent: [ self newSelectorEnvironment ]
]
