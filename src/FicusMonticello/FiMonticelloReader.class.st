Class {
	#name : #FiMonticelloReader,
	#superclass : #Object,
	#category : #'FicusMonticello-Writing'
}

{ #category : #private }
FiMonticelloReader >> classInstVarNamesFrom: aFiClass [ 
	
	^ aFiClass metaclass layout instanceVariableNames
]

{ #category : #private }
FiMonticelloReader >> classVarNamesFrom: aFiClass [ 
	
	^ aFiClass classPool values
]

{ #category : #private }
FiMonticelloReader >> instVarNamesFrom: aFiClass [ 

	^ aFiClass layout instanceVariableNames
]

{ #category : #private }
FiMonticelloReader >> monticelloClassDefinitionFrom: aFiClass [ 

	^ MCClassDefinition
		name: aFiClass name
		superclassName: aFiClass superclassName
		traitComposition: aFiClass traitComposition
		classTraitComposition: aFiClass metaclass traitComposition
		category: aFiClass category
		instVarNames: (self instVarNamesFrom: aFiClass)
		classVarNames: (self classVarNamesFrom: aFiClass) 
		poolDictionaryNames: aFiClass sharedPools values
		classInstVarNames: (self classInstVarNamesFrom: aFiClass)
		type: (self typeOfClassFrom: aFiClass)
		comment: aFiClass comment
		commentStamp: ''
]

{ #category : #private }
FiMonticelloReader >> monticelloClassDefinitionsFrom: aFiClass [

	^ Array streamContents: [ :stream | 
		stream 
			nextPut: (self monticelloClassDefinitionFrom: aFiClass);
			nextPutAll: (self monticelloMethodDefinitionsFrom: aFiClass className: aFiClass name classIsMeta: false);
			nextPutAll: (self monticelloMethodDefinitionsFrom: aFiClass metaclass className: aFiClass name classIsMeta: true) ]
]

{ #category : #private }
FiMonticelloReader >> monticelloDefinitionsFrom: aFiPackage [ 

	| definitions |
	definitions := Set new.
	
	self flag: #fix.
	
	aFiPackage contents valuesDo: [ :aFicusShot |
		definitions addAll: 
			(aFicusShot isFicusClass
				ifTrue: [ self monticelloClassDefinitionsFrom: aFicusShot ]
				ifFalse: [ 
					aFicusShot isFicusTrait
						ifTrue: [ self monticelloTraitDefinitionsFrom: aFicusShot ]
						ifFalse: [ self monticelloExtensionMethodDefinitionsFrom: aFicusShot ] ]) ].
	
	^ definitions
]

{ #category : #private }
FiMonticelloReader >> monticelloExtensionMethodDefinitionsFrom: aFiExtensionMethods [ 

	^ aFiExtensionMethods methods values 
		collect: [ :aFicusMethod |
			MCMethodDefinition
				className: aFiExtensionMethods hostName
				classIsMeta: aFiExtensionMethods isMetaSide
				selector: aFicusMethod selector
				category: aFicusMethod protocol
				timeStamp: ''
				source: aFicusMethod sourceCode ]
		as: Array
]

{ #category : #private }
FiMonticelloReader >> monticelloMethodDefinitionsFrom: aFicusBehavior className: className classIsMeta: classIsMeta [

	| methods |
	methods := Set new.

	aFicusBehavior methods valuesDo: [ :aFicusMethod | 
		methods add: 
			(MCMethodDefinition
				className: className
				classIsMeta: classIsMeta
				selector: aFicusMethod selector
				category: aFicusMethod protocol
				timeStamp: ''
				source: aFicusMethod sourceCode) ].
	
	^ methods

]

{ #category : #private }
FiMonticelloReader >> monticelloTraitDefinitionFrom: aFiTrait [

	^ MCTraitDefinition
		name: aFiTrait name
		traitComposition: aFiTrait traitComposition
		category: aFiTrait category
		comment: aFiTrait comment
		commentStamp: ''
]

{ #category : #private }
FiMonticelloReader >> monticelloTraitDefinitionsFrom: aFiTrait [

	self flag: #todo. "fix!"
	
	^ Array streamContents: [ :stream | 
		stream 
			nextPut: (self monticelloTraitDefinitionFrom: aFiTrait);
			nextPutAll: (self monticelloMethodDefinitionsFrom: aFiTrait className: aFiTrait name classIsMeta: false)
			"nextPutAll: (self monticelloMethodDefinitionsFrom: aFiClass metaclass className: aFiClass theName classIsMeta: true)" ]
]

{ #category : #reading }
FiMonticelloReader >> read: aFiPackage [
	
	^ MCSnapshot fromDefinitions: (self monticelloDefinitionsFrom: aFiPackage)
]

{ #category : #private }
FiMonticelloReader >> typeOfClassFrom: aFiClass [ 
	
	self flag: #todo. "fix!"
	^ #normal
]
