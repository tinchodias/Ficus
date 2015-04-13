"
I am an inspector for instances of FiShot.
"
Class {
	#name : #FiInspector,
	#superclass : #ComposableModel,
	#instVars : [
		'treeModel',
		'contentsModel',
		'iconByClassName'
	],
	#category : #'FicusStore-UI-Widgets'
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
	"
	self inspect: #(1 2 3 4 5) asFiSet 
	"

	^ self new 
		rootShot: aRootShot;
		open;
		yourself
]

{ #category : #private }
FiInspector >> contentsFor: inspectorItemOrNil [

	| morphBuilder |	
	inspectorItemOrNil ifNil: [ ^ #() ].
	
	self flag: #fix. "Just use a text model?"

	morphBuilder := FiMorphBuilder default.
	^ { morphBuilder columnMorphWithAll: { 
			morphBuilder pathMorphWith: inspectorItemOrNil path.
			morphBuilder stringMorphWith: inspectorItemOrNil content ficusInspectorDefinitionString asText }}

]

{ #category : #accessing }
FiInspector >> contentsModel [

	^ contentsModel
]

{ #category : #accessing }
FiInspector >> emptyRoots [

	self rootInspectorItems: #()
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
		displayBlock: [ :inspectorItem | inspectorItem step ];
		childrenBlock: [ :inspectorItem | inspectorItem children ];
		iconBlock: [ :inspectorItem | inspectorItem content ficusInspectorIcon ];
		autoDeselection: true;
		whenRootsChanged: [ 
			self flag: #fix. "Workaround: Spec in Pharo3 does not trigger that selection changed 
				when it changed due to roots update."
			self showContentsFor: nil ];
		whenSelectedItemChanged: [ :inspectorItem | 
			self showContentsFor: inspectorItem ].


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
FiInspector >> rootInspectorItems: inspectorItems [

	treeModel roots: inspectorItems.
	
	"treeModel expandRoots"
]

{ #category : #accessing }
FiInspector >> rootShot: aShot [

	self rootInspectorItems: 
		(FiInspectorItem new 
			content: aShot;
			path: FiPath root;
			yourself) children
]

{ #category : #private }
FiInspector >> showContentsFor: inspectorItemOrNil [

	contentsModel roots: (self contentsFor: inspectorItemOrNil)
]

{ #category : #accessing }
FiInspector >> treeModel [

	^ treeModel
]
