Extension { #name : #SystemNavigation }

{ #category : #'*FicusRing' }
SystemNavigation >> allBehaviorsDo: aBlock [ 
	"Execute a block on each class, metaclass, trait and trait class"
	
	self environment allClassesDo: [ :aClass | 
		aBlock value: aClass ; 
			value: aClass classSide
	].
	
	self environment allTraitsDo: [ :aTrait |
		aBlock value:  aTrait ;
			value: aTrait classTrait
	]

]

{ #category : #'*FicusRing' }
SystemNavigation >> allClassesAndTraits [
	"Answer all the classes and traits present in the image"
	"Note that metaclasses are not part of the answer"
	
	^ self environment allClassesAndTraits

	
]

{ #category : #'*FicusRing' }
SystemNavigation >> allClassesInPackageNamed: packageName [
	"Returns the list of classes that belongs to a Monticello package."
	
	"It would be probably better to delegate that query to the package itself"
	| classes organization |
	organization := self environment organization.
	classes := (organization classesInCategory: packageName) asSet.
	(organization categoriesMatching: packageName, '-*') do: [:category| 
		classes addAll: (organization classesInCategory: category)].
	^classes asArray
]

{ #category : #'*FicusRing' }
SystemNavigation >> browseClassCommentsWithString: aString matchCase: caseSensitive [
	"Smalltalk browseClassCommentsWithString: 'my instances' "
	"Launch a message list browser on all class comments containing aString as a substring."

	|  suffix list |
	suffix := caseSensitive 
		ifTrue: [' (case-sensitive)']
		ifFalse: [' (case-insensitive)'].
	list := Set new.
	Cursor wait showWhile: [
		self environment allClassesDo: [:class | 
			(class organization classComment asString 
							includesSubstring: aString caseSensitive: caseSensitive) ifTrue: [
								list add: (RGCommentDefinition realClass: class)
							]
		]
	].
	^ self 
		browseMessageList: list asSortedCollection
		name: 'Class comments containing ' , aString printString , suffix
		autoSelect: aString
]

{ #category : #'*FicusRing' }
SystemNavigation >> removeAllButPackages: packagesList [
  "Remove all classes and methods that do not belong to some of listed packages. Skip #unload. Do not use this method if you can use Monticello! This method is used by some low-level shrinking process. Do not use it. This is quite hackish"

  | keep remove oldRemove extensionCategories |
  keep := Set new.      
  packagesList do: [:pkg | keep addAll: (self allClassesInPackageNamed: pkg)].
  oldRemove := Set new.
  [ 
    remove := self environment allClassesAndTraits reject: [:c | keep includes: c].
    remove := remove collect: [:c | c name].
    (remove asSortedCollection: [:a :b | a  <= b ]) do: [:className |
      | class |
      class := (self environment classOrTraitNamed: className).
      class allSubclasses ifEmpty: [
        SystemAnnouncer uniqueInstance unsubscribe: class.
        class isTrait ifFalse: [ 
          (class class includesSelector: #unload) ifTrue: [ class removeSelector: #unload ] ].
        class removeFromSystem. 
        ] ].

    
    oldRemove ifNotEmpty: [
      oldRemove = remove ifTrue: [          
         self error: 'Some classes still have subclasses: ', (remove collect: [:c | c -> (self environment classOrTraitNamed: c) allSubclasses]) asString ] ].
    oldRemove := remove.
    remove notEmpty] whileTrue.

  keep do: [: class | 
    extensionCategories := (class organization ownCategories select: [:category | 
      category first = $*]) asOrderedCollection.
    extensionCategories removeAllSuchThat: [:category |
      packagesList anySatisfy: [:package |
        ((category asLowercase allButFirst = package asLowercase) or: [package asLowercase, '-*' match: category asLowercase allButFirst])]].
    extensionCategories do: [:category | 
      | protocol |
      protocol := class organization  protocolOrganizer protocolNamed: category.
      (protocol methods intersection: class localSelectors) do: [:sel | class removeSelector: sel ].
      "class removeProtocol: category" ]. 
    class isTrait ifFalse: [
      extensionCategories := (class class organization ownCategories select: [:category | 
        category first = $*]) asOrderedCollection.
      extensionCategories removeAllSuchThat: [:category |
        packagesList anySatisfy: [:package |
          ((category asLowercase allButFirst = package asLowercase) or: [package asLowercase, '-*' match: category asLowercase allButFirst])]].
      extensionCategories do: [:category | 
        | protocol |
        protocol := class class organization  protocolOrganizer protocolNamed: category.
        (protocol methods intersection: class class localSelectors) do: [:sel | class class removeSelector: sel ].
        "class class removeProtocol: category" ]]].
      

]
