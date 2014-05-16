Class {
	#name : #FiMonticelloUnmarshaler,
	#superclass : #Object,
	#category : #'FicusMonticello-Marshaling'
}

{ #category : #private }
FiMonticelloUnmarshaler >> classInstVarNamesFrom: aFiClass [ 
	
	^ aFiClass metaclass layout slotNames values
]

{ #category : #private }
FiMonticelloUnmarshaler >> classVarNamesFrom: aFiClass [ 
	
	^ aFiClass classPool values
]

{ #category : #private }
FiMonticelloUnmarshaler >> instVarNamesFrom: aFiClass [ 
	
	^ aFiClass layout slotNames values
]

{ #category : #private }
FiMonticelloUnmarshaler >> monticelloClassDefinitionFrom: aFiClass [ 

	^ MCClassDefinition
		name: aFiClass theName
		superclassName: aFiClass superclass
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
FiMonticelloUnmarshaler >> monticelloClassDefinitionsFrom: aFiClass [

	^ Array streamContents: [ :stream | 
		stream 
			nextPut: (self monticelloClassDefinitionFrom: aFiClass);
			nextPutAll: (self monticelloMethodDefinitionsFrom: aFiClass className: aFiClass theName classIsMeta: false);
			nextPutAll: (self monticelloMethodDefinitionsFrom: aFiClass metaclass className: aFiClass theName classIsMeta: true) ]
]

{ #category : #private }
FiMonticelloUnmarshaler >> monticelloDefinitionsFrom: aFiDictionary [ 

	| definitions |
	definitions := Set new.
	
	aFiDictionary stepsAndValuesDo: [ :className :aFicusShot |
		definitions addAll: 
			(aFicusShot isTrait
				ifTrue: [ self monticelloTraitDefinitionsFrom: aFicusShot ]
				ifFalse: [ self monticelloClassDefinitionsFrom: aFicusShot ]) ].
	
	^ definitions
]

{ #category : #private }
FiMonticelloUnmarshaler >> monticelloMethodDefinitionsFrom: aFicusBehavior className: className classIsMeta: classIsMeta [

	| methods |
	methods := Set new.

	aFicusBehavior methods stepsAndValuesDo: [ :selector :aFicusMethod | 
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
FiMonticelloUnmarshaler >> monticelloTraitDefinitionFrom: aFiTrait [

	^ MCTraitDefinition
		name: aFiTrait theName
		traitComposition: aFiTrait traitComposition
		category: aFiTrait category
		comment: aFiTrait comment
		commentStamp: ''
]

{ #category : #private }
FiMonticelloUnmarshaler >> monticelloTraitDefinitionsFrom: aFiTrait [

	^ Array streamContents: [ :stream | 
		stream 
			nextPut: (self monticelloTraitDefinitionFrom: aFiTrait);
			nextPutAll: (self monticelloMethodDefinitionsFrom: aFiTrait className: aFiTrait theName classIsMeta: false)
			"nextPutAll: (self monticelloMethodDefinitionsFrom: aFiClass metaclass className: aFiClass theName classIsMeta: true)" ]
]

{ #category : #private }
FiMonticelloUnmarshaler >> typeOfClassFrom: aFiClass [ 
	
	^ #normal
]

{ #category : #unmarshaling }
FiMonticelloUnmarshaler >> unmarshaled: aFiDictionary [ 
	
	^ MCSnapshot fromDefinitions: (self monticelloDefinitionsFrom: aFiDictionary)
]
