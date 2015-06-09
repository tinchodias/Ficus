Extension { #name : #FiEnvironment }

{ #category : #'*EpiceaFicus' }
FiEnvironment >> checkMethodEdit: aFiMethodEdit [ 
	
	self packages 
		valueAt: aFiMethodEdit packageName
		ifPresent: [ :package | 
			package contents 
				valueAt: aFiMethodEdit hostName 
				ifPresent: [ :x | "OK" ] 
				ifAbsent: [ self error: 'Class or trait not found' ] ]
		ifAbsent: [ self error: 'Package not found' ].

]

{ #category : #'*EpiceaFicus' }
FiEnvironment >> resultOfClassCreation: aFiClassCreation [ 

	| newPackage |
	newPackage := self packages 
		valueAt: aFiClassCreation packageName
		ifPresent: [ :package | 
			package resultOf: 
				(package 
					editAt: #contents 
					do: [ :set | set editInclude: aFiClassCreation newClass]) ]
		ifAbsent: [ 
			FiPackage builder
				name: aFiClassCreation packageName asSymbol;
				contents: { aFiClassCreation newClass } asFiSet;
				new ].
	
	^ self resultOf:
		(self 
			editAt: #packages 
			do: [ :set | set editInclude: newPackage ])
]

{ #category : #'*EpiceaFicus' }
FiEnvironment >> resultOfMethodCreation: aFiMethodCreation [ 

	| path |
	self checkMethodEdit: aFiMethodCreation.
		
	path := FiPath root / #packages / aFiMethodCreation packageName / #contents / aFiMethodCreation hostName. 
	path := 
		aFiMethodCreation isMetaSide
			ifTrue: [ path / #metaclass / #methods ]
			ifFalse: [ path / #methods ].		
		
	^ self resultOf: 
		(FiSubEdit 
			path: path
			edit: (FiInclude value: aFiMethodCreation newMethod))
]

{ #category : #'*EpiceaFicus' }
FiEnvironment >> resultOfMethodUpdate: aFiMethodUpdate [ 
	
	| path |
	self checkMethodEdit: aFiMethodUpdate.
		
	path := FiPath root / #packages / aFiMethodUpdate packageName / #contents / aFiMethodUpdate hostName. 
	path := 
		aFiMethodUpdate isMetaSide
			ifTrue: [ path / #metaclass / #methods ]
			ifFalse: [ path / #methods ].		
	path := path / aFiMethodUpdate selector.
		
	^ self resultOf: 
		(FiSubEdit 
			path: path
			edit: aFiMethodUpdate edit)
]
