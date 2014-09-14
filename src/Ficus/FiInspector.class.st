Class {
	#name : #FiInspector,
	#superclass : #ComposableModel,
	#instVars : [
		'treeModel',
		'contentsModel',
		'iconByClassName',
		'currentSelection'
	],
	#category : #'Ficus-UI'
}

{ #category : #specs }
FiInspector class >> defaultSpec [
	<spec>

	^ SpecLayout composed
		newColumn: [ :column |
			column 
				add: #treeModel origin: 0@0 corner: 1@0.6;
				addSplitter;
				add: #contentsModel origin: 0@0.6 corner: 1@1];
		yourself.

]

{ #category : #inspecting }
FiInspector class >> inspect: aRootShot [

	^ (self newWith: { #root -> aRootShot })
		open;
		yourself
]

{ #category : #inspecting }
FiInspector class >> inspectEffect: rootEffect [

	| stepsAndSets stepsAndValues |	
	stepsAndSets := 
		rootEffect flattenedLeafEffects
			inject: Dictionary new
			into: [ :dict :each | 
				(dict 
					at: each key asString
					ifAbsentPut: [ OrderedCollection new ])
					add: each value.
				dict ].

	stepsAndValues := 
		stepsAndSets associations 
			inject: Dictionary new
			into: [ :dict :each | 
				dict 
					at: each key
					put: (FiSet withValues: each value).
				dict ].

	^ (self newWith: stepsAndValues associations) open; yourself
]

{ #category : #inspecting }
FiInspector class >> newWith: someAssociations [

	^ self new
		rootAssociations: someAssociations;
		yourself
]

{ #category : #accessing }
FiInspector >> contentsModel [

	^ contentsModel
]

{ #category : #accessing }
FiInspector >> emptyRoots [

	self rootAssociations: #()
]

{ #category : #private }
FiInspector >> iconFor: aShot [

	aShot isShot ifFalse: [ ^ Smalltalk ui icons stringIcon ].

	^ Smalltalk ui icons perform: 
		(iconByClassName 
			at: aShot species name 
			ifAbsent: [ #smallHierarchyBrowserIcon "#nautilusIcon" "#emptyIcon" ])
]

{ #category : #initialization }
FiInspector >> initialize [

	super initialize.

	self initializeIconByClassName.	

]

{ #category : #initialization }
FiInspector >> initializeIconByClassName [

	iconByClassName := 
		Dictionary new
			"effects"
			at: #FiDictionaryAddition put: #changeAddIcon;
			at: #FiDictionaryRemoval put: #changeRemoveIcon;
			at: #FiDictionaryUpdate put: #changeUpdateIcon;

			at: #FiSetAddition put: #changeAddIcon;
			at: #FiSetRemoval put: #changeRemoveIcon;
			at: #FiSetUpdate put: #changeUpdateIcon;

			at: #FiReplacement put: #changeUpdateIcon;
			
			"meta"
			at: #FiPackage put: #packageIcon;
			at: #FiClass put: #classIcon;
			at: #FiMetaclass put: #classIcon;
			at: #FiTrait put: #traitIcon;
			at: #FiMethod put: #testGreenIcon;
			
			"core"
			at: #FiSet put: #collectionIcon;
			at: #FiDictionary put: #collectionIcon;

			yourself.
	
]

{ #category : #initialization }
FiInspector >> initializePresenter [
	
	self 
		windowIcon: Smalltalk ui icons smallInspectItIcon;
		title: 'Ficus Inspector'.

	contentsModel
		displayBlock: [ :morph | morph ].
		
	treeModel
		evenRowColor: treeModel oddRowColor;
		displayBlock: [ :assoc | assoc key asMorph ];
		childrenBlock: [ :assoc | 
			assoc value isShot 
				ifTrue: [ assoc value stepsAndValues sorted: [ :a :b | a key < b key ] ]
				ifFalse: [ #() ] ];
		iconBlock: [ :assoc | self iconFor: assoc value ];
		autoDeselection:true;
		whenRootsChanged: [ 
			self flag: #fix. "Workaround: Spec in Pharo3 does not trigger that selection changed 
				when it changed due to roots update."
			self showContentsFor: nil ];
		whenSelectedItemChanged: [ :assocOrNil | 
			self showContentsFor: assocOrNil ].


]

{ #category : #initialization }
FiInspector >> initializeWidgets [ 
	
	self instantiateModels: #(
		treeModel			TreeModel
		contentsModel	TreeModel)


]

{ #category : #opening }
FiInspector >> open [

	self
		extent: 700@600;
		openWithSpec.

	"It has no effect if applied before opening:"		
	treeModel expandAll

]

{ #category : #accessing }
FiInspector >> rootAssociations: someAssociations [

	treeModel roots: someAssociations.
	
	treeModel expandRoots
]

{ #category : #accessing }
FiInspector >> rootShot: aShot [

	self rootAssociations: { #root -> aShot }
]

{ #category : #initialization }
FiInspector >> showContentsFor: assocOrNil [

	self flag: #fix. "Workaround: Spec in Pharo3 triggers several times the same event."
	currentSelection = assocOrNil ifTrue: [ ^ self ].
	currentSelection := assocOrNil.

	assocOrNil ifNil: [ ^ contentsModel roots: #() ].
	
	contentsModel roots: {assocOrNil value asString asText asMorph lock: true; yourself}

]

{ #category : #private }
FiInspector >> stringMorphWith: aString color: aColor [

	^ aString asMorph
		color: aColor;
		yourself
]

{ #category : #accessing }
FiInspector >> treeModel [

	^ treeModel
]
