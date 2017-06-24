Extension { #name : #TApplyingOnClassSide }

{ #category : #'*FicusRing-override' }
TApplyingOnClassSide >> obsoleteSubclasses [
	"Answer the receiver's subclasses."
	self theNonMetaClass == nil ifTrue:[^#()].
	^self theNonMetaClass obsoleteSubclasses 
		select:[:aSubclass| aSubclass isMeta not] 
		thenCollect:[:aSubclass| aSubclass classSide ]

	"Metaclass allInstancesDo:
		[:m | Compiler evaluate: 'subclasses:=nil' for: m logged: false]"
]

{ #category : #'*FicusRing-override' }
TApplyingOnClassSide >> subclasses [
	"Answer the receiver's subclasses."
	self theNonMetaClass == nil ifTrue:[^#()].
	^self theNonMetaClass subclasses 
		select:[:aSubclass| aSubclass isMeta not] 
		thenCollect:[:aSubclass| aSubclass classSide ]

	"Metaclass allInstancesDo:
		[:m | Compiler evaluate: 'subclasses:=nil' for: m logged: false]"
]

{ #category : #'*FicusRing-override' }
TApplyingOnClassSide >> subclassesDo: aBlock [
	"Evaluate aBlock for each of the receiver's immediate subclasses."
	self theNonMetaClass subclassesDo:[:aSubclass|
		"The following test is for Class class which has to exclude
		the Metaclasses being subclasses of Class."
		aSubclass isMeta ifFalse:[aBlock value: aSubclass classSide ]].
]
