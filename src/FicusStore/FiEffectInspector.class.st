Class {
	#name : #FiEffectInspector,
	#superclass : #ComposableModel,
	#instVars : [
		'treeModel',
		'iconByClassName',
		'diffModel',
		'currentSelection',
		'plugin'
	],
	#category : #'FicusStore-UI'
}

{ #category : #specs }
FiEffectInspector class >> defaultSpec [
	<spec>
	
	^ SpecLayout composed
		newColumn: [ :column |
			column 
				add: #treeModel origin: 0@0 corner: 1@0.6;
				addSplitter;
				add: #diffModel origin: 0@0.6 corner: 1@1];
		yourself.

]

{ #category : #specs }
FiEffectInspector class >> defaultSpecAsRow [
	<spec>
	
	^ SpecLayout composed
		newRow: [ :row |
			row 
				add: #treeModel origin: 0@0 corner: 0.3@1;
				addSplitter;
				add: #diffModel origin: 0.3@0 corner: 1@1];
		yourself.

]

{ #category : #inspecting }
FiEffectInspector class >> inspect: rootEffect [

	^ (self newWith: rootEffect) 
		plugin: FiNullStoreBrowserPlugin new;
		open; 
		yourself
]

{ #category : #inspecting }
FiEffectInspector class >> newWith: aRootEffect [

	^ self new
		rootEffect: aRootEffect;
		yourself
]

{ #category : #private }
FiEffectInspector >> diffChunkMorphFor: aSimpleEffect [

	^ FiMorphBuilder default columnMorphWithAll: { 
		self pathMorphWith: aSimpleEffect path.
		self diffMorphFrom: aSimpleEffect oldValueString to: aSimpleEffect newValueString }
]

{ #category : #private }
FiEffectInspector >> diffChunkMorphsFor: anEffectOrNil [

	^ Array 
		streamContents: [ :stream |
			anEffectOrNil
				leavesDo: [ :aSimpleEffect | 
					stream nextPut: (self diffChunkMorphFor: aSimpleEffect) ] ] 
		limitedTo: 15
]

{ #category : #accessing }
FiEffectInspector >> diffModel [

	^ diffModel
]

{ #category : #private }
FiEffectInspector >> diffMorphFrom: aString to: otherString [

"	^ (DiffMorph from: aString to: otherString)
			showOptions: false;
			width: 400;
			height: 200;
			yourself
"
	^ (TextDiffBuilder 
		buildDisplayPatchFrom: aString
		to: otherString) asMorph
		lock: true;
		yourself

]

{ #category : #private }
FiEffectInspector >> displayMorphFor: aSimpleEffect [
		
	| morphs |
	morphs := OrderedCollection new.

	morphs add: aSimpleEffect path step asMorph.
	
	self plugin 
		prepareEffectInspectorTreeMorphs: morphs 
		for: aSimpleEffect.
	
	^ FiMorphBuilder default rowMorphWithAll: morphs
]

{ #category : #private }
FiEffectInspector >> iconFor: aShot [

	aShot isShot ifFalse: [ ^ Smalltalk ui icons stringIcon ].

	^ Smalltalk ui icons perform: 
		(iconByClassName 
			at: aShot species name 
			ifAbsent: [ #smallHierarchyBrowserIcon "#nautilusIcon" "#emptyIcon" ])
]

{ #category : #initialization }
FiEffectInspector >> initialize [

	super initialize.
	self initializeIconByClassName.	

]

{ #category : #initialization }
FiEffectInspector >> initializeIconByClassName [

	iconByClassName := 
		Dictionary new
			at: #FiAddition put: #changeAddIcon;
			at: #FiRemoval put: #changeRemoveIcon;
			at: #FiUpdate put: #changeUpdateIcon;
			yourself.
	
]

{ #category : #initialization }
FiEffectInspector >> initializePresenter [
	
	super initializePresenter.
	
	self 
		windowIcon: Smalltalk ui icons smallInspectItIcon;
		title: 'Ficus Effects Inspector'.
 
	treeModel
		evenRowColor: treeModel oddRowColor;
		displayBlock: [ :aSimpleEffect | self displayMorphFor: aSimpleEffect ];
		childrenBlock: [ :aSimpleEffect | aSimpleEffect children asArray ];
		iconBlock: [ :aSimpleEffect | self iconFor: aSimpleEffect ];
		autoDeselection:true;
		whenRootsChanged: [ 
			self flag: #fix. "Workaround: Spec in Pharo3 does not trigger that selection changed 
				when it changed due to roots update."
			self showDiffFor: nil ];
		whenSelectedItemChanged: [ :aSimpleEffectOrNil | 
			self showDiffFor: aSimpleEffectOrNil value ].

	diffModel
		displayBlock: [ :morph | morph ]
]

{ #category : #initialization }
FiEffectInspector >> initializeWidgets [ 

	self instantiateModels: #(
		treeModel TreeModel
		diffModel TreeModel )
]

{ #category : #opening }
FiEffectInspector >> open [

	self
		extent: 800@600;
		openWithSpec.

	"It has no effect if applied before opening:"		
	treeModel expandAll

]

{ #category : #private }
FiEffectInspector >> pathMorphWith: aPath [

	| separator |
	separator := 
		'  /  ' asText 
			addAttribute: (TextColor color: Color lightGray); 
			addAttribute: (TextFontChange fontNumber: 1); 
			yourself. 
	
	^ (separator join: (aPath steps collect: [ :each | 
			each asString asText 
				addAttribute: (TextColor color: Color darkGray); 
				addAttribute: (TextFontChange fontNumber: 2); 
				yourself ])) 
		asMorph
		lock: true;
		yourself
]

{ #category : #accessing }
FiEffectInspector >> plugin [

	^ plugin
]

{ #category : #accessing }
FiEffectInspector >> plugin: aPlugin [

	plugin := aPlugin
]

{ #category : #opening }
FiEffectInspector >> rootEffect: anEffect [

	treeModel roots: (self treeRootsFor: anEffect).

	treeModel expandAll

]

{ #category : #private }
FiEffectInspector >> showDiffFor: anEffectOrNil [ 

	self flag: #fix. "Workaround: Spec in Pharo3 triggers several times the same event."
	currentSelection = anEffectOrNil ifTrue: [ ^ self ].
	currentSelection := anEffectOrNil.

	diffModel roots: 
		(anEffectOrNil 
			ifNil: [ #() ]
			ifNotNil: [ self diffChunkMorphsFor: anEffectOrNil ])
]

{ #category : #accessing }
FiEffectInspector >> treeModel [

	^ treeModel
]

{ #category : #private }
FiEffectInspector >> treeRootsFor: anEffect [

	^ anEffect asSimpleEffects asArray
	
]
